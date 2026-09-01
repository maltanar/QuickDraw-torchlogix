FROM rocm/pytorch:latest

# Set environment variables for noninteractive package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install source-control tooling needed for Git-based Python dependencies.
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install the project.
WORKDIR /workspace/quickdraw-torchlogix
COPY . /workspace/quickdraw-torchlogix
RUN pip install --no-cache-dir .

# Set default command
CMD ["bash"]
