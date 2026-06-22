import torch
import torch.nn as nn

try:
    from torchlogix.layers import (
        DummyBinarization,
        FixedBinarization,
        GroupSum,
        LogicConv2d,
        LogicDense,
        OrPooling2d,
    )
except ImportError as exc:
    raise ImportError(
        "torchlogix is required for logic models. Install with: pip install torchlogix"
    ) from exc


class QuickDrawLogicConvNet(nn.Module):
    """Convolutional logic network for 28x28 Quick, Draw! images."""

    def __init__(
        self,
        num_classes,
        image_size=28,
        conv_channels=(16,),
        dense_dims=(4000, 4000),
        tree_depth=2,
        receptive_field_size=3,
        conv_stride=1,
        conv_padding=0,
        tau=8.0,
        input_binarization="fixed",
        input_threshold=0.0,
        parametrization="raw",
        lut_rank=2,
        connections="fixed",
        connections_kwargs=None,
    ):
        super().__init__()

        if image_size <= 0:
            raise ValueError("image_size must be > 0")
        if len(conv_channels) == 0:
            raise ValueError("conv_channels must contain at least one layer width")
        if len(dense_dims) == 0:
            raise ValueError("dense_dims must contain at least one layer width")

        connections_kwargs = connections_kwargs or {}

        if input_binarization == "fixed":
            self.input_binarization = FixedBinarization(thresholds=[float(input_threshold)])
        elif input_binarization == "dummy":
            self.input_binarization = DummyBinarization()
        elif input_binarization == "none":
            self.input_binarization = nn.Identity()
        else:
            raise ValueError(
                "input_binarization must be one of ['fixed', 'dummy', 'none']"
            )

        layers = []
        spatial_dim = int(image_size)
        in_channels = 1

        for out_channels in conv_channels:
            layers.append(
                LogicConv2d(
                    in_dim=spatial_dim,
                    channels=in_channels,
                    num_kernels=int(out_channels),
                    tree_depth=int(tree_depth),
                    receptive_field_size=int(receptive_field_size),
                    stride=int(conv_stride),
                    padding=int(conv_padding),
                    lut_rank=int(lut_rank),
                    parametrization=parametrization,
                    connections=connections,
                    connections_kwargs=connections_kwargs,
                )
            )
            spatial_dim = (
                spatial_dim + 2 * int(conv_padding) - int(receptive_field_size)
            ) // int(conv_stride) + 1
            if spatial_dim <= 0:
                raise ValueError(
                    "Invalid conv topology: spatial dimension became non-positive. "
                    "Reduce depth/receptive field or increase padding."
                )

            layers.append(OrPooling2d(kernel_size=2, stride=2, padding=0))
            spatial_dim = (spatial_dim - 2) // 2 + 1
            if spatial_dim <= 0:
                raise ValueError(
                    "Invalid pooling topology: spatial dimension became non-positive."
                )

            in_channels = int(out_channels)

        layers.append(torch.nn.Flatten())

        in_dim = in_channels * spatial_dim * spatial_dim
        for hidden_dim in dense_dims:
            layers.append(
                LogicDense(
                    in_dim=in_dim,
                    out_dim=int(hidden_dim),
                    lut_rank=int(lut_rank),
                    parametrization=parametrization,
                    connections=connections,
                    connections_kwargs=connections_kwargs,
                )
            )
            in_dim = int(hidden_dim)

        if in_dim % num_classes != 0:
            raise ValueError(
                f"Final dense dimension ({in_dim}) must be divisible by num_classes ({num_classes}) "
                "for GroupSum(k=num_classes)."
            )

        layers.append(GroupSum(k=num_classes, tau=float(tau)))

        self.logic = torch.nn.Sequential(*layers)

    def forward(self, x):
        x = self.input_binarization(x)
        return self.logic(x)


def quickdraw_logic_convnet(
    num_classes,
    image_size=28,
    conv_channels=(16,),
    dense_dims=(4000, 4000),
    tree_depth=2,
    receptive_field_size=3,
    conv_stride=1,
    conv_padding=0,
    tau=8.0,
    input_binarization="fixed",
    input_threshold=0.0,
    parametrization="raw",
    lut_rank=2,
    connections="fixed",
    connections_kwargs=None,
):
    return QuickDrawLogicConvNet(
        num_classes=num_classes,
        image_size=image_size,
        conv_channels=conv_channels,
        dense_dims=dense_dims,
        tree_depth=tree_depth,
        receptive_field_size=receptive_field_size,
        conv_stride=conv_stride,
        conv_padding=conv_padding,
        tau=tau,
        input_binarization=input_binarization,
        input_threshold=input_threshold,
        parametrization=parametrization,
        lut_rank=lut_rank,
        connections=connections,
        connections_kwargs=connections_kwargs,
    )


class MnistTutorialLogicConvNet(nn.Module):
    """Exact torchlogix MNIST tutorial architecture."""

    def __init__(self, tau=8.0):
        super().__init__()
        self.logic = nn.Sequential(
            LogicConv2d(in_dim=28, channels=1, num_kernels=16, tree_depth=2, receptive_field_size=3),
            OrPooling2d(kernel_size=2, stride=2, padding=0),
            nn.Flatten(),
            LogicDense(16 * 13 * 13, 4000),
            LogicDense(4000, 4000),
            GroupSum(k=10, tau=float(tau)),
        )

    def forward(self, x):
        return self.logic(x)


def mnist_tutorial_logic_convnet(tau=8.0):
    return MnistTutorialLogicConvNet(tau=tau)
