module layer0 (input [783:0] M0, output [639:0] M1);

wire [3:0] layer0_N0_wire = {M0[601], M0[600], M0[602], M0[576]};
wire [15:0] layer0_N0_lut = 16'hFFFC;
assign M1[0] = layer0_N0_lut[layer0_N0_wire];

wire [3:0] layer0_N1_wire = {M0[601], M0[602], M0[714], M0[654]};
wire [15:0] layer0_N1_lut = 16'hFCCC;
assign M1[1] = layer0_N1_lut[layer0_N1_wire];

wire [3:0] layer0_N2_wire = {M0[602], M0[439], M0[416], M0[601]};
wire [15:0] layer0_N2_lut = 16'h51F2;
assign M1[2] = layer0_N2_lut[layer0_N2_wire];

wire [3:0] layer0_N3_wire = {M0[546], M0[600], M0[604], M0[545]};
wire [15:0] layer0_N3_lut = 16'hEADA;
assign M1[3] = layer0_N3_lut[layer0_N3_wire];

wire [3:0] layer0_N4_wire = {M0[483], M0[574], M0[575], M0[461]};
wire [15:0] layer0_N4_lut = 16'h3F34;
assign M1[4] = layer0_N4_lut[layer0_N4_wire];

wire [3:0] layer0_N5_wire = {M0[497], M0[469], M0[486], M0[525]};
wire [15:0] layer0_N5_lut = 16'h135F;
assign M1[5] = layer0_N5_lut[layer0_N5_wire];

wire [3:0] layer0_N6_wire = {M0[483], M0[440], M0[467], M0[395]};
wire [15:0] layer0_N6_lut = 16'hFCC4;
assign M1[6] = layer0_N6_lut[layer0_N6_wire];

wire [3:0] layer0_N7_wire = {M0[573], M0[500], M0[516], M0[662]};
wire [15:0] layer0_N7_lut = 16'hE0F0;
assign M1[7] = layer0_N7_lut[layer0_N7_wire];

wire [3:0] layer0_N8_wire = {M0[257], M0[230], M0[256], M0[493]};
wire [15:0] layer0_N8_lut = 16'h3E33;
assign M1[8] = layer0_N8_lut[layer0_N8_wire];

wire [3:0] layer0_N9_wire = {M0[575], M0[548], M0[579], M0[577]};
wire [15:0] layer0_N9_lut = 16'h0011;
assign M1[9] = layer0_N9_lut[layer0_N9_wire];

wire [3:0] layer0_N10_wire = {M0[349], M0[545], M0[350], M0[495]};
wire [15:0] layer0_N10_lut = 16'h0FBF;
assign M1[10] = layer0_N10_lut[layer0_N10_wire];

wire [3:0] layer0_N11_wire = {M0[542], M0[547], M0[515], M0[514]};
wire [15:0] layer0_N11_lut = 16'h90FF;
assign M1[11] = layer0_N11_lut[layer0_N11_wire];

wire [3:0] layer0_N12_wire = {M0[206], M0[209], M0[207], M0[205]};
wire [15:0] layer0_N12_lut = 16'hFDFC;
assign M1[12] = layer0_N12_lut[layer0_N12_wire];

wire [3:0] layer0_N13_wire = {M0[184], M0[213], M0[210], M0[208]};
wire [15:0] layer0_N13_lut = 16'hFFB2;
assign M1[13] = layer0_N13_lut[layer0_N13_wire];

wire [3:0] layer0_N14_wire = {M0[318], M0[182], M0[210], M0[262]};
wire [15:0] layer0_N14_lut = 16'hFEE0;
assign M1[14] = layer0_N14_lut[layer0_N14_wire];

wire [3:0] layer0_N15_wire = {M0[450], M0[238], M0[394], M0[712]};
wire [15:0] layer0_N15_lut = 16'hF8F8;
assign M1[15] = layer0_N15_lut[layer0_N15_wire];

wire [3:0] layer0_N16_wire = {M0[442], M0[332], M0[334], M0[361]};
wire [15:0] layer0_N16_lut = 16'h5405;
assign M1[16] = layer0_N16_lut[layer0_N16_wire];

wire [3:0] layer0_N17_wire = {M0[255], M0[387], M0[227], M0[219]};
wire [15:0] layer0_N17_lut = 16'h5B30;
assign M1[17] = layer0_N17_lut[layer0_N17_wire];

wire [3:0] layer0_N18_wire = {M0[219], M0[218], M0[128], M0[501]};
wire [15:0] layer0_N18_lut = 16'h6442;
assign M1[18] = layer0_N18_lut[layer0_N18_wire];

wire [3:0] layer0_N19_wire = {M0[443], M0[201], M0[229], M0[332]};
wire [15:0] layer0_N19_lut = 16'h3B02;
assign M1[19] = layer0_N19_lut[layer0_N19_wire];

wire [3:0] layer0_N20_wire = {M0[411], M0[563], M0[657], M0[483]};
wire [15:0] layer0_N20_lut = 16'hBF00;
assign M1[20] = layer0_N20_lut[layer0_N20_wire];

wire [3:0] layer0_N21_wire = {M0[510], M0[508], M0[296], M0[338]};
wire [15:0] layer0_N21_lut = 16'h5545;
assign M1[21] = layer0_N21_lut[layer0_N21_wire];

wire [3:0] layer0_N22_wire = {M0[219], M0[483], M0[247], M0[494]};
wire [15:0] layer0_N22_lut = 16'hCDCD;
assign M1[22] = layer0_N22_lut[layer0_N22_wire];

wire [3:0] layer0_N23_wire = {M0[479], M0[507], M0[539], M0[480]};
wire [15:0] layer0_N23_lut = 16'hCDFC;
assign M1[23] = layer0_N23_lut[layer0_N23_wire];

wire [3:0] layer0_N24_wire = {M0[618], M0[501], M0[514], M0[617]};
wire [15:0] layer0_N24_lut = 16'h0E0F;
assign M1[24] = layer0_N24_lut[layer0_N24_wire];

wire [3:0] layer0_N25_wire = {M0[618], M0[428], M0[429], M0[400]};
wire [15:0] layer0_N25_lut = 16'hCCEE;
assign M1[25] = layer0_N25_lut[layer0_N25_wire];

wire [3:0] layer0_N26_wire = {M0[653], M0[654], M0[576], M0[496]};
wire [15:0] layer0_N26_lut = 16'h45FF;
assign M1[26] = layer0_N26_lut[layer0_N26_wire];

wire [3:0] layer0_N27_wire = {M0[618], M0[501], M0[461], M0[272]};
wire [15:0] layer0_N27_lut = 16'h0C0E;
assign M1[27] = layer0_N27_lut[layer0_N27_wire];

wire [3:0] layer0_N28_wire = {M0[706], M0[271], M0[243], M0[238]};
wire [15:0] layer0_N28_lut = 16'h0053;
assign M1[28] = layer0_N28_lut[layer0_N28_wire];

wire [3:0] layer0_N29_wire = {M0[377], M0[315], M0[409], M0[521]};
wire [15:0] layer0_N29_lut = 16'h4666;
assign M1[29] = layer0_N29_lut[layer0_N29_wire];

wire [3:0] layer0_N30_wire = {M0[373], M0[402], M0[374], M0[403]};
wire [15:0] layer0_N30_lut = 16'h42CB;
assign M1[30] = layer0_N30_lut[layer0_N30_wire];

wire [3:0] layer0_N31_wire = {M0[193], M0[210], M0[396], M0[209]};
wire [15:0] layer0_N31_lut = 16'h0051;
assign M1[31] = layer0_N31_lut[layer0_N31_wire];

wire [3:0] layer0_N32_wire = {M0[459], M0[399], M0[484], M0[277]};
wire [15:0] layer0_N32_lut = 16'hAFAF;
assign M1[32] = layer0_N32_lut[layer0_N32_wire];

wire [3:0] layer0_N33_wire = {M0[444], M0[69], M0[416], M0[450]};
wire [15:0] layer0_N33_lut = 16'h1051;
assign M1[33] = layer0_N33_lut[layer0_N33_wire];

wire [3:0] layer0_N34_wire = {M0[185], M0[268], M0[145], M0[283]};
wire [15:0] layer0_N34_lut = 16'hDD4D;
assign M1[34] = layer0_N34_lut[layer0_N34_wire];

wire [3:0] layer0_N35_wire = {M0[410], M0[230], M0[409], M0[243]};
wire [15:0] layer0_N35_lut = 16'hFF58;
assign M1[35] = layer0_N35_lut[layer0_N35_wire];

wire [3:0] layer0_N36_wire = {M0[716], M0[210], M0[96], M0[95]};
wire [15:0] layer0_N36_lut = 16'h5701;
assign M1[36] = layer0_N36_lut[layer0_N36_wire];

wire [3:0] layer0_N37_wire = {M0[124], M0[150], M0[483], M0[187]};
wire [15:0] layer0_N37_lut = 16'h5D5F;
assign M1[37] = layer0_N37_lut[layer0_N37_wire];

wire [3:0] layer0_N38_wire = {M0[128], M0[241], M0[212], M0[147]};
wire [15:0] layer0_N38_lut = 16'hABC8;
assign M1[38] = layer0_N38_lut[layer0_N38_wire];

wire [3:0] layer0_N39_wire = {M0[148], M0[149], M0[92], M0[597]};
wire [15:0] layer0_N39_lut = 16'h0103;
assign M1[39] = layer0_N39_lut[layer0_N39_wire];

wire [3:0] layer0_N40_wire = {M0[554], M0[374], M0[526], M0[480]};
wire [15:0] layer0_N40_lut = 16'h3175;
assign M1[40] = layer0_N40_lut[layer0_N40_wire];

wire [3:0] layer0_N41_wire = {M0[432], M0[509], M0[481], M0[430]};
wire [15:0] layer0_N41_lut = 16'h8A54;
assign M1[41] = layer0_N41_lut[layer0_N41_wire];

wire [3:0] layer0_N42_wire = {M0[374], M0[161], M0[181], M0[446]};
wire [15:0] layer0_N42_lut = 16'h5D51;
assign M1[42] = layer0_N42_lut[layer0_N42_wire];

wire [3:0] layer0_N43_wire = {M0[369], M0[342], M0[314], M0[255]};
wire [15:0] layer0_N43_lut = 16'hEAAB;
assign M1[43] = layer0_N43_lut[layer0_N43_wire];

wire [3:0] layer0_N44_wire = {M0[567], M0[595], M0[596], M0[568]};
wire [15:0] layer0_N44_lut = 16'h0307;
assign M1[44] = layer0_N44_lut[layer0_N44_wire];

wire [3:0] layer0_N45_wire = {M0[567], M0[566], M0[580], M0[585]};
wire [15:0] layer0_N45_lut = 16'hEEE2;
assign M1[45] = layer0_N45_lut[layer0_N45_wire];

wire [3:0] layer0_N46_wire = {M0[551], M0[566], M0[565], M0[584]};
wire [15:0] layer0_N46_lut = 16'hFEAE;
assign M1[46] = layer0_N46_lut[layer0_N46_wire];

wire [3:0] layer0_N47_wire = {M0[628], M0[627], M0[632], M0[630]};
wire [15:0] layer0_N47_lut = 16'h0001;
assign M1[47] = layer0_N47_lut[layer0_N47_wire];

wire [3:0] layer0_N48_wire = {M0[609], M0[610], M0[278], M0[636]};
wire [15:0] layer0_N48_lut = 16'hFFFE;
assign M1[48] = layer0_N48_lut[layer0_N48_wire];

wire [3:0] layer0_N49_wire = {M0[288], M0[529], M0[92], M0[530]};
wire [15:0] layer0_N49_lut = 16'hFCFC;
assign M1[49] = layer0_N49_lut[layer0_N49_wire];

wire [3:0] layer0_N50_wire = {M0[293], M0[707], M0[490], M0[462]};
wire [15:0] layer0_N50_lut = 16'hA8F0;
assign M1[50] = layer0_N50_lut[layer0_N50_wire];

wire [3:0] layer0_N51_wire = {M0[188], M0[401], M0[296], M0[389]};
wire [15:0] layer0_N51_lut = 16'hF5F0;
assign M1[51] = layer0_N51_lut[layer0_N51_wire];

wire [3:0] layer0_N52_wire = {M0[313], M0[489], M0[400], M0[547]};
wire [15:0] layer0_N52_lut = 16'h5555;
assign M1[52] = layer0_N52_lut[layer0_N52_wire];

wire [3:0] layer0_N53_wire = {M0[629], M0[628], M0[545], M0[546]};
wire [15:0] layer0_N53_lut = 16'hEEF3;
assign M1[53] = layer0_N53_lut[layer0_N53_wire];

wire [3:0] layer0_N54_wire = {M0[628], M0[599], M0[600], M0[601]};
wire [15:0] layer0_N54_lut = 16'hD18C;
assign M1[54] = layer0_N54_lut[layer0_N54_wire];

wire [3:0] layer0_N55_wire = {M0[628], M0[546], M0[527], M0[545]};
wire [15:0] layer0_N55_lut = 16'hACA8;
assign M1[55] = layer0_N55_lut[layer0_N55_wire];

wire [3:0] layer0_N56_wire = {M0[605], M0[376], M0[449], M0[490]};
wire [15:0] layer0_N56_lut = 16'hBB8A;
assign M1[56] = layer0_N56_lut[layer0_N56_wire];

wire [3:0] layer0_N57_wire = {M0[490], M0[518], M0[519], M0[402]};
wire [15:0] layer0_N57_lut = 16'hFFEE;
assign M1[57] = layer0_N57_lut[layer0_N57_wire];

wire [3:0] layer0_N58_wire = {M0[605], M0[584], M0[660], M0[571]};
wire [15:0] layer0_N58_lut = 16'hFAAA;
assign M1[58] = layer0_N58_lut[layer0_N58_wire];

wire [3:0] layer0_N59_wire = {M0[549], M0[550], M0[522], M0[155]};
wire [15:0] layer0_N59_lut = 16'h0083;
assign M1[59] = layer0_N59_lut[layer0_N59_wire];

wire [3:0] layer0_N60_wire = {M0[440], M0[548], M0[547], M0[313]};
wire [15:0] layer0_N60_lut = 16'hFF54;
assign M1[60] = layer0_N60_lut[layer0_N60_wire];

wire [3:0] layer0_N61_wire = {M0[457], M0[315], M0[343], M0[719]};
wire [15:0] layer0_N61_lut = 16'hFF00;
assign M1[61] = layer0_N61_lut[layer0_N61_wire];

wire [3:0] layer0_N62_wire = {M0[547], M0[548], M0[481], M0[546]};
wire [15:0] layer0_N62_lut = 16'hA101;
assign M1[62] = layer0_N62_lut[layer0_N62_wire];

wire [3:0] layer0_N63_wire = {M0[396], M0[601], M0[315], M0[547]};
wire [15:0] layer0_N63_lut = 16'hF0F0;
assign M1[63] = layer0_N63_lut[layer0_N63_wire];

wire [3:0] layer0_N64_wire = {M0[491], M0[490], M0[411], M0[408]};
wire [15:0] layer0_N64_lut = 16'hAEEE;
assign M1[64] = layer0_N64_lut[layer0_N64_wire];

wire [3:0] layer0_N65_wire = {M0[418], M0[407], M0[435], M0[445]};
wire [15:0] layer0_N65_lut = 16'hB1ED;
assign M1[65] = layer0_N65_lut[layer0_N65_wire];

wire [3:0] layer0_N66_wire = {M0[434], M0[433], M0[491], M0[435]};
wire [15:0] layer0_N66_lut = 16'hDFD9;
assign M1[66] = layer0_N66_lut[layer0_N66_wire];

wire [3:0] layer0_N67_wire = {M0[478], M0[477], M0[479], M0[450]};
wire [15:0] layer0_N67_lut = 16'h1155;
assign M1[67] = layer0_N67_lut[layer0_N67_wire];

wire [3:0] layer0_N68_wire = {M0[356], M0[232], M0[496], M0[566]};
wire [15:0] layer0_N68_lut = 16'hCCF0;
assign M1[68] = layer0_N68_lut[layer0_N68_wire];

wire [3:0] layer0_N69_wire = {M0[744], M0[133], M0[434], M0[543]};
wire [15:0] layer0_N69_lut = 16'h30F0;
assign M1[69] = layer0_N69_lut[layer0_N69_wire];

wire [3:0] layer0_N70_wire = {M0[229], M0[193], M0[736], M0[433]};
wire [15:0] layer0_N70_lut = 16'h000B;
assign M1[70] = layer0_N70_lut[layer0_N70_wire];

wire [3:0] layer0_N71_wire = {M0[433], M0[431], M0[434], M0[460]};
wire [15:0] layer0_N71_lut = 16'hAE8C;
assign M1[71] = layer0_N71_lut[layer0_N71_wire];

wire [3:0] layer0_N72_wire = {M0[410], M0[390], M0[489], M0[461]};
wire [15:0] layer0_N72_lut = 16'h0F0D;
assign M1[72] = layer0_N72_lut[layer0_N72_wire];

wire [3:0] layer0_N73_wire = {M0[601], M0[472], M0[606], M0[579]};
wire [15:0] layer0_N73_lut = 16'h6E06;
assign M1[73] = layer0_N73_lut[layer0_N73_wire];

wire [3:0] layer0_N74_wire = {M0[437], M0[276], M0[663], M0[277]};
wire [15:0] layer0_N74_lut = 16'h3F30;
assign M1[74] = layer0_N74_lut[layer0_N74_wire];

wire [3:0] layer0_N75_wire = {M0[438], M0[658], M0[657], M0[578]};
wire [15:0] layer0_N75_lut = 16'h5103;
assign M1[75] = layer0_N75_lut[layer0_N75_wire];

wire [3:0] layer0_N76_wire = {M0[99], M0[408], M0[434], M0[407]};
wire [15:0] layer0_N76_lut = 16'hFF00;
assign M1[76] = layer0_N76_lut[layer0_N76_wire];

wire [3:0] layer0_N77_wire = {M0[268], M0[495], M0[267], M0[208]};
wire [15:0] layer0_N77_lut = 16'hFB70;
assign M1[77] = layer0_N77_lut[layer0_N77_wire];

wire [3:0] layer0_N78_wire = {M0[296], M0[295], M0[432], M0[320]};
wire [15:0] layer0_N78_lut = 16'hBFA3;
assign M1[78] = layer0_N78_lut[layer0_N78_wire];

wire [3:0] layer0_N79_wire = {M0[34], M0[237], M0[593], M0[429]};
wire [15:0] layer0_N79_lut = 16'h40F4;
assign M1[79] = layer0_N79_lut[layer0_N79_wire];

wire [3:0] layer0_N80_wire = {M0[260], M0[209], M0[360], M0[234]};
wire [15:0] layer0_N80_lut = 16'h70FF;
assign M1[80] = layer0_N80_lut[layer0_N80_wire];

wire [3:0] layer0_N81_wire = {M0[205], M0[187], M0[427], M0[208]};
wire [15:0] layer0_N81_lut = 16'hFF10;
assign M1[81] = layer0_N81_lut[layer0_N81_wire];

wire [3:0] layer0_N82_wire = {M0[155], M0[128], M0[209], M0[126]};
wire [15:0] layer0_N82_lut = 16'h25E4;
assign M1[82] = layer0_N82_lut[layer0_N82_wire];

wire [3:0] layer0_N83_wire = {M0[209], M0[266], M0[208], M0[265]};
wire [15:0] layer0_N83_lut = 16'hFFDF;
assign M1[83] = layer0_N83_lut[layer0_N83_wire];

wire [3:0] layer0_N84_wire = {M0[650], M0[453], M0[282], M0[309]};
wire [15:0] layer0_N84_lut = 16'hAAFF;
assign M1[84] = layer0_N84_lut[layer0_N84_wire];

wire [3:0] layer0_N85_wire = {M0[506], M0[478], M0[362], M0[491]};
wire [15:0] layer0_N85_lut = 16'h0FFF;
assign M1[85] = layer0_N85_lut[layer0_N85_wire];

wire [3:0] layer0_N86_wire = {M0[453], M0[309], M0[240], M0[239]};
wire [15:0] layer0_N86_lut = 16'hFF40;
assign M1[86] = layer0_N86_lut[layer0_N86_wire];

wire [3:0] layer0_N87_wire = {M0[124], M0[569], M0[386], M0[286]};
wire [15:0] layer0_N87_lut = 16'hEFEE;
assign M1[87] = layer0_N87_lut[layer0_N87_wire];

wire [3:0] layer0_N88_wire = {M0[150], M0[346], M0[260], M0[320]};
wire [15:0] layer0_N88_lut = 16'hDFCF;
assign M1[88] = layer0_N88_lut[layer0_N88_wire];

wire [3:0] layer0_N89_wire = {M0[323], M0[573], M0[496], M0[360]};
wire [15:0] layer0_N89_lut = 16'hFDF0;
assign M1[89] = layer0_N89_lut[layer0_N89_wire];

wire [3:0] layer0_N90_wire = {M0[349], M0[352], M0[185], M0[452]};
wire [15:0] layer0_N90_lut = 16'h303B;
assign M1[90] = layer0_N90_lut[layer0_N90_wire];

wire [3:0] layer0_N91_wire = {M0[124], M0[208], M0[235], M0[207]};
wire [15:0] layer0_N91_lut = 16'h9F5B;
assign M1[91] = layer0_N91_lut[layer0_N91_wire];

wire [3:0] layer0_N92_wire = {M0[603], M0[576], M0[574], M0[154]};
wire [15:0] layer0_N92_lut = 16'hFFCA;
assign M1[92] = layer0_N92_lut[layer0_N92_wire];

wire [3:0] layer0_N93_wire = {M0[603], M0[66], M0[479], M0[527]};
wire [15:0] layer0_N93_lut = 16'hEEFE;
assign M1[93] = layer0_N93_lut[layer0_N93_wire];

wire [3:0] layer0_N94_wire = {M0[603], M0[155], M0[297], M0[182]};
wire [15:0] layer0_N94_lut = 16'h25B7;
assign M1[94] = layer0_N94_lut[layer0_N94_wire];

wire [3:0] layer0_N95_wire = {M0[579], M0[360], M0[228], M0[287]};
wire [15:0] layer0_N95_lut = 16'h70F0;
assign M1[95] = layer0_N95_lut[layer0_N95_wire];

wire [3:0] layer0_N96_wire = {M0[523], M0[714], M0[522], M0[495]};
wire [15:0] layer0_N96_lut = 16'hF071;
assign M1[96] = layer0_N96_lut[layer0_N96_wire];

wire [3:0] layer0_N97_wire = {M0[570], M0[571], M0[714], M0[45]};
wire [15:0] layer0_N97_lut = 16'h1551;
assign M1[97] = layer0_N97_lut[layer0_N97_wire];

wire [3:0] layer0_N98_wire = {M0[714], M0[666], M0[415], M0[317]};
wire [15:0] layer0_N98_lut = 16'h8CCC;
assign M1[98] = layer0_N98_lut[layer0_N98_wire];

wire [3:0] layer0_N99_wire = {M0[571], M0[317], M0[45], M0[714]};
wire [15:0] layer0_N99_lut = 16'h3113;
assign M1[99] = layer0_N99_lut[layer0_N99_wire];

wire [3:0] layer0_N100_wire = {M0[573], M0[602], M0[603], M0[576]};
wire [15:0] layer0_N100_lut = 16'h8A88;
assign M1[100] = layer0_N100_lut[layer0_N100_wire];

wire [3:0] layer0_N101_wire = {M0[217], M0[265], M0[327], M0[379]};
wire [15:0] layer0_N101_lut = 16'hAA1B;
assign M1[101] = layer0_N101_lut[layer0_N101_wire];

wire [3:0] layer0_N102_wire = {M0[542], M0[520], M0[515], M0[516]};
wire [15:0] layer0_N102_lut = 16'hB080;
assign M1[102] = layer0_N102_lut[layer0_N102_wire];

wire [3:0] layer0_N103_wire = {M0[716], M0[301], M0[524], M0[551]};
wire [15:0] layer0_N103_lut = 16'h00FF;
assign M1[103] = layer0_N103_lut[layer0_N103_wire];

wire [3:0] layer0_N104_wire = {M0[185], M0[203], M0[666], M0[96]};
wire [15:0] layer0_N104_lut = 16'h4455;
assign M1[104] = layer0_N104_lut[layer0_N104_wire];

wire [3:0] layer0_N105_wire = {M0[121], M0[457], M0[707], M0[269]};
wire [15:0] layer0_N105_lut = 16'hF3F3;
assign M1[105] = layer0_N105_lut[layer0_N105_wire];

wire [3:0] layer0_N106_wire = {M0[546], M0[369], M0[501], M0[564]};
wire [15:0] layer0_N106_lut = 16'h17CC;
assign M1[106] = layer0_N106_lut[layer0_N106_wire];

wire [3:0] layer0_N107_wire = {M0[349], M0[291], M0[325], M0[457]};
wire [15:0] layer0_N107_lut = 16'hF107;
assign M1[107] = layer0_N107_lut[layer0_N107_wire];

wire [3:0] layer0_N108_wire = {M0[296], M0[332], M0[396], M0[325]};
wire [15:0] layer0_N108_lut = 16'h2A0B;
assign M1[108] = layer0_N108_lut[layer0_N108_wire];

wire [3:0] layer0_N109_wire = {M0[415], M0[243], M0[297], M0[215]};
wire [15:0] layer0_N109_lut = 16'h003F;
assign M1[109] = layer0_N109_lut[layer0_N109_wire];

wire [3:0] layer0_N110_wire = {M0[411], M0[274], M0[247], M0[246]};
wire [15:0] layer0_N110_lut = 16'h0711;
assign M1[110] = layer0_N110_lut[layer0_N110_wire];

wire [3:0] layer0_N111_wire = {M0[199], M0[491], M0[519], M0[227]};
wire [15:0] layer0_N111_lut = 16'hDF88;
assign M1[111] = layer0_N111_lut[layer0_N111_wire];

wire [3:0] layer0_N112_wire = {M0[348], M0[431], M0[542], M0[429]};
wire [15:0] layer0_N112_lut = 16'hFB4B;
assign M1[112] = layer0_N112_lut[layer0_N112_wire];

wire [3:0] layer0_N113_wire = {M0[550], M0[432], M0[483], M0[602]};
wire [15:0] layer0_N113_lut = 16'h31B3;
assign M1[113] = layer0_N113_lut[layer0_N113_wire];

wire [3:0] layer0_N114_wire = {M0[359], M0[495], M0[267], M0[510]};
wire [15:0] layer0_N114_lut = 16'h5F4E;
assign M1[114] = layer0_N114_lut[layer0_N114_wire];

wire [3:0] layer0_N115_wire = {M0[350], M0[374], M0[349], M0[527]};
wire [15:0] layer0_N115_lut = 16'h222A;
assign M1[115] = layer0_N115_lut[layer0_N115_wire];

wire [3:0] layer0_N116_wire = {M0[539], M0[287], M0[395], M0[239]};
wire [15:0] layer0_N116_lut = 16'hFAEA;
assign M1[116] = layer0_N116_lut[layer0_N116_wire];

wire [3:0] layer0_N117_wire = {M0[479], M0[329], M0[498], M0[272]};
wire [15:0] layer0_N117_lut = 16'h11FD;
assign M1[117] = layer0_N117_lut[layer0_N117_wire];

wire [3:0] layer0_N118_wire = {M0[257], M0[285], M0[256], M0[229]};
wire [15:0] layer0_N118_lut = 16'h2323;
assign M1[118] = layer0_N118_lut[layer0_N118_wire];

wire [3:0] layer0_N119_wire = {M0[468], M0[358], M0[299], M0[351]};
wire [15:0] layer0_N119_lut = 16'hAEEE;
assign M1[119] = layer0_N119_lut[layer0_N119_wire];

wire [3:0] layer0_N120_wire = {M0[686], M0[687], M0[679], M0[650]};
wire [15:0] layer0_N120_lut = 16'h5500;
assign M1[120] = layer0_N120_lut[layer0_N120_wire];

wire [3:0] layer0_N121_wire = {M0[714], M0[721], M0[713], M0[464]};
wire [15:0] layer0_N121_lut = 16'hFFFD;
assign M1[121] = layer0_N121_lut[layer0_N121_wire];

wire [3:0] layer0_N122_wire = {M0[438], M0[653], M0[433], M0[439]};
wire [15:0] layer0_N122_lut = 16'hF7EE;
assign M1[122] = layer0_N122_lut[layer0_N122_wire];

wire [3:0] layer0_N123_wire = {M0[714], M0[713], M0[686], M0[92]};
wire [15:0] layer0_N123_lut = 16'hFEFC;
assign M1[123] = layer0_N123_lut[layer0_N123_wire];

wire [3:0] layer0_N124_wire = {M0[411], M0[462], M0[538], M0[97]};
wire [15:0] layer0_N124_lut = 16'h4307;
assign M1[124] = layer0_N124_lut[layer0_N124_wire];

wire [3:0] layer0_N125_wire = {M0[356], M0[459], M0[488], M0[182]};
wire [15:0] layer0_N125_lut = 16'h0302;
assign M1[125] = layer0_N125_lut[layer0_N125_wire];

wire [3:0] layer0_N126_wire = {M0[609], M0[488], M0[305], M0[277]};
wire [15:0] layer0_N126_lut = 16'h5711;
assign M1[126] = layer0_N126_lut[layer0_N126_wire];

wire [3:0] layer0_N127_wire = {M0[306], M0[490], M0[132], M0[491]};
wire [15:0] layer0_N127_lut = 16'hFBFE;
assign M1[127] = layer0_N127_lut[layer0_N127_wire];

wire [3:0] layer0_N128_wire = {M0[465], M0[154], M0[325], M0[126]};
wire [15:0] layer0_N128_lut = 16'h3B4D;
assign M1[128] = layer0_N128_lut[layer0_N128_wire];

wire [3:0] layer0_N129_wire = {M0[287], M0[285], M0[342], M0[405]};
wire [15:0] layer0_N129_lut = 16'hFFCE;
assign M1[129] = layer0_N129_lut[layer0_N129_wire];

wire [3:0] layer0_N130_wire = {M0[284], M0[438], M0[283], M0[366]};
wire [15:0] layer0_N130_lut = 16'hA2AA;
assign M1[130] = layer0_N130_lut[layer0_N130_wire];

wire [3:0] layer0_N131_wire = {M0[569], M0[285], M0[360], M0[554]};
wire [15:0] layer0_N131_lut = 16'h00E0;
assign M1[131] = layer0_N131_lut[layer0_N131_wire];

wire [3:0] layer0_N132_wire = {M0[339], M0[656], M0[497], M0[498]};
wire [15:0] layer0_N132_lut = 16'hEEEE;
assign M1[132] = layer0_N132_lut[layer0_N132_wire];

wire [3:0] layer0_N133_wire = {M0[502], M0[473], M0[498], M0[501]};
wire [15:0] layer0_N133_lut = 16'hEEEE;
assign M1[133] = layer0_N133_lut[layer0_N133_wire];

wire [3:0] layer0_N134_wire = {M0[499], M0[509], M0[652], M0[620]};
wire [15:0] layer0_N134_lut = 16'h4F00;
assign M1[134] = layer0_N134_lut[layer0_N134_wire];

wire [3:0] layer0_N135_wire = {M0[473], M0[305], M0[502], M0[501]};
wire [15:0] layer0_N135_lut = 16'h0FFE;
assign M1[135] = layer0_N135_lut[layer0_N135_wire];

wire [3:0] layer0_N136_wire = {M0[226], M0[344], M0[272], M0[345]};
wire [15:0] layer0_N136_lut = 16'h0045;
assign M1[136] = layer0_N136_lut[layer0_N136_wire];

wire [3:0] layer0_N137_wire = {M0[311], M0[283], M0[540], M0[338]};
wire [15:0] layer0_N137_lut = 16'h0505;
assign M1[137] = layer0_N137_lut[layer0_N137_wire];

wire [3:0] layer0_N138_wire = {M0[322], M0[44], M0[434], M0[563]};
wire [15:0] layer0_N138_lut = 16'hF0FF;
assign M1[138] = layer0_N138_lut[layer0_N138_wire];

wire [3:0] layer0_N139_wire = {M0[313], M0[285], M0[145], M0[520]};
wire [15:0] layer0_N139_lut = 16'hD84F;
assign M1[139] = layer0_N139_lut[layer0_N139_wire];

wire [3:0] layer0_N140_wire = {M0[620], M0[683], M0[350], M0[584]};
wire [15:0] layer0_N140_lut = 16'hABAA;
assign M1[140] = layer0_N140_lut[layer0_N140_wire];

wire [3:0] layer0_N141_wire = {M0[612], M0[683], M0[620], M0[585]};
wire [15:0] layer0_N141_lut = 16'h0051;
assign M1[141] = layer0_N141_lut[layer0_N141_wire];

wire [3:0] layer0_N142_wire = {M0[576], M0[572], M0[535], M0[604]};
wire [15:0] layer0_N142_lut = 16'h303A;
assign M1[142] = layer0_N142_lut[layer0_N142_wire];

wire [3:0] layer0_N143_wire = {M0[572], M0[435], M0[437], M0[576]};
wire [15:0] layer0_N143_lut = 16'hFF37;
assign M1[143] = layer0_N143_lut[layer0_N143_wire];

wire [3:0] layer0_N144_wire = {M0[214], M0[361], M0[507], M0[538]};
wire [15:0] layer0_N144_lut = 16'hF3F2;
assign M1[144] = layer0_N144_lut[layer0_N144_wire];

wire [3:0] layer0_N145_wire = {M0[98], M0[458], M0[465], M0[155]};
wire [15:0] layer0_N145_lut = 16'hFF02;
assign M1[145] = layer0_N145_lut[layer0_N145_wire];

wire [3:0] layer0_N146_wire = {M0[333], M0[416], M0[332], M0[361]};
wire [15:0] layer0_N146_lut = 16'hAA44;
assign M1[146] = layer0_N146_lut[layer0_N146_wire];

wire [3:0] layer0_N147_wire = {M0[266], M0[399], M0[337], M0[400]};
wire [15:0] layer0_N147_lut = 16'h8585;
assign M1[147] = layer0_N147_lut[layer0_N147_wire];

wire [3:0] layer0_N148_wire = {M0[367], M0[273], M0[395], M0[339]};
wire [15:0] layer0_N148_lut = 16'h0011;
assign M1[148] = layer0_N148_lut[layer0_N148_wire];

wire [3:0] layer0_N149_wire = {M0[607], M0[181], M0[325], M0[367]};
wire [15:0] layer0_N149_lut = 16'hCCEC;
assign M1[149] = layer0_N149_lut[layer0_N149_wire];

wire [3:0] layer0_N150_wire = {M0[565], M0[395], M0[607], M0[400]};
wire [15:0] layer0_N150_lut = 16'hD477;
assign M1[150] = layer0_N150_lut[layer0_N150_wire];

wire [3:0] layer0_N151_wire = {M0[369], M0[152], M0[397], M0[368]};
wire [15:0] layer0_N151_lut = 16'h2ACC;
assign M1[151] = layer0_N151_lut[layer0_N151_wire];

wire [3:0] layer0_N152_wire = {M0[164], M0[433], M0[133], M0[314]};
wire [15:0] layer0_N152_lut = 16'h0055;
assign M1[152] = layer0_N152_lut[layer0_N152_wire];

wire [3:0] layer0_N153_wire = {M0[254], M0[685], M0[315], M0[658]};
wire [15:0] layer0_N153_lut = 16'h3037;
assign M1[153] = layer0_N153_lut[layer0_N153_wire];

wire [3:0] layer0_N154_wire = {M0[565], M0[399], M0[566], M0[133]};
wire [15:0] layer0_N154_lut = 16'h330F;
assign M1[154] = layer0_N154_lut[layer0_N154_wire];

wire [3:0] layer0_N155_wire = {M0[187], M0[301], M0[132], M0[355]};
wire [15:0] layer0_N155_lut = 16'hEAE1;
assign M1[155] = layer0_N155_lut[layer0_N155_wire];

wire [3:0] layer0_N156_wire = {M0[353], M0[520], M0[397], M0[272]};
wire [15:0] layer0_N156_lut = 16'hEAEF;
assign M1[156] = layer0_N156_lut[layer0_N156_wire];

wire [3:0] layer0_N157_wire = {M0[657], M0[629], M0[437], M0[409]};
wire [15:0] layer0_N157_lut = 16'h3713;
assign M1[157] = layer0_N157_lut[layer0_N157_wire];

wire [3:0] layer0_N158_wire = {M0[605], M0[606], M0[296], M0[632]};
wire [15:0] layer0_N158_lut = 16'h0A53;
assign M1[158] = layer0_N158_lut[layer0_N158_wire];

wire [3:0] layer0_N159_wire = {M0[620], M0[591], M0[562], M0[535]};
wire [15:0] layer0_N159_lut = 16'hFDFC;
assign M1[159] = layer0_N159_lut[layer0_N159_wire];

wire [3:0] layer0_N160_wire = {M0[293], M0[345], M0[265], M0[487]};
wire [15:0] layer0_N160_lut = 16'hC537;
assign M1[160] = layer0_N160_lut[layer0_N160_wire];

wire [3:0] layer0_N161_wire = {M0[314], M0[342], M0[746], M0[340]};
wire [15:0] layer0_N161_lut = 16'h35B3;
assign M1[161] = layer0_N161_lut[layer0_N161_wire];

wire [3:0] layer0_N162_wire = {M0[344], M0[204], M0[342], M0[345]};
wire [15:0] layer0_N162_lut = 16'h8E11;
assign M1[162] = layer0_N162_lut[layer0_N162_wire];

wire [3:0] layer0_N163_wire = {M0[684], M0[328], M0[246], M0[265]};
wire [15:0] layer0_N163_lut = 16'hE2FB;
assign M1[163] = layer0_N163_lut[layer0_N163_wire];

wire [3:0] layer0_N164_wire = {M0[574], M0[468], M0[444], M0[433]};
wire [15:0] layer0_N164_lut = 16'h3030;
assign M1[164] = layer0_N164_lut[layer0_N164_wire];

wire [3:0] layer0_N165_wire = {M0[478], M0[394], M0[450], M0[299]};
wire [15:0] layer0_N165_lut = 16'h0107;
assign M1[165] = layer0_N165_lut[layer0_N165_wire];

wire [3:0] layer0_N166_wire = {M0[478], M0[417], M0[515], M0[506]};
wire [15:0] layer0_N166_lut = 16'hF5F0;
assign M1[166] = layer0_N166_lut[layer0_N166_wire];

wire [3:0] layer0_N167_wire = {M0[262], M0[270], M0[243], M0[260]};
wire [15:0] layer0_N167_lut = 16'h0041;
assign M1[167] = layer0_N167_lut[layer0_N167_wire];

wire [3:0] layer0_N168_wire = {M0[564], M0[480], M0[584], M0[583]};
wire [15:0] layer0_N168_lut = 16'h0011;
assign M1[168] = layer0_N168_lut[layer0_N168_wire];

wire [3:0] layer0_N169_wire = {M0[486], M0[324], M0[717], M0[370]};
wire [15:0] layer0_N169_lut = 16'hFDC4;
assign M1[169] = layer0_N169_lut[layer0_N169_wire];

wire [3:0] layer0_N170_wire = {M0[452], M0[564], M0[480], M0[583]};
wire [15:0] layer0_N170_lut = 16'h33EF;
assign M1[170] = layer0_N170_lut[layer0_N170_wire];

wire [3:0] layer0_N171_wire = {M0[435], M0[431], M0[434], M0[401]};
wire [15:0] layer0_N171_lut = 16'h4041;
assign M1[171] = layer0_N171_lut[layer0_N171_wire];

wire [3:0] layer0_N172_wire = {M0[515], M0[485], M0[220], M0[514]};
wire [15:0] layer0_N172_lut = 16'hDFFF;
assign M1[172] = layer0_N172_lut[layer0_N172_wire];

wire [3:0] layer0_N173_wire = {M0[514], M0[486], M0[474], M0[515]};
wire [15:0] layer0_N173_lut = 16'h27F0;
assign M1[173] = layer0_N173_lut[layer0_N173_wire];

wire [3:0] layer0_N174_wire = {M0[315], M0[288], M0[287], M0[479]};
wire [15:0] layer0_N174_lut = 16'hAAAE;
assign M1[174] = layer0_N174_lut[layer0_N174_wire];

wire [3:0] layer0_N175_wire = {M0[235], M0[424], M0[416], M0[662]};
wire [15:0] layer0_N175_lut = 16'hF8E8;
assign M1[175] = layer0_N175_lut[layer0_N175_wire];

wire [3:0] layer0_N176_wire = {M0[405], M0[217], M0[283], M0[294]};
wire [15:0] layer0_N176_lut = 16'hCCC4;
assign M1[176] = layer0_N176_lut[layer0_N176_wire];

wire [3:0] layer0_N177_wire = {M0[349], M0[452], M0[719], M0[198]};
wire [15:0] layer0_N177_lut = 16'hDCCC;
assign M1[177] = layer0_N177_lut[layer0_N177_wire];

wire [3:0] layer0_N178_wire = {M0[458], M0[92], M0[182], M0[155]};
wire [15:0] layer0_N178_lut = 16'hF0FE;
assign M1[178] = layer0_N178_lut[layer0_N178_wire];

wire [3:0] layer0_N179_wire = {M0[305], M0[276], M0[338], M0[282]};
wire [15:0] layer0_N179_lut = 16'h0017;
assign M1[179] = layer0_N179_lut[layer0_N179_wire];

wire [3:0] layer0_N180_wire = {M0[577], M0[576], M0[605], M0[571]};
wire [15:0] layer0_N180_lut = 16'hBA0D;
assign M1[180] = layer0_N180_lut[layer0_N180_wire];

wire [3:0] layer0_N181_wire = {M0[239], M0[240], M0[271], M0[243]};
wire [15:0] layer0_N181_lut = 16'hE005;
assign M1[181] = layer0_N181_lut[layer0_N181_wire];

wire [3:0] layer0_N182_wire = {M0[543], M0[401], M0[270], M0[430]};
wire [15:0] layer0_N182_lut = 16'h73FA;
assign M1[182] = layer0_N182_lut[layer0_N182_wire];

wire [3:0] layer0_N183_wire = {M0[227], M0[220], M0[221], M0[199]};
wire [15:0] layer0_N183_lut = 16'h0031;
assign M1[183] = layer0_N183_lut[layer0_N183_wire];

wire [3:0] layer0_N184_wire = {M0[573], M0[571], M0[574], M0[241]};
wire [15:0] layer0_N184_lut = 16'hC000;
assign M1[184] = layer0_N184_lut[layer0_N184_wire];

wire [3:0] layer0_N185_wire = {M0[543], M0[685], M0[598], M0[607]};
wire [15:0] layer0_N185_lut = 16'hF1F0;
assign M1[185] = layer0_N185_lut[layer0_N185_wire];

wire [3:0] layer0_N186_wire = {M0[602], M0[604], M0[600], M0[599]};
wire [15:0] layer0_N186_lut = 16'hFCC8;
assign M1[186] = layer0_N186_lut[layer0_N186_wire];

wire [3:0] layer0_N187_wire = {M0[604], M0[601], M0[607], M0[630]};
wire [15:0] layer0_N187_lut = 16'hEA08;
assign M1[187] = layer0_N187_lut[layer0_N187_wire];

wire [3:0] layer0_N188_wire = {M0[403], M0[426], M0[384], M0[612]};
wire [15:0] layer0_N188_lut = 16'hEEEA;
assign M1[188] = layer0_N188_lut[layer0_N188_wire];

wire [3:0] layer0_N189_wire = {M0[311], M0[310], M0[247], M0[331]};
wire [15:0] layer0_N189_lut = 16'h300F;
assign M1[189] = layer0_N189_lut[layer0_N189_wire];

wire [3:0] layer0_N190_wire = {M0[576], M0[572], M0[603], M0[517]};
wire [15:0] layer0_N190_lut = 16'hF052;
assign M1[190] = layer0_N190_lut[layer0_N190_wire];

wire [3:0] layer0_N191_wire = {M0[575], M0[426], M0[628], M0[656]};
wire [15:0] layer0_N191_lut = 16'hF0FC;
assign M1[191] = layer0_N191_lut[layer0_N191_wire];

wire [3:0] layer0_N192_wire = {M0[418], M0[237], M0[606], M0[431]};
wire [15:0] layer0_N192_lut = 16'h9F0F;
assign M1[192] = layer0_N192_lut[layer0_N192_wire];

wire [3:0] layer0_N193_wire = {M0[526], M0[384], M0[199], M0[606]};
wire [15:0] layer0_N193_lut = 16'h2301;
assign M1[193] = layer0_N193_lut[layer0_N193_wire];

wire [3:0] layer0_N194_wire = {M0[312], M0[153], M0[658], M0[353]};
wire [15:0] layer0_N194_lut = 16'hC8FF;
assign M1[194] = layer0_N194_lut[layer0_N194_wire];

wire [3:0] layer0_N195_wire = {M0[506], M0[478], M0[394], M0[278]};
wire [15:0] layer0_N195_lut = 16'h1D54;
assign M1[195] = layer0_N195_lut[layer0_N195_wire];

wire [3:0] layer0_N196_wire = {M0[282], M0[662], M0[650], M0[629]};
wire [15:0] layer0_N196_lut = 16'hFF41;
assign M1[196] = layer0_N196_lut[layer0_N196_wire];

wire [3:0] layer0_N197_wire = {M0[348], M0[349], M0[321], M0[320]};
wire [15:0] layer0_N197_lut = 16'hF5F4;
assign M1[197] = layer0_N197_lut[layer0_N197_wire];

wire [3:0] layer0_N198_wire = {M0[685], M0[683], M0[713], M0[180]};
wire [15:0] layer0_N198_lut = 16'hFCEC;
assign M1[198] = layer0_N198_lut[layer0_N198_wire];

wire [3:0] layer0_N199_wire = {M0[321], M0[506], M0[349], M0[534]};
wire [15:0] layer0_N199_lut = 16'h170F;
assign M1[199] = layer0_N199_lut[layer0_N199_wire];

wire [3:0] layer0_N200_wire = {M0[452], M0[182], M0[210], M0[212]};
wire [15:0] layer0_N200_lut = 16'h05B7;
assign M1[200] = layer0_N200_lut[layer0_N200_wire];

wire [3:0] layer0_N201_wire = {M0[412], M0[362], M0[333], M0[508]};
wire [15:0] layer0_N201_lut = 16'hDADE;
assign M1[201] = layer0_N201_lut[layer0_N201_wire];

wire [3:0] layer0_N202_wire = {M0[237], M0[211], M0[205], M0[238]};
wire [15:0] layer0_N202_lut = 16'h7FB8;
assign M1[202] = layer0_N202_lut[layer0_N202_wire];

wire [3:0] layer0_N203_wire = {M0[472], M0[471], M0[539], M0[519]};
wire [15:0] layer0_N203_lut = 16'h66F7;
assign M1[203] = layer0_N203_lut[layer0_N203_wire];

wire [3:0] layer0_N204_wire = {M0[425], M0[540], M0[438], M0[415]};
wire [15:0] layer0_N204_lut = 16'h020E;
assign M1[204] = layer0_N204_lut[layer0_N204_wire];

wire [3:0] layer0_N205_wire = {M0[438], M0[523], M0[229], M0[522]};
wire [15:0] layer0_N205_lut = 16'h7332;
assign M1[205] = layer0_N205_lut[layer0_N205_wire];

wire [3:0] layer0_N206_wire = {M0[374], M0[438], M0[381], M0[427]};
wire [15:0] layer0_N206_lut = 16'h53DD;
assign M1[206] = layer0_N206_lut[layer0_N206_wire];

wire [3:0] layer0_N207_wire = {M0[481], M0[438], M0[381], M0[457]};
wire [15:0] layer0_N207_lut = 16'h5557;
assign M1[207] = layer0_N207_lut[layer0_N207_wire];

wire [3:0] layer0_N208_wire = {M0[581], M0[630], M0[608], M0[244]};
wire [15:0] layer0_N208_lut = 16'hFAEA;
assign M1[208] = layer0_N208_lut[layer0_N208_wire];

wire [3:0] layer0_N209_wire = {M0[92], M0[203], M0[35], M0[231]};
wire [15:0] layer0_N209_lut = 16'hDCFE;
assign M1[209] = layer0_N209_lut[layer0_N209_wire];

wire [3:0] layer0_N210_wire = {M0[343], M0[203], M0[443], M0[483]};
wire [15:0] layer0_N210_lut = 16'h033F;
assign M1[210] = layer0_N210_lut[layer0_N210_wire];

wire [3:0] layer0_N211_wire = {M0[483], M0[484], M0[660], M0[525]};
wire [15:0] layer0_N211_lut = 16'h51F3;
assign M1[211] = layer0_N211_lut[layer0_N211_wire];

wire [3:0] layer0_N212_wire = {M0[455], M0[399], M0[456], M0[372]};
wire [15:0] layer0_N212_lut = 16'h0E32;
assign M1[212] = layer0_N212_lut[layer0_N212_wire];

wire [3:0] layer0_N213_wire = {M0[563], M0[117], M0[357], M0[434]};
wire [15:0] layer0_N213_lut = 16'h008F;
assign M1[213] = layer0_N213_lut[layer0_N213_wire];

wire [3:0] layer0_N214_wire = {M0[653], M0[395], M0[349], M0[348]};
wire [15:0] layer0_N214_lut = 16'hB0BB;
assign M1[214] = layer0_N214_lut[layer0_N214_wire];

wire [3:0] layer0_N215_wire = {M0[406], M0[434], M0[378], M0[455]};
wire [15:0] layer0_N215_lut = 16'h3FFC;
assign M1[215] = layer0_N215_lut[layer0_N215_wire];

wire [3:0] layer0_N216_wire = {M0[606], M0[605], M0[283], M0[569]};
wire [15:0] layer0_N216_lut = 16'h4004;
assign M1[216] = layer0_N216_lut[layer0_N216_wire];

wire [3:0] layer0_N217_wire = {M0[237], M0[212], M0[282], M0[349]};
wire [15:0] layer0_N217_lut = 16'h3775;
assign M1[217] = layer0_N217_lut[layer0_N217_wire];

wire [3:0] layer0_N218_wire = {M0[549], M0[548], M0[547], M0[576]};
wire [15:0] layer0_N218_lut = 16'hCA8E;
assign M1[218] = layer0_N218_lut[layer0_N218_wire];

wire [3:0] layer0_N219_wire = {M0[400], M0[290], M0[207], M0[262]};
wire [15:0] layer0_N219_lut = 16'h8C8E;
assign M1[219] = layer0_N219_lut[layer0_N219_wire];

wire [3:0] layer0_N220_wire = {M0[405], M0[378], M0[377], M0[406]};
wire [15:0] layer0_N220_lut = 16'hFC20;
assign M1[220] = layer0_N220_lut[layer0_N220_wire];

wire [3:0] layer0_N221_wire = {M0[205], M0[582], M0[554], M0[438]};
wire [15:0] layer0_N221_lut = 16'hCCCE;
assign M1[221] = layer0_N221_lut[layer0_N221_wire];

wire [3:0] layer0_N222_wire = {M0[551], M0[578], M0[579], M0[456]};
wire [15:0] layer0_N222_lut = 16'h0173;
assign M1[222] = layer0_N222_lut[layer0_N222_wire];

wire [3:0] layer0_N223_wire = {M0[623], M0[583], M0[582], M0[606]};
wire [15:0] layer0_N223_lut = 16'h1009;
assign M1[223] = layer0_N223_lut[layer0_N223_wire];

wire [3:0] layer0_N224_wire = {M0[593], M0[338], M0[658], M0[657]};
wire [15:0] layer0_N224_lut = 16'h2322;
assign M1[224] = layer0_N224_lut[layer0_N224_wire];

wire [3:0] layer0_N225_wire = {M0[522], M0[521], M0[658], M0[714]};
wire [15:0] layer0_N225_lut = 16'h1111;
assign M1[225] = layer0_N225_lut[layer0_N225_wire];

wire [3:0] layer0_N226_wire = {M0[546], M0[490], M0[434], M0[574]};
wire [15:0] layer0_N226_lut = 16'h1FFA;
assign M1[226] = layer0_N226_lut[layer0_N226_wire];

wire [3:0] layer0_N227_wire = {M0[662], M0[663], M0[555], M0[418]};
wire [15:0] layer0_N227_lut = 16'h222B;
assign M1[227] = layer0_N227_lut[layer0_N227_wire];

wire [3:0] layer0_N228_wire = {M0[153], M0[95], M0[180], M0[453]};
wire [15:0] layer0_N228_lut = 16'hEA23;
assign M1[228] = layer0_N228_lut[layer0_N228_wire];

wire [3:0] layer0_N229_wire = {M0[314], M0[273], M0[544], M0[208]};
wire [15:0] layer0_N229_lut = 16'hEFAF;
assign M1[229] = layer0_N229_lut[layer0_N229_wire];

wire [3:0] layer0_N230_wire = {M0[565], M0[534], M0[566], M0[567]};
wire [15:0] layer0_N230_lut = 16'h050D;
assign M1[230] = layer0_N230_lut[layer0_N230_wire];

wire [3:0] layer0_N231_wire = {M0[583], M0[584], M0[529], M0[637]};
wire [15:0] layer0_N231_lut = 16'h79FA;
assign M1[231] = layer0_N231_lut[layer0_N231_wire];

wire [3:0] layer0_N232_wire = {M0[424], M0[526], M0[722], M0[564]};
wire [15:0] layer0_N232_lut = 16'hEBC0;
assign M1[232] = layer0_N232_lut[layer0_N232_wire];

wire [3:0] layer0_N233_wire = {M0[371], M0[483], M0[48], M0[540]};
wire [15:0] layer0_N233_lut = 16'hFAEE;
assign M1[233] = layer0_N233_lut[layer0_N233_wire];

wire [3:0] layer0_N234_wire = {M0[272], M0[578], M0[549], M0[548]};
wire [15:0] layer0_N234_lut = 16'hA5E0;
assign M1[234] = layer0_N234_lut[layer0_N234_wire];

wire [3:0] layer0_N235_wire = {M0[457], M0[424], M0[722], M0[368]};
wire [15:0] layer0_N235_lut = 16'hFF8E;
assign M1[235] = layer0_N235_lut[layer0_N235_wire];

wire [3:0] layer0_N236_wire = {M0[185], M0[344], M0[213], M0[660]};
wire [15:0] layer0_N236_lut = 16'h0B0E;
assign M1[236] = layer0_N236_lut[layer0_N236_wire];

wire [3:0] layer0_N237_wire = {M0[493], M0[463], M0[465], M0[228]};
wire [15:0] layer0_N237_lut = 16'h0A8B;
assign M1[237] = layer0_N237_lut[layer0_N237_wire];

wire [3:0] layer0_N238_wire = {M0[660], M0[685], M0[714], M0[381]};
wire [15:0] layer0_N238_lut = 16'hBDDD;
assign M1[238] = layer0_N238_lut[layer0_N238_wire];

wire [3:0] layer0_N239_wire = {M0[714], M0[715], M0[688], M0[687]};
wire [15:0] layer0_N239_lut = 16'h27A7;
assign M1[239] = layer0_N239_lut[layer0_N239_wire];

wire [3:0] layer0_N240_wire = {M0[226], M0[346], M0[254], M0[227]};
wire [15:0] layer0_N240_lut = 16'hFE66;
assign M1[240] = layer0_N240_lut[layer0_N240_wire];

wire [3:0] layer0_N241_wire = {M0[518], M0[371], M0[35], M0[323]};
wire [15:0] layer0_N241_lut = 16'h0023;
assign M1[241] = layer0_N241_lut[layer0_N241_wire];

wire [3:0] layer0_N242_wire = {M0[562], M0[86], M0[538], M0[329]};
wire [15:0] layer0_N242_lut = 16'h0105;
assign M1[242] = layer0_N242_lut[layer0_N242_wire];

wire [3:0] layer0_N243_wire = {M0[596], M0[657], M0[653], M0[654]};
wire [15:0] layer0_N243_lut = 16'hAADC;
assign M1[243] = layer0_N243_lut[layer0_N243_wire];

wire [3:0] layer0_N244_wire = {M0[350], M0[322], M0[543], M0[349]};
wire [15:0] layer0_N244_lut = 16'h500A;
assign M1[244] = layer0_N244_lut[layer0_N244_wire];

wire [3:0] layer0_N245_wire = {M0[443], M0[463], M0[452], M0[459]};
wire [15:0] layer0_N245_lut = 16'h7F7F;
assign M1[245] = layer0_N245_lut[layer0_N245_wire];

wire [3:0] layer0_N246_wire = {M0[398], M0[436], M0[400], M0[571]};
wire [15:0] layer0_N246_lut = 16'h33FF;
assign M1[246] = layer0_N246_lut[layer0_N246_wire];

wire [3:0] layer0_N247_wire = {M0[90], M0[135], M0[121], M0[107]};
wire [15:0] layer0_N247_lut = 16'hFFF4;
assign M1[247] = layer0_N247_lut[layer0_N247_wire];

wire [3:0] layer0_N248_wire = {M0[323], M0[281], M0[502], M0[404]};
wire [15:0] layer0_N248_lut = 16'hABAB;
assign M1[248] = layer0_N248_lut[layer0_N248_wire];

wire [3:0] layer0_N249_wire = {M0[397], M0[424], M0[323], M0[396]};
wire [15:0] layer0_N249_lut = 16'h2755;
assign M1[249] = layer0_N249_lut[layer0_N249_wire];

wire [3:0] layer0_N250_wire = {M0[281], M0[69], M0[312], M0[432]};
wire [15:0] layer0_N250_lut = 16'h020F;
assign M1[250] = layer0_N250_lut[layer0_N250_wire];

wire [3:0] layer0_N251_wire = {M0[312], M0[285], M0[152], M0[658]};
wire [15:0] layer0_N251_lut = 16'h4D5D;
assign M1[251] = layer0_N251_lut[layer0_N251_wire];

wire [3:0] layer0_N252_wire = {M0[260], M0[257], M0[562], M0[389]};
wire [15:0] layer0_N252_lut = 16'h0BF3;
assign M1[252] = layer0_N252_lut[layer0_N252_wire];

wire [3:0] layer0_N253_wire = {M0[570], M0[543], M0[571], M0[389]};
wire [15:0] layer0_N253_lut = 16'hFFF0;
assign M1[253] = layer0_N253_lut[layer0_N253_wire];

wire [3:0] layer0_N254_wire = {M0[457], M0[485], M0[338], M0[287]};
wire [15:0] layer0_N254_lut = 16'hA88E;
assign M1[254] = layer0_N254_lut[layer0_N254_wire];

wire [3:0] layer0_N255_wire = {M0[356], M0[571], M0[328], M0[330]};
wire [15:0] layer0_N255_lut = 16'h415D;
assign M1[255] = layer0_N255_lut[layer0_N255_wire];

wire [3:0] layer0_N256_wire = {M0[465], M0[454], M0[273], M0[605]};
wire [15:0] layer0_N256_lut = 16'hFFAA;
assign M1[256] = layer0_N256_lut[layer0_N256_wire];

wire [3:0] layer0_N257_wire = {M0[601], M0[519], M0[548], M0[414]};
wire [15:0] layer0_N257_lut = 16'h0103;
assign M1[257] = layer0_N257_lut[layer0_N257_wire];

wire [3:0] layer0_N258_wire = {M0[601], M0[573], M0[387], M0[491]};
wire [15:0] layer0_N258_lut = 16'h0105;
assign M1[258] = layer0_N258_lut[layer0_N258_wire];

wire [3:0] layer0_N259_wire = {M0[244], M0[384], M0[329], M0[342]};
wire [15:0] layer0_N259_lut = 16'h01D0;
assign M1[259] = layer0_N259_lut[layer0_N259_wire];

wire [3:0] layer0_N260_wire = {M0[516], M0[483], M0[487], M0[455]};
wire [15:0] layer0_N260_lut = 16'h0AEE;
assign M1[260] = layer0_N260_lut[layer0_N260_wire];

wire [3:0] layer0_N261_wire = {M0[185], M0[434], M0[597], M0[599]};
wire [15:0] layer0_N261_lut = 16'h6736;
assign M1[261] = layer0_N261_lut[layer0_N261_wire];

wire [3:0] layer0_N262_wire = {M0[383], M0[426], M0[346], M0[453]};
wire [15:0] layer0_N262_lut = 16'hF575;
assign M1[262] = layer0_N262_lut[layer0_N262_wire];

wire [3:0] layer0_N263_wire = {M0[481], M0[547], M0[521], M0[456]};
wire [15:0] layer0_N263_lut = 16'hAE35;
assign M1[263] = layer0_N263_lut[layer0_N263_wire];

wire [3:0] layer0_N264_wire = {M0[414], M0[415], M0[444], M0[500]};
wire [15:0] layer0_N264_lut = 16'h10FE;
assign M1[264] = layer0_N264_lut[layer0_N264_wire];

wire [3:0] layer0_N265_wire = {M0[342], M0[370], M0[356], M0[545]};
wire [15:0] layer0_N265_lut = 16'h2BFF;
assign M1[265] = layer0_N265_lut[layer0_N265_wire];

wire [3:0] layer0_N266_wire = {M0[423], M0[451], M0[348], M0[347]};
wire [15:0] layer0_N266_lut = 16'hFF40;
assign M1[266] = layer0_N266_lut[layer0_N266_wire];

wire [3:0] layer0_N267_wire = {M0[354], M0[327], M0[388], M0[389]};
wire [15:0] layer0_N267_lut = 16'h2AEE;
assign M1[267] = layer0_N267_lut[layer0_N267_wire];

wire [3:0] layer0_N268_wire = {M0[315], M0[375], M0[379], M0[131]};
wire [15:0] layer0_N268_lut = 16'hAA2A;
assign M1[268] = layer0_N268_lut[layer0_N268_wire];

wire [3:0] layer0_N269_wire = {M0[269], M0[203], M0[265], M0[187]};
wire [15:0] layer0_N269_lut = 16'h4D2C;
assign M1[269] = layer0_N269_lut[layer0_N269_wire];

wire [3:0] layer0_N270_wire = {M0[209], M0[299], M0[263], M0[316]};
wire [15:0] layer0_N270_lut = 16'hFDEC;
assign M1[270] = layer0_N270_lut[layer0_N270_wire];

wire [3:0] layer0_N271_wire = {M0[323], M0[322], M0[377], M0[303]};
wire [15:0] layer0_N271_lut = 16'h03BB;
assign M1[271] = layer0_N271_lut[layer0_N271_wire];

wire [3:0] layer0_N272_wire = {M0[149], M0[365], M0[150], M0[549]};
wire [15:0] layer0_N272_lut = 16'h00CE;
assign M1[272] = layer0_N272_lut[layer0_N272_wire];

wire [3:0] layer0_N273_wire = {M0[213], M0[238], M0[266], M0[367]};
wire [15:0] layer0_N273_lut = 16'hAAC0;
assign M1[273] = layer0_N273_lut[layer0_N273_wire];

wire [3:0] layer0_N274_wire = {M0[321], M0[232], M0[262], M0[234]};
wire [15:0] layer0_N274_lut = 16'hA437;
assign M1[274] = layer0_N274_lut[layer0_N274_wire];

wire [3:0] layer0_N275_wire = {M0[265], M0[323], M0[296], M0[379]};
wire [15:0] layer0_N275_lut = 16'hFEFC;
assign M1[275] = layer0_N275_lut[layer0_N275_wire];

wire [3:0] layer0_N276_wire = {M0[200], M0[302], M0[331], M0[416]};
wire [15:0] layer0_N276_lut = 16'hFEFA;
assign M1[276] = layer0_N276_lut[layer0_N276_wire];

wire [3:0] layer0_N277_wire = {M0[478], M0[477], M0[500], M0[506]};
wire [15:0] layer0_N277_lut = 16'h71FF;
assign M1[277] = layer0_N277_lut[layer0_N277_wire];

wire [3:0] layer0_N278_wire = {M0[611], M0[357], M0[610], M0[484]};
wire [15:0] layer0_N278_lut = 16'h0073;
assign M1[278] = layer0_N278_lut[layer0_N278_wire];

wire [3:0] layer0_N279_wire = {M0[394], M0[654], M0[366], M0[662]};
wire [15:0] layer0_N279_lut = 16'hFFCF;
assign M1[279] = layer0_N279_lut[layer0_N279_wire];

wire [3:0] layer0_N280_wire = {M0[121], M0[558], M0[294], M0[92]};
wire [15:0] layer0_N280_lut = 16'hF8FC;
assign M1[280] = layer0_N280_lut[layer0_N280_wire];

wire [3:0] layer0_N281_wire = {M0[601], M0[549], M0[439], M0[548]};
wire [15:0] layer0_N281_lut = 16'hFFA8;
assign M1[281] = layer0_N281_lut[layer0_N281_wire];

wire [3:0] layer0_N282_wire = {M0[417], M0[528], M0[382], M0[578]};
wire [15:0] layer0_N282_lut = 16'h0F04;
assign M1[282] = layer0_N282_lut[layer0_N282_wire];

wire [3:0] layer0_N283_wire = {M0[417], M0[446], M0[632], M0[180]};
wire [15:0] layer0_N283_lut = 16'hF0F0;
assign M1[283] = layer0_N283_lut[layer0_N283_wire];

wire [3:0] layer0_N284_wire = {M0[523], M0[551], M0[431], M0[458]};
wire [15:0] layer0_N284_lut = 16'hEF0F;
assign M1[284] = layer0_N284_lut[layer0_N284_wire];

wire [3:0] layer0_N285_wire = {M0[519], M0[523], M0[430], M0[513]};
wire [15:0] layer0_N285_lut = 16'h05FF;
assign M1[285] = layer0_N285_lut[layer0_N285_wire];

wire [3:0] layer0_N286_wire = {M0[300], M0[577], M0[507], M0[400]};
wire [15:0] layer0_N286_lut = 16'hECFE;
assign M1[286] = layer0_N286_lut[layer0_N286_wire];

wire [3:0] layer0_N287_wire = {M0[523], M0[551], M0[247], M0[431]};
wire [15:0] layer0_N287_lut = 16'hFFCC;
assign M1[287] = layer0_N287_lut[layer0_N287_wire];

wire [3:0] layer0_N288_wire = {M0[92], M0[117], M0[91], M0[571]};
wire [15:0] layer0_N288_lut = 16'hFFFE;
assign M1[288] = layer0_N288_lut[layer0_N288_wire];

wire [3:0] layer0_N289_wire = {M0[571], M0[92], M0[543], M0[570]};
wire [15:0] layer0_N289_lut = 16'hFFC4;
assign M1[289] = layer0_N289_lut[layer0_N289_wire];

wire [3:0] layer0_N290_wire = {M0[287], M0[288], M0[489], M0[490]};
wire [15:0] layer0_N290_lut = 16'h3737;
assign M1[290] = layer0_N290_lut[layer0_N290_wire];

wire [3:0] layer0_N291_wire = {M0[403], M0[434], M0[187], M0[435]};
wire [15:0] layer0_N291_lut = 16'h135F;
assign M1[291] = layer0_N291_lut[layer0_N291_wire];

wire [3:0] layer0_N292_wire = {M0[405], M0[300], M0[174], M0[557]};
wire [15:0] layer0_N292_lut = 16'h0171;
assign M1[292] = layer0_N292_lut[layer0_N292_wire];

wire [3:0] layer0_N293_wire = {M0[688], M0[276], M0[662], M0[636]};
wire [15:0] layer0_N293_lut = 16'hC0B2;
assign M1[293] = layer0_N293_lut[layer0_N293_wire];

wire [3:0] layer0_N294_wire = {M0[205], M0[210], M0[209], M0[208]};
wire [15:0] layer0_N294_lut = 16'h0001;
assign M1[294] = layer0_N294_lut[layer0_N294_wire];

wire [3:0] layer0_N295_wire = {M0[574], M0[575], M0[486], M0[573]};
wire [15:0] layer0_N295_lut = 16'hCFCF;
assign M1[295] = layer0_N295_lut[layer0_N295_wire];

wire [3:0] layer0_N296_wire = {M0[451], M0[423], M0[248], M0[354]};
wire [15:0] layer0_N296_lut = 16'hACEE;
assign M1[296] = layer0_N296_lut[layer0_N296_wire];

wire [3:0] layer0_N297_wire = {M0[578], M0[551], M0[360], M0[541]};
wire [15:0] layer0_N297_lut = 16'hC44C;
assign M1[297] = layer0_N297_lut[layer0_N297_wire];

wire [3:0] layer0_N298_wire = {M0[423], M0[451], M0[513], M0[354]};
wire [15:0] layer0_N298_lut = 16'h0C0F;
assign M1[298] = layer0_N298_lut[layer0_N298_wire];

wire [3:0] layer0_N299_wire = {M0[354], M0[706], M0[190], M0[131]};
wire [15:0] layer0_N299_lut = 16'hFEFA;
assign M1[299] = layer0_N299_lut[layer0_N299_wire];

wire [3:0] layer0_N300_wire = {M0[408], M0[396], M0[404], M0[353]};
wire [15:0] layer0_N300_lut = 16'hFEC8;
assign M1[300] = layer0_N300_lut[layer0_N300_wire];

wire [3:0] layer0_N301_wire = {M0[396], M0[327], M0[397], M0[505]};
wire [15:0] layer0_N301_lut = 16'hFAD0;
assign M1[301] = layer0_N301_lut[layer0_N301_wire];

wire [3:0] layer0_N302_wire = {M0[397], M0[396], M0[505], M0[398]};
wire [15:0] layer0_N302_lut = 16'hEA82;
assign M1[302] = layer0_N302_lut[layer0_N302_wire];

wire [3:0] layer0_N303_wire = {M0[379], M0[515], M0[709], M0[372]};
wire [15:0] layer0_N303_lut = 16'hCAEE;
assign M1[303] = layer0_N303_lut[layer0_N303_wire];

wire [3:0] layer0_N304_wire = {M0[575], M0[581], M0[554], M0[479]};
wire [15:0] layer0_N304_lut = 16'h0F0F;
assign M1[304] = layer0_N304_lut[layer0_N304_wire];

wire [3:0] layer0_N305_wire = {M0[575], M0[574], M0[603], M0[576]};
wire [15:0] layer0_N305_lut = 16'h4672;
assign M1[305] = layer0_N305_lut[layer0_N305_wire];

wire [3:0] layer0_N306_wire = {M0[554], M0[546], M0[434], M0[518]};
wire [15:0] layer0_N306_lut = 16'h00AF;
assign M1[306] = layer0_N306_lut[layer0_N306_wire];

wire [3:0] layer0_N307_wire = {M0[630], M0[629], M0[627], M0[746]};
wire [15:0] layer0_N307_lut = 16'h17F4;
assign M1[307] = layer0_N307_lut[layer0_N307_wire];

wire [3:0] layer0_N308_wire = {M0[350], M0[273], M0[299], M0[351]};
wire [15:0] layer0_N308_lut = 16'hE3C0;
assign M1[308] = layer0_N308_lut[layer0_N308_wire];

wire [3:0] layer0_N309_wire = {M0[298], M0[273], M0[246], M0[319]};
wire [15:0] layer0_N309_lut = 16'hFEC2;
assign M1[309] = layer0_N309_lut[layer0_N309_wire];

wire [3:0] layer0_N310_wire = {M0[128], M0[350], M0[273], M0[491]};
wire [15:0] layer0_N310_lut = 16'h20FC;
assign M1[310] = layer0_N310_lut[layer0_N310_wire];

wire [3:0] layer0_N311_wire = {M0[296], M0[298], M0[270], M0[297]};
wire [15:0] layer0_N311_lut = 16'h62EE;
assign M1[311] = layer0_N311_lut[layer0_N311_wire];

wire [3:0] layer0_N312_wire = {M0[323], M0[190], M0[324], M0[296]};
wire [15:0] layer0_N312_lut = 16'h4F1F;
assign M1[312] = layer0_N312_lut[layer0_N312_wire];

wire [3:0] layer0_N313_wire = {M0[329], M0[597], M0[624], M0[479]};
wire [15:0] layer0_N313_lut = 16'hBF2B;
assign M1[313] = layer0_N313_lut[layer0_N313_wire];

wire [3:0] layer0_N314_wire = {M0[456], M0[566], M0[573], M0[548]};
wire [15:0] layer0_N314_lut = 16'h0005;
assign M1[314] = layer0_N314_lut[layer0_N314_wire];

wire [3:0] layer0_N315_wire = {M0[556], M0[479], M0[578], M0[396]};
wire [15:0] layer0_N315_lut = 16'hAFAF;
assign M1[315] = layer0_N315_lut[layer0_N315_wire];

wire [3:0] layer0_N316_wire = {M0[261], M0[714], M0[262], M0[289]};
wire [15:0] layer0_N316_lut = 16'hFBFA;
assign M1[316] = layer0_N316_lut[layer0_N316_wire];

wire [3:0] layer0_N317_wire = {M0[545], M0[214], M0[543], M0[548]};
wire [15:0] layer0_N317_lut = 16'hE8B1;
assign M1[317] = layer0_N317_lut[layer0_N317_wire];

wire [3:0] layer0_N318_wire = {M0[545], M0[546], M0[547], M0[548]};
wire [15:0] layer0_N318_lut = 16'h3F7D;
assign M1[318] = layer0_N318_lut[layer0_N318_wire];

wire [3:0] layer0_N319_wire = {M0[543], M0[513], M0[524], M0[369]};
wire [15:0] layer0_N319_lut = 16'h504C;
assign M1[319] = layer0_N319_lut[layer0_N319_wire];

wire [3:0] layer0_N320_wire = {M0[163], M0[314], M0[579], M0[304]};
wire [15:0] layer0_N320_lut = 16'h00C4;
assign M1[320] = layer0_N320_lut[layer0_N320_wire];

wire [3:0] layer0_N321_wire = {M0[226], M0[568], M0[248], M0[311]};
wire [15:0] layer0_N321_lut = 16'h3073;
assign M1[321] = layer0_N321_lut[layer0_N321_wire];

wire [3:0] layer0_N322_wire = {M0[342], M0[397], M0[132], M0[563]};
wire [15:0] layer0_N322_lut = 16'hEEEE;
assign M1[322] = layer0_N322_lut[layer0_N322_wire];

wire [3:0] layer0_N323_wire = {M0[294], M0[557], M0[474], M0[295]};
wire [15:0] layer0_N323_lut = 16'hF333;
assign M1[323] = layer0_N323_lut[layer0_N323_wire];

wire [3:0] layer0_N324_wire = {M0[384], M0[535], M0[343], M0[536]};
wire [15:0] layer0_N324_lut = 16'hFC84;
assign M1[324] = layer0_N324_lut[layer0_N324_wire];

wire [3:0] layer0_N325_wire = {M0[487], M0[404], M0[457], M0[401]};
wire [15:0] layer0_N325_lut = 16'h0477;
assign M1[325] = layer0_N325_lut[layer0_N325_wire];

wire [3:0] layer0_N326_wire = {M0[394], M0[422], M0[361], M0[395]};
wire [15:0] layer0_N326_lut = 16'hD850;
assign M1[326] = layer0_N326_lut[layer0_N326_wire];

wire [3:0] layer0_N327_wire = {M0[404], M0[434], M0[563], M0[260]};
wire [15:0] layer0_N327_lut = 16'hF070;
assign M1[327] = layer0_N327_lut[layer0_N327_wire];

wire [3:0] layer0_N328_wire = {M0[547], M0[510], M0[546], M0[482]};
wire [15:0] layer0_N328_lut = 16'hFFFC;
assign M1[328] = layer0_N328_lut[layer0_N328_wire];

wire [3:0] layer0_N329_wire = {M0[519], M0[441], M0[320], M0[526]};
wire [15:0] layer0_N329_lut = 16'h015F;
assign M1[329] = layer0_N329_lut[layer0_N329_wire];

wire [3:0] layer0_N330_wire = {M0[445], M0[489], M0[570], M0[71]};
wire [15:0] layer0_N330_lut = 16'hDC4C;
assign M1[330] = layer0_N330_lut[layer0_N330_wire];

wire [3:0] layer0_N331_wire = {M0[367], M0[454], M0[408], M0[339]};
wire [15:0] layer0_N331_lut = 16'hC7AF;
assign M1[331] = layer0_N331_lut[layer0_N331_wire];

wire [3:0] layer0_N332_wire = {M0[289], M0[540], M0[261], M0[580]};
wire [15:0] layer0_N332_lut = 16'h1F17;
assign M1[332] = layer0_N332_lut[layer0_N332_wire];

wire [3:0] layer0_N333_wire = {M0[584], M0[591], M0[749], M0[293]};
wire [15:0] layer0_N333_lut = 16'h003F;
assign M1[333] = layer0_N333_lut[layer0_N333_wire];

wire [3:0] layer0_N334_wire = {M0[484], M0[374], M0[540], M0[580]};
wire [15:0] layer0_N334_lut = 16'hC88E;
assign M1[334] = layer0_N334_lut[layer0_N334_wire];

wire [3:0] layer0_N335_wire = {M0[414], M0[604], M0[398], M0[399]};
wire [15:0] layer0_N335_lut = 16'h2B2F;
assign M1[335] = layer0_N335_lut[layer0_N335_wire];

wire [3:0] layer0_N336_wire = {M0[407], M0[300], M0[381], M0[328]};
wire [15:0] layer0_N336_lut = 16'h2333;
assign M1[336] = layer0_N336_lut[layer0_N336_wire];

wire [3:0] layer0_N337_wire = {M0[486], M0[489], M0[382], M0[459]};
wire [15:0] layer0_N337_lut = 16'hF1F5;
assign M1[337] = layer0_N337_lut[layer0_N337_wire];

wire [3:0] layer0_N338_wire = {M0[471], M0[438], M0[523], M0[466]};
wire [15:0] layer0_N338_lut = 16'hC5C7;
assign M1[338] = layer0_N338_lut[layer0_N338_wire];

wire [3:0] layer0_N339_wire = {M0[744], M0[471], M0[371], M0[466]};
wire [15:0] layer0_N339_lut = 16'h3B32;
assign M1[339] = layer0_N339_lut[layer0_N339_wire];

wire [3:0] layer0_N340_wire = {M0[471], M0[444], M0[637], M0[292]};
wire [15:0] layer0_N340_lut = 16'h1313;
assign M1[340] = layer0_N340_lut[layer0_N340_wire];

wire [3:0] layer0_N341_wire = {M0[383], M0[368], M0[386], M0[387]};
wire [15:0] layer0_N341_lut = 16'hBBA2;
assign M1[341] = layer0_N341_lut[layer0_N341_wire];

wire [3:0] layer0_N342_wire = {M0[444], M0[610], M0[565], M0[593]};
wire [15:0] layer0_N342_lut = 16'hFAA0;
assign M1[342] = layer0_N342_lut[layer0_N342_wire];

wire [3:0] layer0_N343_wire = {M0[34], M0[225], M0[64], M0[61]};
wire [15:0] layer0_N343_lut = 16'hFFFF;
assign M1[343] = layer0_N343_lut[layer0_N343_wire];

wire [3:0] layer0_N344_wire = {M0[263], M0[385], M0[413], M0[181]};
wire [15:0] layer0_N344_lut = 16'h0141;
assign M1[344] = layer0_N344_lut[layer0_N344_wire];

wire [3:0] layer0_N345_wire = {M0[282], M0[310], M0[497], M0[665]};
wire [15:0] layer0_N345_lut = 16'h8F08;
assign M1[345] = layer0_N345_lut[layer0_N345_wire];

wire [3:0] layer0_N346_wire = {M0[511], M0[181], M0[630], M0[358]};
wire [15:0] layer0_N346_lut = 16'hCDCC;
assign M1[346] = layer0_N346_lut[layer0_N346_wire];

wire [3:0] layer0_N347_wire = {M0[399], M0[371], M0[398], M0[444]};
wire [15:0] layer0_N347_lut = 16'h730F;
assign M1[347] = layer0_N347_lut[layer0_N347_wire];

wire [3:0] layer0_N348_wire = {M0[584], M0[528], M0[556], M0[565]};
wire [15:0] layer0_N348_lut = 16'h233B;
assign M1[348] = layer0_N348_lut[layer0_N348_wire];

wire [3:0] layer0_N349_wire = {M0[715], M0[526], M0[716], M0[565]};
wire [15:0] layer0_N349_lut = 16'hF0F0;
assign M1[349] = layer0_N349_lut[layer0_N349_wire];

wire [3:0] layer0_N350_wire = {M0[536], M0[657], M0[534], M0[508]};
wire [15:0] layer0_N350_lut = 16'h8C31;
assign M1[350] = layer0_N350_lut[layer0_N350_wire];

wire [3:0] layer0_N351_wire = {M0[585], M0[556], M0[708], M0[584]};
wire [15:0] layer0_N351_lut = 16'h208E;
assign M1[351] = layer0_N351_lut[layer0_N351_wire];

wire [3:0] layer0_N352_wire = {M0[463], M0[179], M0[627], M0[433]};
wire [15:0] layer0_N352_lut = 16'hBAAA;
assign M1[352] = layer0_N352_lut[layer0_N352_wire];

wire [3:0] layer0_N353_wire = {M0[627], M0[356], M0[41], M0[342]};
wire [15:0] layer0_N353_lut = 16'h3233;
assign M1[353] = layer0_N353_lut[layer0_N353_wire];

wire [3:0] layer0_N354_wire = {M0[423], M0[66], M0[459], M0[285]};
wire [15:0] layer0_N354_lut = 16'h8F0E;
assign M1[354] = layer0_N354_lut[layer0_N354_wire];

wire [3:0] layer0_N355_wire = {M0[268], M0[688], M0[486], M0[431]};
wire [15:0] layer0_N355_lut = 16'h0FAA;
assign M1[355] = layer0_N355_lut[layer0_N355_wire];

wire [3:0] layer0_N356_wire = {M0[287], M0[596], M0[433], M0[514]};
wire [15:0] layer0_N356_lut = 16'hFAD9;
assign M1[356] = layer0_N356_lut[layer0_N356_wire];

wire [3:0] layer0_N357_wire = {M0[209], M0[598], M0[184], M0[181]};
wire [15:0] layer0_N357_lut = 16'hFFF0;
assign M1[357] = layer0_N357_lut[layer0_N357_wire];

wire [3:0] layer0_N358_wire = {M0[217], M0[341], M0[156], M0[539]};
wire [15:0] layer0_N358_lut = 16'hAAAA;
assign M1[358] = layer0_N358_lut[layer0_N358_wire];

wire [3:0] layer0_N359_wire = {M0[451], M0[209], M0[208], M0[480]};
wire [15:0] layer0_N359_lut = 16'hFFAA;
assign M1[359] = layer0_N359_lut[layer0_N359_wire];

wire [3:0] layer0_N360_wire = {M0[400], M0[428], M0[411], M0[372]};
wire [15:0] layer0_N360_lut = 16'h1171;
assign M1[360] = layer0_N360_lut[layer0_N360_wire];

wire [3:0] layer0_N361_wire = {M0[288], M0[488], M0[544], M0[459]};
wire [15:0] layer0_N361_lut = 16'h343C;
assign M1[361] = layer0_N361_lut[layer0_N361_wire];

wire [3:0] layer0_N362_wire = {M0[205], M0[372], M0[400], M0[339]};
wire [15:0] layer0_N362_lut = 16'h2AAB;
assign M1[362] = layer0_N362_lut[layer0_N362_wire];

wire [3:0] layer0_N363_wire = {M0[527], M0[568], M0[428], M0[489]};
wire [15:0] layer0_N363_lut = 16'h40EE;
assign M1[363] = layer0_N363_lut[layer0_N363_wire];

wire [3:0] layer0_N364_wire = {M0[493], M0[515], M0[311], M0[486]};
wire [15:0] layer0_N364_lut = 16'hCDDF;
assign M1[364] = layer0_N364_lut[layer0_N364_wire];

wire [3:0] layer0_N365_wire = {M0[96], M0[244], M0[133], M0[446]};
wire [15:0] layer0_N365_lut = 16'hAA22;
assign M1[365] = layer0_N365_lut[layer0_N365_wire];

wire [3:0] layer0_N366_wire = {M0[421], M0[362], M0[361], M0[390]};
wire [15:0] layer0_N366_lut = 16'hF0F0;
assign M1[366] = layer0_N366_lut[layer0_N366_wire];

wire [3:0] layer0_N367_wire = {M0[95], M0[169], M0[596], M0[578]};
wire [15:0] layer0_N367_lut = 16'h0F0E;
assign M1[367] = layer0_N367_lut[layer0_N367_wire];

wire [3:0] layer0_N368_wire = {M0[747], M0[748], M0[555], M0[213]};
wire [15:0] layer0_N368_lut = 16'h0C0C;
assign M1[368] = layer0_N368_lut[layer0_N368_wire];

wire [3:0] layer0_N369_wire = {M0[609], M0[187], M0[491], M0[36]};
wire [15:0] layer0_N369_lut = 16'h2EEF;
assign M1[369] = layer0_N369_lut[layer0_N369_wire];

wire [3:0] layer0_N370_wire = {M0[657], M0[629], M0[180], M0[215]};
wire [15:0] layer0_N370_lut = 16'hCE07;
assign M1[370] = layer0_N370_lut[layer0_N370_wire];

wire [3:0] layer0_N371_wire = {M0[213], M0[580], M0[214], M0[208]};
wire [15:0] layer0_N371_lut = 16'h577F;
assign M1[371] = layer0_N371_lut[layer0_N371_wire];

wire [3:0] layer0_N372_wire = {M0[341], M0[396], M0[397], M0[454]};
wire [15:0] layer0_N372_lut = 16'hEEAE;
assign M1[372] = layer0_N372_lut[layer0_N372_wire];

wire [3:0] layer0_N373_wire = {M0[341], M0[312], M0[542], M0[396]};
wire [15:0] layer0_N373_lut = 16'h2727;
assign M1[373] = layer0_N373_lut[layer0_N373_wire];

wire [3:0] layer0_N374_wire = {M0[436], M0[601], M0[211], M0[408]};
wire [15:0] layer0_N374_lut = 16'h7333;
assign M1[374] = layer0_N374_lut[layer0_N374_wire];

wire [3:0] layer0_N375_wire = {M0[341], M0[425], M0[342], M0[396]};
wire [15:0] layer0_N375_lut = 16'h33BB;
assign M1[375] = layer0_N375_lut[layer0_N375_wire];

wire [3:0] layer0_N376_wire = {M0[491], M0[490], M0[487], M0[492]};
wire [15:0] layer0_N376_lut = 16'hA101;
assign M1[376] = layer0_N376_lut[layer0_N376_wire];

wire [3:0] layer0_N377_wire = {M0[710], M0[711], M0[620], M0[291]};
wire [15:0] layer0_N377_lut = 16'h32F3;
assign M1[377] = layer0_N377_lut[layer0_N377_wire];

wire [3:0] layer0_N378_wire = {M0[739], M0[450], M0[396], M0[509]};
wire [15:0] layer0_N378_lut = 16'h008F;
assign M1[378] = layer0_N378_lut[layer0_N378_wire];

wire [3:0] layer0_N379_wire = {M0[345], M0[486], M0[289], M0[434]};
wire [15:0] layer0_N379_lut = 16'hAFAB;
assign M1[379] = layer0_N379_lut[layer0_N379_wire];

wire [3:0] layer0_N380_wire = {M0[675], M0[697], M0[479], M0[620]};
wire [15:0] layer0_N380_lut = 16'h0003;
assign M1[380] = layer0_N380_lut[layer0_N380_wire];

wire [3:0] layer0_N381_wire = {M0[406], M0[411], M0[545], M0[444]};
wire [15:0] layer0_N381_lut = 16'hDF51;
assign M1[381] = layer0_N381_lut[layer0_N381_wire];

wire [3:0] layer0_N382_wire = {M0[593], M0[675], M0[594], M0[590]};
wire [15:0] layer0_N382_lut = 16'h0103;
assign M1[382] = layer0_N382_lut[layer0_N382_wire];

wire [3:0] layer0_N383_wire = {M0[410], M0[442], M0[401], M0[443]};
wire [15:0] layer0_N383_lut = 16'h4F5F;
assign M1[383] = layer0_N383_lut[layer0_N383_wire];

wire [3:0] layer0_N384_wire = {M0[315], M0[266], M0[222], M0[512]};
wire [15:0] layer0_N384_lut = 16'h2BAA;
assign M1[384] = layer0_N384_lut[layer0_N384_wire];

wire [3:0] layer0_N385_wire = {M0[435], M0[238], M0[469], M0[522]};
wire [15:0] layer0_N385_lut = 16'h5754;
assign M1[385] = layer0_N385_lut[layer0_N385_wire];

wire [3:0] layer0_N386_wire = {M0[259], M0[270], M0[269], M0[467]};
wire [15:0] layer0_N386_lut = 16'hBFBF;
assign M1[386] = layer0_N386_lut[layer0_N386_wire];

wire [3:0] layer0_N387_wire = {M0[408], M0[500], M0[322], M0[321]};
wire [15:0] layer0_N387_lut = 16'h8E8A;
assign M1[387] = layer0_N387_lut[layer0_N387_wire];

wire [3:0] layer0_N388_wire = {M0[686], M0[630], M0[657], M0[602]};
wire [15:0] layer0_N388_lut = 16'hF00D;
assign M1[388] = layer0_N388_lut[layer0_N388_wire];

wire [3:0] layer0_N389_wire = {M0[630], M0[551], M0[552], M0[548]};
wire [15:0] layer0_N389_lut = 16'hFFDE;
assign M1[389] = layer0_N389_lut[layer0_N389_wire];

wire [3:0] layer0_N390_wire = {M0[630], M0[658], M0[602], M0[517]};
wire [15:0] layer0_N390_lut = 16'hA2BA;
assign M1[390] = layer0_N390_lut[layer0_N390_wire];

wire [3:0] layer0_N391_wire = {M0[714], M0[574], M0[713], M0[602]};
wire [15:0] layer0_N391_lut = 16'hFEAA;
assign M1[391] = layer0_N391_lut[layer0_N391_wire];

wire [3:0] layer0_N392_wire = {M0[266], M0[470], M0[469], M0[548]};
wire [15:0] layer0_N392_lut = 16'h03C3;
assign M1[392] = layer0_N392_lut[layer0_N392_wire];

wire [3:0] layer0_N393_wire = {M0[567], M0[541], M0[483], M0[510]};
wire [15:0] layer0_N393_lut = 16'h989B;
assign M1[393] = layer0_N393_lut[layer0_N393_wire];

wire [3:0] layer0_N394_wire = {M0[422], M0[421], M0[394], M0[478]};
wire [15:0] layer0_N394_lut = 16'h111F;
assign M1[394] = layer0_N394_lut[layer0_N394_wire];

wire [3:0] layer0_N395_wire = {M0[421], M0[163], M0[394], M0[398]};
wire [15:0] layer0_N395_lut = 16'hDF0C;
assign M1[395] = layer0_N395_lut[layer0_N395_wire];

wire [3:0] layer0_N396_wire = {M0[562], M0[603], M0[506], M0[582]};
wire [15:0] layer0_N396_lut = 16'hCC00;
assign M1[396] = layer0_N396_lut[layer0_N396_wire];

wire [3:0] layer0_N397_wire = {M0[582], M0[538], M0[580], M0[609]};
wire [15:0] layer0_N397_lut = 16'hDFF2;
assign M1[397] = layer0_N397_lut[layer0_N397_wire];

wire [3:0] layer0_N398_wire = {M0[574], M0[575], M0[551], M0[546]};
wire [15:0] layer0_N398_lut = 16'h0F55;
assign M1[398] = layer0_N398_lut[layer0_N398_wire];

wire [3:0] layer0_N399_wire = {M0[369], M0[394], M0[442], M0[418]};
wire [15:0] layer0_N399_lut = 16'hEE0F;
assign M1[399] = layer0_N399_lut[layer0_N399_wire];

wire [3:0] layer0_N400_wire = {M0[320], M0[377], M0[272], M0[405]};
wire [15:0] layer0_N400_lut = 16'h000F;
assign M1[400] = layer0_N400_lut[layer0_N400_wire];

wire [3:0] layer0_N401_wire = {M0[528], M0[351], M0[350], M0[380]};
wire [15:0] layer0_N401_lut = 16'hF8E8;
assign M1[401] = layer0_N401_lut[layer0_N401_wire];

wire [3:0] layer0_N402_wire = {M0[320], M0[221], M0[292], M0[289]};
wire [15:0] layer0_N402_lut = 16'hDD88;
assign M1[402] = layer0_N402_lut[layer0_N402_wire];

wire [3:0] layer0_N403_wire = {M0[396], M0[564], M0[569], M0[568]};
wire [15:0] layer0_N403_lut = 16'hFFD0;
assign M1[403] = layer0_N403_lut[layer0_N403_wire];

wire [3:0] layer0_N404_wire = {M0[524], M0[234], M0[584], M0[214]};
wire [15:0] layer0_N404_lut = 16'h0033;
assign M1[404] = layer0_N404_lut[layer0_N404_wire];

wire [3:0] layer0_N405_wire = {M0[214], M0[369], M0[339], M0[536]};
wire [15:0] layer0_N405_lut = 16'h5256;
assign M1[405] = layer0_N405_lut[layer0_N405_wire];

wire [3:0] layer0_N406_wire = {M0[214], M0[205], M0[563], M0[231]};
wire [15:0] layer0_N406_lut = 16'h0113;
assign M1[406] = layer0_N406_lut[layer0_N406_wire];

wire [3:0] layer0_N407_wire = {M0[370], M0[397], M0[369], M0[365]};
wire [15:0] layer0_N407_lut = 16'h2233;
assign M1[407] = layer0_N407_lut[layer0_N407_wire];

wire [3:0] layer0_N408_wire = {M0[341], M0[340], M0[369], M0[387]};
wire [15:0] layer0_N408_lut = 16'h0FD3;
assign M1[408] = layer0_N408_lut[layer0_N408_wire];

wire [3:0] layer0_N409_wire = {M0[387], M0[378], M0[361], M0[260]};
wire [15:0] layer0_N409_lut = 16'hCA0E;
assign M1[409] = layer0_N409_lut[layer0_N409_wire];

wire [3:0] layer0_N410_wire = {M0[387], M0[362], M0[469], M0[305]};
wire [15:0] layer0_N410_lut = 16'h0A3F;
assign M1[410] = layer0_N410_lut[layer0_N410_wire];

wire [3:0] layer0_N411_wire = {M0[442], M0[344], M0[260], M0[376]};
wire [15:0] layer0_N411_lut = 16'hDE50;
assign M1[411] = layer0_N411_lut[layer0_N411_wire];

wire [3:0] layer0_N412_wire = {M0[688], M0[571], M0[519], M0[570]};
wire [15:0] layer0_N412_lut = 16'h00FF;
assign M1[412] = layer0_N412_lut[layer0_N412_wire];

wire [3:0] layer0_N413_wire = {M0[153], M0[124], M0[147], M0[152]};
wire [15:0] layer0_N413_lut = 16'h052B;
assign M1[413] = layer0_N413_lut[layer0_N413_wire];

wire [3:0] layer0_N414_wire = {M0[153], M0[152], M0[147], M0[154]};
wire [15:0] layer0_N414_lut = 16'hAAAE;
assign M1[414] = layer0_N414_lut[layer0_N414_wire];

wire [3:0] layer0_N415_wire = {M0[352], M0[522], M0[353], M0[482]};
wire [15:0] layer0_N415_lut = 16'h3F3D;
assign M1[415] = layer0_N415_lut[layer0_N415_wire];

wire [3:0] layer0_N416_wire = {M0[442], M0[414], M0[470], M0[415]};
wire [15:0] layer0_N416_lut = 16'hAFEE;
assign M1[416] = layer0_N416_lut[layer0_N416_wire];

wire [3:0] layer0_N417_wire = {M0[470], M0[294], M0[261], M0[262]};
wire [15:0] layer0_N417_lut = 16'hFCF0;
assign M1[417] = layer0_N417_lut[layer0_N417_wire];

wire [3:0] layer0_N418_wire = {M0[234], M0[262], M0[263], M0[235]};
wire [15:0] layer0_N418_lut = 16'h2125;
assign M1[418] = layer0_N418_lut[layer0_N418_wire];

wire [3:0] layer0_N419_wire = {M0[418], M0[171], M0[303], M0[417]};
wire [15:0] layer0_N419_lut = 16'h0D01;
assign M1[419] = layer0_N419_lut[layer0_N419_wire];

wire [3:0] layer0_N420_wire = {M0[426], M0[425], M0[590], M0[236]};
wire [15:0] layer0_N420_lut = 16'hDDF3;
assign M1[420] = layer0_N420_lut[layer0_N420_wire];

wire [3:0] layer0_N421_wire = {M0[288], M0[499], M0[716], M0[652]};
wire [15:0] layer0_N421_lut = 16'h4E4C;
assign M1[421] = layer0_N421_lut[layer0_N421_wire];

wire [3:0] layer0_N422_wire = {M0[426], M0[374], M0[578], M0[590]};
wire [15:0] layer0_N422_lut = 16'h050E;
assign M1[422] = layer0_N422_lut[layer0_N422_wire];

wire [3:0] layer0_N423_wire = {M0[459], M0[372], M0[316], M0[344]};
wire [15:0] layer0_N423_lut = 16'hA0A0;
assign M1[423] = layer0_N423_lut[layer0_N423_wire];

wire [3:0] layer0_N424_wire = {M0[714], M0[683], M0[742], M0[686]};
wire [15:0] layer0_N424_lut = 16'h5FDF;
assign M1[424] = layer0_N424_lut[layer0_N424_wire];

wire [3:0] layer0_N425_wire = {M0[742], M0[741], M0[397], M0[714]};
wire [15:0] layer0_N425_lut = 16'h0F85;
assign M1[425] = layer0_N425_lut[layer0_N425_wire];

wire [3:0] layer0_N426_wire = {M0[663], M0[665], M0[683], M0[662]};
wire [15:0] layer0_N426_lut = 16'hA800;
assign M1[426] = layer0_N426_lut[layer0_N426_wire];

wire [3:0] layer0_N427_wire = {M0[423], M0[451], M0[449], M0[537]};
wire [15:0] layer0_N427_lut = 16'hFEFE;
assign M1[427] = layer0_N427_lut[layer0_N427_wire];

wire [3:0] layer0_N428_wire = {M0[446], M0[481], M0[610], M0[449]};
wire [15:0] layer0_N428_lut = 16'h1053;
assign M1[428] = layer0_N428_lut[layer0_N428_wire];

wire [3:0] layer0_N429_wire = {M0[564], M0[291], M0[454], M0[453]};
wire [15:0] layer0_N429_lut = 16'h5433;
assign M1[429] = layer0_N429_lut[layer0_N429_wire];

wire [3:0] layer0_N430_wire = {M0[472], M0[92], M0[473], M0[450]};
wire [15:0] layer0_N430_lut = 16'h43F7;
assign M1[430] = layer0_N430_lut[layer0_N430_wire];

wire [3:0] layer0_N431_wire = {M0[481], M0[482], M0[510], M0[511]};
wire [15:0] layer0_N431_lut = 16'hC3CA;
assign M1[431] = layer0_N431_lut[layer0_N431_wire];

wire [3:0] layer0_N432_wire = {M0[519], M0[632], M0[518], M0[631]};
wire [15:0] layer0_N432_lut = 16'hAEAE;
assign M1[432] = layer0_N432_lut[layer0_N432_wire];

wire [3:0] layer0_N433_wire = {M0[208], M0[182], M0[153], M0[238]};
wire [15:0] layer0_N433_lut = 16'h5E4C;
assign M1[433] = layer0_N433_lut[layer0_N433_wire];

wire [3:0] layer0_N434_wire = {M0[514], M0[262], M0[261], M0[513]};
wire [15:0] layer0_N434_lut = 16'hFCFD;
assign M1[434] = layer0_N434_lut[layer0_N434_wire];

wire [3:0] layer0_N435_wire = {M0[519], M0[147], M0[603], M0[517]};
wire [15:0] layer0_N435_lut = 16'h75BA;
assign M1[435] = layer0_N435_lut[layer0_N435_wire];

wire [3:0] layer0_N436_wire = {M0[206], M0[341], M0[564], M0[228]};
wire [15:0] layer0_N436_lut = 16'h505F;
assign M1[436] = layer0_N436_lut[layer0_N436_wire];

wire [3:0] layer0_N437_wire = {M0[402], M0[573], M0[517], M0[543]};
wire [15:0] layer0_N437_lut = 16'h7D6F;
assign M1[437] = layer0_N437_lut[layer0_N437_wire];

wire [3:0] layer0_N438_wire = {M0[474], M0[653], M0[408], M0[658]};
wire [15:0] layer0_N438_lut = 16'hFE1F;
assign M1[438] = layer0_N438_lut[layer0_N438_wire];

wire [3:0] layer0_N439_wire = {M0[510], M0[343], M0[176], M0[554]};
wire [15:0] layer0_N439_lut = 16'h1377;
assign M1[439] = layer0_N439_lut[layer0_N439_wire];

wire [3:0] layer0_N440_wire = {M0[630], M0[495], M0[629], M0[631]};
wire [15:0] layer0_N440_lut = 16'h1D01;
assign M1[440] = layer0_N440_lut[layer0_N440_wire];

wire [3:0] layer0_N441_wire = {M0[261], M0[543], M0[551], M0[466]};
wire [15:0] layer0_N441_lut = 16'h7137;
assign M1[441] = layer0_N441_lut[layer0_N441_wire];

wire [3:0] layer0_N442_wire = {M0[241], M0[542], M0[208], M0[209]};
wire [15:0] layer0_N442_lut = 16'h10F0;
assign M1[442] = layer0_N442_lut[layer0_N442_wire];

wire [3:0] layer0_N443_wire = {M0[338], M0[556], M0[381], M0[282]};
wire [15:0] layer0_N443_lut = 16'hAB23;
assign M1[443] = layer0_N443_lut[layer0_N443_wire];

wire [3:0] layer0_N444_wire = {M0[201], M0[453], M0[228], M0[399]};
wire [15:0] layer0_N444_lut = 16'h0033;
assign M1[444] = layer0_N444_lut[layer0_N444_wire];

wire [3:0] layer0_N445_wire = {M0[430], M0[421], M0[393], M0[424]};
wire [15:0] layer0_N445_lut = 16'hDCFC;
assign M1[445] = layer0_N445_lut[layer0_N445_wire];

wire [3:0] layer0_N446_wire = {M0[433], M0[424], M0[511], M0[107]};
wire [15:0] layer0_N446_lut = 16'hAAAA;
assign M1[446] = layer0_N446_lut[layer0_N446_wire];

wire [3:0] layer0_N447_wire = {M0[244], M0[159], M0[217], M0[187]};
wire [15:0] layer0_N447_lut = 16'hFCAE;
assign M1[447] = layer0_N447_lut[layer0_N447_wire];

wire [3:0] layer0_N448_wire = {M0[377], M0[403], M0[567], M0[284]};
wire [15:0] layer0_N448_lut = 16'hFAF0;
assign M1[448] = layer0_N448_lut[layer0_N448_wire];

wire [3:0] layer0_N449_wire = {M0[292], M0[464], M0[492], M0[436]};
wire [15:0] layer0_N449_lut = 16'hDD01;
assign M1[449] = layer0_N449_lut[layer0_N449_wire];

wire [3:0] layer0_N450_wire = {M0[464], M0[492], M0[548], M0[436]};
wire [15:0] layer0_N450_lut = 16'h7F1A;
assign M1[450] = layer0_N450_lut[layer0_N450_wire];

wire [3:0] layer0_N451_wire = {M0[349], M0[353], M0[548], M0[408]};
wire [15:0] layer0_N451_lut = 16'h3037;
assign M1[451] = layer0_N451_lut[layer0_N451_wire];

wire [3:0] layer0_N452_wire = {M0[190], M0[218], M0[217], M0[483]};
wire [15:0] layer0_N452_lut = 16'h0077;
assign M1[452] = layer0_N452_lut[layer0_N452_wire];

wire [3:0] layer0_N453_wire = {M0[418], M0[342], M0[442], M0[314]};
wire [15:0] layer0_N453_lut = 16'hD8A5;
assign M1[453] = layer0_N453_lut[layer0_N453_wire];

wire [3:0] layer0_N454_wire = {M0[288], M0[350], M0[228], M0[256]};
wire [15:0] layer0_N454_lut = 16'h153F;
assign M1[454] = layer0_N454_lut[layer0_N454_wire];

wire [3:0] layer0_N455_wire = {M0[397], M0[394], M0[159], M0[418]};
wire [15:0] layer0_N455_lut = 16'h3405;
assign M1[455] = layer0_N455_lut[layer0_N455_wire];

wire [3:0] layer0_N456_wire = {M0[244], M0[229], M0[715], M0[271]};
wire [15:0] layer0_N456_lut = 16'h448D;
assign M1[456] = layer0_N456_lut[layer0_N456_wire];

wire [3:0] layer0_N457_wire = {M0[340], M0[217], M0[312], M0[232]};
wire [15:0] layer0_N457_lut = 16'hF8F2;
assign M1[457] = layer0_N457_lut[layer0_N457_wire];

wire [3:0] layer0_N458_wire = {M0[244], M0[375], M0[623], M0[340]};
wire [15:0] layer0_N458_lut = 16'h4C5F;
assign M1[458] = layer0_N458_lut[layer0_N458_wire];

wire [3:0] layer0_N459_wire = {M0[334], M0[164], M0[712], M0[676]};
wire [15:0] layer0_N459_lut = 16'hB2FB;
assign M1[459] = layer0_N459_lut[layer0_N459_wire];

wire [3:0] layer0_N460_wire = {M0[375], M0[278], M0[305], M0[378]};
wire [15:0] layer0_N460_lut = 16'hFDFA;
assign M1[460] = layer0_N460_lut[layer0_N460_wire];

wire [3:0] layer0_N461_wire = {M0[278], M0[568], M0[305], M0[306]};
wire [15:0] layer0_N461_lut = 16'hDD4C;
assign M1[461] = layer0_N461_lut[layer0_N461_wire];

wire [3:0] layer0_N462_wire = {M0[153], M0[154], M0[349], M0[182]};
wire [15:0] layer0_N462_lut = 16'hFEAA;
assign M1[462] = layer0_N462_lut[layer0_N462_wire];

wire [3:0] layer0_N463_wire = {M0[490], M0[568], M0[462], M0[385]};
wire [15:0] layer0_N463_lut = 16'hFEFE;
assign M1[463] = layer0_N463_lut[layer0_N463_wire];

wire [3:0] layer0_N464_wire = {M0[210], M0[274], M0[272], M0[273]};
wire [15:0] layer0_N464_lut = 16'h13FB;
assign M1[464] = layer0_N464_lut[layer0_N464_wire];

wire [3:0] layer0_N465_wire = {M0[95], M0[70], M0[152], M0[69]};
wire [15:0] layer0_N465_lut = 16'h0C1D;
assign M1[465] = layer0_N465_lut[layer0_N465_wire];

wire [3:0] layer0_N466_wire = {M0[294], M0[350], M0[469], M0[496]};
wire [15:0] layer0_N466_lut = 16'hFF00;
assign M1[466] = layer0_N466_lut[layer0_N466_wire];

wire [3:0] layer0_N467_wire = {M0[95], M0[152], M0[70], M0[71]};
wire [15:0] layer0_N467_lut = 16'hFFF8;
assign M1[467] = layer0_N467_lut[layer0_N467_wire];

wire [3:0] layer0_N468_wire = {M0[462], M0[431], M0[461], M0[463]};
wire [15:0] layer0_N468_lut = 16'h0313;
assign M1[468] = layer0_N468_lut[layer0_N468_wire];

wire [3:0] layer0_N469_wire = {M0[517], M0[439], M0[459], M0[435]};
wire [15:0] layer0_N469_lut = 16'hFFEC;
assign M1[469] = layer0_N469_lut[layer0_N469_wire];

wire [3:0] layer0_N470_wire = {M0[437], M0[485], M0[439], M0[327]};
wire [15:0] layer0_N470_lut = 16'hB8B0;
assign M1[470] = layer0_N470_lut[layer0_N470_wire];

wire [3:0] layer0_N471_wire = {M0[438], M0[357], M0[431], M0[484]};
wire [15:0] layer0_N471_lut = 16'h0111;
assign M1[471] = layer0_N471_lut[layer0_N471_wire];

wire [3:0] layer0_N472_wire = {M0[351], M0[239], M0[375], M0[403]};
wire [15:0] layer0_N472_lut = 16'h4444;
assign M1[472] = layer0_N472_lut[layer0_N472_wire];

wire [3:0] layer0_N473_wire = {M0[351], M0[376], M0[375], M0[379]};
wire [15:0] layer0_N473_lut = 16'h4101;
assign M1[473] = layer0_N473_lut[layer0_N473_wire];

wire [3:0] layer0_N474_wire = {M0[405], M0[457], M0[349], M0[557]};
wire [15:0] layer0_N474_lut = 16'hFF32;
assign M1[474] = layer0_N474_lut[layer0_N474_wire];

wire [3:0] layer0_N475_wire = {M0[510], M0[382], M0[613], M0[328]};
wire [15:0] layer0_N475_lut = 16'h1B1B;
assign M1[475] = layer0_N475_lut[layer0_N475_wire];

wire [3:0] layer0_N476_wire = {M0[480], M0[398], M0[382], M0[285]};
wire [15:0] layer0_N476_lut = 16'hAA04;
assign M1[476] = layer0_N476_lut[layer0_N476_wire];

wire [3:0] layer0_N477_wire = {M0[471], M0[594], M0[484], M0[402]};
wire [15:0] layer0_N477_lut = 16'hF8FC;
assign M1[477] = layer0_N477_lut[layer0_N477_wire];

wire [3:0] layer0_N478_wire = {M0[428], M0[395], M0[343], M0[469]};
wire [15:0] layer0_N478_lut = 16'hEE8C;
assign M1[478] = layer0_N478_lut[layer0_N478_wire];

wire [3:0] layer0_N479_wire = {M0[298], M0[267], M0[349], M0[543]};
wire [15:0] layer0_N479_lut = 16'h83A3;
assign M1[479] = layer0_N479_lut[layer0_N479_wire];

wire [3:0] layer0_N480_wire = {M0[268], M0[367], M0[288], M0[269]};
wire [15:0] layer0_N480_lut = 16'hE8F8;
assign M1[480] = layer0_N480_lut[layer0_N480_wire];

wire [3:0] layer0_N481_wire = {M0[522], M0[428], M0[384], M0[385]};
wire [15:0] layer0_N481_lut = 16'h7717;
assign M1[481] = layer0_N481_lut[layer0_N481_wire];

wire [3:0] layer0_N482_wire = {M0[371], M0[317], M0[428], M0[440]};
wire [15:0] layer0_N482_lut = 16'h51F5;
assign M1[482] = layer0_N482_lut[layer0_N482_wire];

wire [3:0] layer0_N483_wire = {M0[426], M0[427], M0[428], M0[368]};
wire [15:0] layer0_N483_lut = 16'h1FFF;
assign M1[483] = layer0_N483_lut[layer0_N483_wire];

wire [3:0] layer0_N484_wire = {M0[425], M0[347], M0[610], M0[653]};
wire [15:0] layer0_N484_lut = 16'h0F05;
assign M1[484] = layer0_N484_lut[layer0_N484_wire];

wire [3:0] layer0_N485_wire = {M0[425], M0[453], M0[536], M0[347]};
wire [15:0] layer0_N485_lut = 16'h000F;
assign M1[485] = layer0_N485_lut[layer0_N485_wire];

wire [3:0] layer0_N486_wire = {M0[347], M0[653], M0[268], M0[296]};
wire [15:0] layer0_N486_lut = 16'h8915;
assign M1[486] = layer0_N486_lut[layer0_N486_wire];

wire [3:0] layer0_N487_wire = {M0[453], M0[574], M0[174], M0[602]};
wire [15:0] layer0_N487_lut = 16'h88D8;
assign M1[487] = layer0_N487_lut[layer0_N487_wire];

wire [3:0] layer0_N488_wire = {M0[648], M0[174], M0[337], M0[121]};
wire [15:0] layer0_N488_lut = 16'h0407;
assign M1[488] = layer0_N488_lut[layer0_N488_wire];

wire [3:0] layer0_N489_wire = {M0[666], M0[343], M0[290], M0[342]};
wire [15:0] layer0_N489_lut = 16'h5157;
assign M1[489] = layer0_N489_lut[layer0_N489_wire];

wire [3:0] layer0_N490_wire = {M0[399], M0[618], M0[398], M0[555]};
wire [15:0] layer0_N490_lut = 16'hEF8C;
assign M1[490] = layer0_N490_lut[layer0_N490_wire];

wire [3:0] layer0_N491_wire = {M0[683], M0[315], M0[342], M0[346]};
wire [15:0] layer0_N491_lut = 16'hC8CC;
assign M1[491] = layer0_N491_lut[layer0_N491_wire];

wire [3:0] layer0_N492_wire = {M0[460], M0[431], M0[433], M0[270]};
wire [15:0] layer0_N492_lut = 16'hE3A3;
assign M1[492] = layer0_N492_lut[layer0_N492_wire];

wire [3:0] layer0_N493_wire = {M0[433], M0[434], M0[437], M0[517]};
wire [15:0] layer0_N493_lut = 16'hD50B;
assign M1[493] = layer0_N493_lut[layer0_N493_wire];

wire [3:0] layer0_N494_wire = {M0[264], M0[551], M0[450], M0[478]};
wire [15:0] layer0_N494_lut = 16'hB901;
assign M1[494] = layer0_N494_lut[layer0_N494_wire];

wire [3:0] layer0_N495_wire = {M0[433], M0[517], M0[436], M0[435]};
wire [15:0] layer0_N495_lut = 16'h70AE;
assign M1[495] = layer0_N495_lut[layer0_N495_wire];

wire [3:0] layer0_N496_wire = {M0[628], M0[683], M0[713], M0[567]};
wire [15:0] layer0_N496_lut = 16'hDCEE;
assign M1[496] = layer0_N496_lut[layer0_N496_wire];

wire [3:0] layer0_N497_wire = {M0[201], M0[228], M0[332], M0[339]};
wire [15:0] layer0_N497_lut = 16'h035F;
assign M1[497] = layer0_N497_lut[layer0_N497_wire];

wire [3:0] layer0_N498_wire = {M0[683], M0[716], M0[715], M0[687]};
wire [15:0] layer0_N498_lut = 16'h0241;
assign M1[498] = layer0_N498_lut[layer0_N498_wire];

wire [3:0] layer0_N499_wire = {M0[719], M0[74], M0[659], M0[582]};
wire [15:0] layer0_N499_lut = 16'h000B;
assign M1[499] = layer0_N499_lut[layer0_N499_wire];

wire [3:0] layer0_N500_wire = {M0[526], M0[536], M0[507], M0[511]};
wire [15:0] layer0_N500_lut = 16'hFECE;
assign M1[500] = layer0_N500_lut[layer0_N500_wire];

wire [3:0] layer0_N501_wire = {M0[536], M0[509], M0[131], M0[507]};
wire [15:0] layer0_N501_lut = 16'hFAFA;
assign M1[501] = layer0_N501_lut[layer0_N501_wire];

wire [3:0] layer0_N502_wire = {M0[276], M0[571], M0[278], M0[230]};
wire [15:0] layer0_N502_lut = 16'h4FFF;
assign M1[502] = layer0_N502_lut[layer0_N502_wire];

wire [3:0] layer0_N503_wire = {M0[526], M0[347], M0[348], M0[549]};
wire [15:0] layer0_N503_lut = 16'hFFBA;
assign M1[503] = layer0_N503_lut[layer0_N503_wire];

wire [3:0] layer0_N504_wire = {M0[636], M0[637], M0[465], M0[517]};
wire [15:0] layer0_N504_lut = 16'hFFF4;
assign M1[504] = layer0_N504_lut[layer0_N504_wire];

wire [3:0] layer0_N505_wire = {M0[305], M0[528], M0[333], M0[306]};
wire [15:0] layer0_N505_lut = 16'h22F6;
assign M1[505] = layer0_N505_lut[layer0_N505_wire];

wire [3:0] layer0_N506_wire = {M0[147], M0[332], M0[737], M0[95]};
wire [15:0] layer0_N506_lut = 16'hFEF8;
assign M1[506] = layer0_N506_lut[layer0_N506_wire];

wire [3:0] layer0_N507_wire = {M0[630], M0[582], M0[534], M0[565]};
wire [15:0] layer0_N507_lut = 16'hBB13;
assign M1[507] = layer0_N507_lut[layer0_N507_wire];

wire [3:0] layer0_N508_wire = {M0[602], M0[284], M0[495], M0[612]};
wire [15:0] layer0_N508_lut = 16'h8EC4;
assign M1[508] = layer0_N508_lut[layer0_N508_wire];

wire [3:0] layer0_N509_wire = {M0[343], M0[356], M0[510], M0[149]};
wire [15:0] layer0_N509_lut = 16'h3323;
assign M1[509] = layer0_N509_lut[layer0_N509_wire];

wire [3:0] layer0_N510_wire = {M0[230], M0[666], M0[353], M0[484]};
wire [15:0] layer0_N510_lut = 16'h5555;
assign M1[510] = layer0_N510_lut[layer0_N510_wire];

wire [3:0] layer0_N511_wire = {M0[356], M0[210], M0[149], M0[367]};
wire [15:0] layer0_N511_lut = 16'hFEFC;
assign M1[511] = layer0_N511_lut[layer0_N511_wire];

wire [3:0] layer0_N512_wire = {M0[411], M0[650], M0[410], M0[494]};
wire [15:0] layer0_N512_lut = 16'h0015;
assign M1[512] = layer0_N512_lut[layer0_N512_wire];

wire [3:0] layer0_N513_wire = {M0[217], M0[246], M0[218], M0[163]};
wire [15:0] layer0_N513_lut = 16'h74EE;
assign M1[513] = layer0_N513_lut[layer0_N513_wire];

wire [3:0] layer0_N514_wire = {M0[325], M0[544], M0[406], M0[545]};
wire [15:0] layer0_N514_lut = 16'hFFDC;
assign M1[514] = layer0_N514_lut[layer0_N514_wire];

wire [3:0] layer0_N515_wire = {M0[357], M0[331], M0[358], M0[414]};
wire [15:0] layer0_N515_lut = 16'h0087;
assign M1[515] = layer0_N515_lut[layer0_N515_wire];

wire [3:0] layer0_N516_wire = {M0[302], M0[131], M0[95], M0[148]};
wire [15:0] layer0_N516_lut = 16'h0303;
assign M1[516] = layer0_N516_lut[layer0_N516_wire];

wire [3:0] layer0_N517_wire = {M0[92], M0[180], M0[302], M0[99]};
wire [15:0] layer0_N517_lut = 16'h0445;
assign M1[517] = layer0_N517_lut[layer0_N517_wire];

wire [3:0] layer0_N518_wire = {M0[515], M0[688], M0[379], M0[150]};
wire [15:0] layer0_N518_lut = 16'hAAFA;
assign M1[518] = layer0_N518_lut[layer0_N518_wire];

wire [3:0] layer0_N519_wire = {M0[180], M0[486], M0[126], M0[190]};
wire [15:0] layer0_N519_lut = 16'hEEEE;
assign M1[519] = layer0_N519_lut[layer0_N519_wire];

wire [3:0] layer0_N520_wire = {M0[533], M0[557], M0[529], M0[534]};
wire [15:0] layer0_N520_lut = 16'hFFF8;
assign M1[520] = layer0_N520_lut[layer0_N520_wire];

wire [3:0] layer0_N521_wire = {M0[480], M0[290], M0[454], M0[534]};
wire [15:0] layer0_N521_lut = 16'h45AA;
assign M1[521] = layer0_N521_lut[layer0_N521_wire];

wire [3:0] layer0_N522_wire = {M0[562], M0[533], M0[595], M0[596]};
wire [15:0] layer0_N522_lut = 16'h0C4C;
assign M1[522] = layer0_N522_lut[layer0_N522_wire];

wire [3:0] layer0_N523_wire = {M0[557], M0[657], M0[562], M0[585]};
wire [15:0] layer0_N523_lut = 16'hEF05;
assign M1[523] = layer0_N523_lut[layer0_N523_wire];

wire [3:0] layer0_N524_wire = {M0[534], M0[563], M0[533], M0[562]};
wire [15:0] layer0_N524_lut = 16'h05EF;
assign M1[524] = layer0_N524_lut[layer0_N524_wire];

wire [3:0] layer0_N525_wire = {M0[538], M0[536], M0[507], M0[526]};
wire [15:0] layer0_N525_lut = 16'hF7E2;
assign M1[525] = layer0_N525_lut[layer0_N525_wire];

wire [3:0] layer0_N526_wire = {M0[410], M0[322], M0[412], M0[411]};
wire [15:0] layer0_N526_lut = 16'hFFFC;
assign M1[526] = layer0_N526_lut[layer0_N526_wire];

wire [3:0] layer0_N527_wire = {M0[461], M0[460], M0[534], M0[459]};
wire [15:0] layer0_N527_lut = 16'h3030;
assign M1[527] = layer0_N527_lut[layer0_N527_wire];

wire [3:0] layer0_N528_wire = {M0[405], M0[404], M0[406], M0[408]};
wire [15:0] layer0_N528_lut = 16'hEAF4;
assign M1[528] = layer0_N528_lut[layer0_N528_wire];

wire [3:0] layer0_N529_wire = {M0[490], M0[370], M0[489], M0[488]};
wire [15:0] layer0_N529_lut = 16'h3155;
assign M1[529] = layer0_N529_lut[layer0_N529_wire];

wire [3:0] layer0_N530_wire = {M0[406], M0[408], M0[405], M0[410]};
wire [15:0] layer0_N530_lut = 16'hA0A5;
assign M1[530] = layer0_N530_lut[layer0_N530_wire];

wire [3:0] layer0_N531_wire = {M0[436], M0[435], M0[430], M0[429]};
wire [15:0] layer0_N531_lut = 16'h8001;
assign M1[531] = layer0_N531_lut[layer0_N531_wire];

wire [3:0] layer0_N532_wire = {M0[268], M0[267], M0[235], M0[347]};
wire [15:0] layer0_N532_lut = 16'hFCF8;
assign M1[532] = layer0_N532_lut[layer0_N532_wire];

wire [3:0] layer0_N533_wire = {M0[286], M0[422], M0[449], M0[394]};
wire [15:0] layer0_N533_lut = 16'h8103;
assign M1[533] = layer0_N533_lut[layer0_N533_wire];

wire [3:0] layer0_N534_wire = {M0[235], M0[268], M0[239], M0[267]};
wire [15:0] layer0_N534_lut = 16'hFEEA;
assign M1[534] = layer0_N534_lut[layer0_N534_wire];

wire [3:0] layer0_N535_wire = {M0[404], M0[500], M0[403], M0[571]};
wire [15:0] layer0_N535_lut = 16'h5D4D;
assign M1[535] = layer0_N535_lut[layer0_N535_wire];

wire [3:0] layer0_N536_wire = {M0[450], M0[261], M0[394], M0[426]};
wire [15:0] layer0_N536_lut = 16'hCC00;
assign M1[536] = layer0_N536_lut[layer0_N536_wire];

wire [3:0] layer0_N537_wire = {M0[429], M0[457], M0[352], M0[428]};
wire [15:0] layer0_N537_lut = 16'h3355;
assign M1[537] = layer0_N537_lut[layer0_N537_wire];

wire [3:0] layer0_N538_wire = {M0[432], M0[535], M0[433], M0[456]};
wire [15:0] layer0_N538_lut = 16'hF2FF;
assign M1[538] = layer0_N538_lut[layer0_N538_wire];

wire [3:0] layer0_N539_wire = {M0[429], M0[401], M0[352], M0[350]};
wire [15:0] layer0_N539_lut = 16'hE988;
assign M1[539] = layer0_N539_lut[layer0_N539_wire];

wire [3:0] layer0_N540_wire = {M0[459], M0[569], M0[648], M0[556]};
wire [15:0] layer0_N540_lut = 16'h0333;
assign M1[540] = layer0_N540_lut[layer0_N540_wire];

wire [3:0] layer0_N541_wire = {M0[556], M0[459], M0[400], M0[430]};
wire [15:0] layer0_N541_lut = 16'h8E0C;
assign M1[541] = layer0_N541_lut[layer0_N541_wire];

wire [3:0] layer0_N542_wire = {M0[219], M0[367], M0[220], M0[303]};
wire [15:0] layer0_N542_lut = 16'h1507;
assign M1[542] = layer0_N542_lut[layer0_N542_wire];

wire [3:0] layer0_N543_wire = {M0[133], M0[206], M0[459], M0[460]};
wire [15:0] layer0_N543_lut = 16'hFFBA;
assign M1[543] = layer0_N543_lut[layer0_N543_wire];

wire [3:0] layer0_N544_wire = {M0[272], M0[371], M0[546], M0[183]};
wire [15:0] layer0_N544_lut = 16'hA0EE;
assign M1[544] = layer0_N544_lut[layer0_N544_wire];

wire [3:0] layer0_N545_wire = {M0[594], M0[527], M0[272], M0[546]};
wire [15:0] layer0_N545_lut = 16'h0782;
assign M1[545] = layer0_N545_lut[layer0_N545_wire];

wire [3:0] layer0_N546_wire = {M0[278], M0[362], M0[450], M0[277]};
wire [15:0] layer0_N546_lut = 16'h44D5;
assign M1[546] = layer0_N546_lut[layer0_N546_wire];

wire [3:0] layer0_N547_wire = {M0[312], M0[593], M0[449], M0[311]};
wire [15:0] layer0_N547_lut = 16'h332E;
assign M1[547] = layer0_N547_lut[layer0_N547_wire];

wire [3:0] layer0_N548_wire = {M0[302], M0[535], M0[536], M0[329]};
wire [15:0] layer0_N548_lut = 16'h1503;
assign M1[548] = layer0_N548_lut[layer0_N548_wire];

wire [3:0] layer0_N549_wire = {M0[329], M0[710], M0[330], M0[254]};
wire [15:0] layer0_N549_lut = 16'h0515;
assign M1[549] = layer0_N549_lut[layer0_N549_wire];

wire [3:0] layer0_N550_wire = {M0[283], M0[562], M0[572], M0[553]};
wire [15:0] layer0_N550_lut = 16'hFF0F;
assign M1[550] = layer0_N550_lut[layer0_N550_wire];

wire [3:0] layer0_N551_wire = {M0[330], M0[441], M0[302], M0[329]};
wire [15:0] layer0_N551_lut = 16'hCD2F;
assign M1[551] = layer0_N551_lut[layer0_N551_wire];

wire [3:0] layer0_N552_wire = {M0[422], M0[430], M0[161], M0[48]};
wire [15:0] layer0_N552_lut = 16'hF070;
assign M1[552] = layer0_N552_lut[layer0_N552_wire];

wire [3:0] layer0_N553_wire = {M0[401], M0[289], M0[374], M0[487]};
wire [15:0] layer0_N553_lut = 16'hEFFC;
assign M1[553] = layer0_N553_lut[layer0_N553_wire];

wire [3:0] layer0_N554_wire = {M0[542], M0[48], M0[514], M0[264]};
wire [15:0] layer0_N554_lut = 16'hAABB;
assign M1[554] = layer0_N554_lut[layer0_N554_wire];

wire [3:0] layer0_N555_wire = {M0[686], M0[486], M0[458], M0[514]};
wire [15:0] layer0_N555_lut = 16'h0D0B;
assign M1[555] = layer0_N555_lut[layer0_N555_wire];

wire [3:0] layer0_N556_wire = {M0[609], M0[715], M0[637], M0[608]};
wire [15:0] layer0_N556_lut = 16'hAF0F;
assign M1[556] = layer0_N556_lut[layer0_N556_wire];

wire [3:0] layer0_N557_wire = {M0[708], M0[637], M0[214], M0[267]};
wire [15:0] layer0_N557_lut = 16'hFFF7;
assign M1[557] = layer0_N557_lut[layer0_N557_wire];

wire [3:0] layer0_N558_wire = {M0[282], M0[283], M0[227], M0[310]};
wire [15:0] layer0_N558_lut = 16'hABC2;
assign M1[558] = layer0_N558_lut[layer0_N558_wire];

wire [3:0] layer0_N559_wire = {M0[376], M0[581], M0[609], M0[147]};
wire [15:0] layer0_N559_lut = 16'h02AA;
assign M1[559] = layer0_N559_lut[layer0_N559_wire];

wire [3:0] layer0_N560_wire = {M0[546], M0[574], M0[547], M0[429]};
wire [15:0] layer0_N560_lut = 16'hB9B1;
assign M1[560] = layer0_N560_lut[layer0_N560_wire];

wire [3:0] layer0_N561_wire = {M0[304], M0[719], M0[722], M0[660]};
wire [15:0] layer0_N561_lut = 16'h320D;
assign M1[561] = layer0_N561_lut[layer0_N561_wire];

wire [3:0] layer0_N562_wire = {M0[599], M0[600], M0[523], M0[394]};
wire [15:0] layer0_N562_lut = 16'hAAAA;
assign M1[562] = layer0_N562_lut[layer0_N562_wire];

wire [3:0] layer0_N563_wire = {M0[382], M0[602], M0[597], M0[424]};
wire [15:0] layer0_N563_lut = 16'hFDFD;
assign M1[563] = layer0_N563_lut[layer0_N563_wire];

wire [3:0] layer0_N564_wire = {M0[487], M0[451], M0[479], M0[500]};
wire [15:0] layer0_N564_lut = 16'h4101;
assign M1[564] = layer0_N564_lut[layer0_N564_wire];

wire [3:0] layer0_N565_wire = {M0[247], M0[488], M0[490], M0[487]};
wire [15:0] layer0_N565_lut = 16'hDC80;
assign M1[565] = layer0_N565_lut[layer0_N565_wire];

wire [3:0] layer0_N566_wire = {M0[454], M0[92], M0[96], M0[457]};
wire [15:0] layer0_N566_lut = 16'hB322;
assign M1[566] = layer0_N566_lut[layer0_N566_wire];

wire [3:0] layer0_N567_wire = {M0[496], M0[491], M0[522], M0[497]};
wire [15:0] layer0_N567_lut = 16'h5F2E;
assign M1[567] = layer0_N567_lut[layer0_N567_wire];

wire [3:0] layer0_N568_wire = {M0[180], M0[179], M0[527], M0[244]};
wire [15:0] layer0_N568_lut = 16'h002E;
assign M1[568] = layer0_N568_lut[layer0_N568_wire];

wire [3:0] layer0_N569_wire = {M0[161], M0[204], M0[461], M0[517]};
wire [15:0] layer0_N569_lut = 16'h026E;
assign M1[569] = layer0_N569_lut[layer0_N569_wire];

wire [3:0] layer0_N570_wire = {M0[174], M0[367], M0[145], M0[258]};
wire [15:0] layer0_N570_lut = 16'h1031;
assign M1[570] = layer0_N570_lut[layer0_N570_wire];

wire [3:0] layer0_N571_wire = {M0[182], M0[161], M0[344], M0[272]};
wire [15:0] layer0_N571_lut = 16'h5301;
assign M1[571] = layer0_N571_lut[layer0_N571_wire];

wire [3:0] layer0_N572_wire = {M0[567], M0[539], M0[568], M0[596]};
wire [15:0] layer0_N572_lut = 16'hB4BD;
assign M1[572] = layer0_N572_lut[layer0_N572_wire];

wire [3:0] layer0_N573_wire = {M0[284], M0[256], M0[312], M0[345]};
wire [15:0] layer0_N573_lut = 16'hFFF0;
assign M1[573] = layer0_N573_lut[layer0_N573_wire];

wire [3:0] layer0_N574_wire = {M0[480], M0[508], M0[512], M0[479]};
wire [15:0] layer0_N574_lut = 16'h3DAE;
assign M1[574] = layer0_N574_lut[layer0_N574_wire];

wire [3:0] layer0_N575_wire = {M0[311], M0[262], M0[410], M0[290]};
wire [15:0] layer0_N575_lut = 16'hD1FE;
assign M1[575] = layer0_N575_lut[layer0_N575_wire];

wire [3:0] layer0_N576_wire = {M0[397], M0[452], M0[439], M0[481]};
wire [15:0] layer0_N576_lut = 16'h0505;
assign M1[576] = layer0_N576_lut[layer0_N576_wire];

wire [3:0] layer0_N577_wire = {M0[159], M0[341], M0[147], M0[300]};
wire [15:0] layer0_N577_lut = 16'hFFEC;
assign M1[577] = layer0_N577_lut[layer0_N577_wire];

wire [3:0] layer0_N578_wire = {M0[328], M0[312], M0[327], M0[285]};
wire [15:0] layer0_N578_lut = 16'h3B3B;
assign M1[578] = layer0_N578_lut[layer0_N578_wire];

wire [3:0] layer0_N579_wire = {M0[190], M0[367], M0[412], M0[377]};
wire [15:0] layer0_N579_lut = 16'h00FC;
assign M1[579] = layer0_N579_lut[layer0_N579_wire];

wire [3:0] layer0_N580_wire = {M0[601], M0[629], M0[574], M0[450]};
wire [15:0] layer0_N580_lut = 16'h22B2;
assign M1[580] = layer0_N580_lut[layer0_N580_wire];

wire [3:0] layer0_N581_wire = {M0[477], M0[573], M0[572], M0[544]};
wire [15:0] layer0_N581_lut = 16'h67E7;
assign M1[581] = layer0_N581_lut[layer0_N581_wire];

wire [3:0] layer0_N582_wire = {M0[629], M0[657], M0[656], M0[685]};
wire [15:0] layer0_N582_lut = 16'hBC15;
assign M1[582] = layer0_N582_lut[layer0_N582_wire];

wire [3:0] layer0_N583_wire = {M0[656], M0[657], M0[629], M0[630]};
wire [15:0] layer0_N583_lut = 16'hEEEE;
assign M1[583] = layer0_N583_lut[layer0_N583_wire];

wire [3:0] layer0_N584_wire = {M0[328], M0[519], M0[295], M0[518]};
wire [15:0] layer0_N584_lut = 16'hBAFA;
assign M1[584] = layer0_N584_lut[layer0_N584_wire];

wire [3:0] layer0_N585_wire = {M0[571], M0[450], M0[478], M0[574]};
wire [15:0] layer0_N585_lut = 16'h51DF;
assign M1[585] = layer0_N585_lut[layer0_N585_wire];

wire [3:0] layer0_N586_wire = {M0[375], M0[294], M0[293], M0[606]};
wire [15:0] layer0_N586_lut = 16'h5D5D;
assign M1[586] = layer0_N586_lut[layer0_N586_wire];

wire [3:0] layer0_N587_wire = {M0[528], M0[580], M0[714], M0[426]};
wire [15:0] layer0_N587_lut = 16'hF000;
assign M1[587] = layer0_N587_lut[layer0_N587_wire];

wire [3:0] layer0_N588_wire = {M0[388], M0[529], M0[668], M0[584]};
wire [15:0] layer0_N588_lut = 16'h2537;
assign M1[588] = layer0_N588_lut[layer0_N588_wire];

wire [3:0] layer0_N589_wire = {M0[683], M0[437], M0[648], M0[654]};
wire [15:0] layer0_N589_lut = 16'hC8D8;
assign M1[589] = layer0_N589_lut[layer0_N589_wire];

wire [3:0] layer0_N590_wire = {M0[556], M0[529], M0[528], M0[610]};
wire [15:0] layer0_N590_lut = 16'hFF1D;
assign M1[590] = layer0_N590_lut[layer0_N590_wire];

wire [3:0] layer0_N591_wire = {M0[388], M0[562], M0[683], M0[685]};
wire [15:0] layer0_N591_lut = 16'h8FC5;
assign M1[591] = layer0_N591_lut[layer0_N591_wire];

wire [3:0] layer0_N592_wire = {M0[259], M0[299], M0[409], M0[306]};
wire [15:0] layer0_N592_lut = 16'hAA2F;
assign M1[592] = layer0_N592_lut[layer0_N592_wire];

wire [3:0] layer0_N593_wire = {M0[238], M0[264], M0[236], M0[237]};
wire [15:0] layer0_N593_lut = 16'h47EF;
assign M1[593] = layer0_N593_lut[layer0_N593_wire];

wire [3:0] layer0_N594_wire = {M0[265], M0[121], M0[306], M0[264]};
wire [15:0] layer0_N594_lut = 16'hF9FE;
assign M1[594] = layer0_N594_lut[layer0_N594_wire];

wire [3:0] layer0_N595_wire = {M0[242], M0[82], M0[75], M0[617]};
wire [15:0] layer0_N595_lut = 16'h1011;
assign M1[595] = layer0_N595_lut[layer0_N595_wire];

wire [3:0] layer0_N596_wire = {M0[535], M0[261], M0[219], M0[172]};
wire [15:0] layer0_N596_lut = 16'h1111;
assign M1[596] = layer0_N596_lut[layer0_N596_wire];

wire [3:0] layer0_N597_wire = {M0[600], M0[572], M0[571], M0[387]};
wire [15:0] layer0_N597_lut = 16'hF02C;
assign M1[597] = layer0_N597_lut[layer0_N597_wire];

wire [3:0] layer0_N598_wire = {M0[294], M0[267], M0[301], M0[295]};
wire [15:0] layer0_N598_lut = 16'hDDAE;
assign M1[598] = layer0_N598_lut[layer0_N598_wire];

wire [3:0] layer0_N599_wire = {M0[489], M0[172], M0[152], M0[174]};
wire [15:0] layer0_N599_lut = 16'hFEFE;
assign M1[599] = layer0_N599_lut[layer0_N599_wire];

wire [3:0] layer0_N600_wire = {M0[489], M0[375], M0[594], M0[403]};
wire [15:0] layer0_N600_lut = 16'hFF3B;
assign M1[600] = layer0_N600_lut[layer0_N600_wire];

wire [3:0] layer0_N601_wire = {M0[39], M0[132], M0[266], M0[209]};
wire [15:0] layer0_N601_lut = 16'h040F;
assign M1[601] = layer0_N601_lut[layer0_N601_wire];

wire [3:0] layer0_N602_wire = {M0[480], M0[509], M0[537], M0[452]};
wire [15:0] layer0_N602_lut = 16'h7FFA;
assign M1[602] = layer0_N602_lut[layer0_N602_wire];

wire [3:0] layer0_N603_wire = {M0[394], M0[395], M0[367], M0[497]};
wire [15:0] layer0_N603_lut = 16'h2FB3;
assign M1[603] = layer0_N603_lut[layer0_N603_wire];

wire [3:0] layer0_N604_wire = {M0[656], M0[657], M0[291], M0[561]};
wire [15:0] layer0_N604_lut = 16'h00FB;
assign M1[604] = layer0_N604_lut[layer0_N604_wire];

wire [3:0] layer0_N605_wire = {M0[659], M0[660], M0[602], M0[715]};
wire [15:0] layer0_N605_lut = 16'hFF51;
assign M1[605] = layer0_N605_lut[layer0_N605_wire];

wire [3:0] layer0_N606_wire = {M0[659], M0[660], M0[658], M0[135]};
wire [15:0] layer0_N606_lut = 16'hC0C0;
assign M1[606] = layer0_N606_lut[layer0_N606_wire];

wire [3:0] layer0_N607_wire = {M0[714], M0[659], M0[658], M0[255]};
wire [15:0] layer0_N607_lut = 16'h5300;
assign M1[607] = layer0_N607_lut[layer0_N607_wire];

wire [3:0] layer0_N608_wire = {M0[35], M0[540], M0[546], M0[519]};
wire [15:0] layer0_N608_lut = 16'hCFCD;
assign M1[608] = layer0_N608_lut[layer0_N608_wire];

wire [3:0] layer0_N609_wire = {M0[525], M0[524], M0[553], M0[344]};
wire [15:0] layer0_N609_lut = 16'hFEF8;
assign M1[609] = layer0_N609_lut[layer0_N609_wire];

wire [3:0] layer0_N610_wire = {M0[35], M0[271], M0[39], M0[36]};
wire [15:0] layer0_N610_lut = 16'h4445;
assign M1[610] = layer0_N610_lut[layer0_N610_wire];

wire [3:0] layer0_N611_wire = {M0[512], M0[324], M0[524], M0[540]};
wire [15:0] layer0_N611_lut = 16'hFF2C;
assign M1[611] = layer0_N611_lut[layer0_N611_wire];

wire [3:0] layer0_N612_wire = {M0[520], M0[548], M0[507], M0[535]};
wire [15:0] layer0_N612_lut = 16'h0077;
assign M1[612] = layer0_N612_lut[layer0_N612_wire];

wire [3:0] layer0_N613_wire = {M0[568], M0[548], M0[596], M0[708]};
wire [15:0] layer0_N613_lut = 16'hFCD8;
assign M1[613] = layer0_N613_lut[layer0_N613_wire];

wire [3:0] layer0_N614_wire = {M0[92], M0[368], M0[64], M0[524]};
wire [15:0] layer0_N614_lut = 16'h0515;
assign M1[614] = layer0_N614_lut[layer0_N614_wire];

wire [3:0] layer0_N615_wire = {M0[600], M0[599], M0[132], M0[174]};
wire [15:0] layer0_N615_lut = 16'h1717;
assign M1[615] = layer0_N615_lut[layer0_N615_wire];

wire [3:0] layer0_N616_wire = {M0[228], M0[180], M0[181], M0[284]};
wire [15:0] layer0_N616_lut = 16'h7F07;
assign M1[616] = layer0_N616_lut[layer0_N616_wire];

wire [3:0] layer0_N617_wire = {M0[648], M0[676], M0[137], M0[675]};
wire [15:0] layer0_N617_lut = 16'h1505;
assign M1[617] = layer0_N617_lut[layer0_N617_wire];

wire [3:0] layer0_N618_wire = {M0[410], M0[506], M0[237], M0[265]};
wire [15:0] layer0_N618_lut = 16'h1111;
assign M1[618] = layer0_N618_lut[layer0_N618_wire];

wire [3:0] layer0_N619_wire = {M0[228], M0[399], M0[144], M0[226]};
wire [15:0] layer0_N619_lut = 16'h4673;
assign M1[619] = layer0_N619_lut[layer0_N619_wire];

wire [3:0] layer0_N620_wire = {M0[579], M0[375], M0[685], M0[565]};
wire [15:0] layer0_N620_lut = 16'hCCEC;
assign M1[620] = layer0_N620_lut[layer0_N620_wire];

wire [3:0] layer0_N621_wire = {M0[626], M0[514], M0[487], M0[627]};
wire [15:0] layer0_N621_lut = 16'h4DFF;
assign M1[621] = layer0_N621_lut[layer0_N621_wire];

wire [3:0] layer0_N622_wire = {M0[626], M0[625], M0[654], M0[595]};
wire [15:0] layer0_N622_lut = 16'h10B3;
assign M1[622] = layer0_N622_lut[layer0_N622_wire];

wire [3:0] layer0_N623_wire = {M0[653], M0[578], M0[652], M0[684]};
wire [15:0] layer0_N623_lut = 16'h5554;
assign M1[623] = layer0_N623_lut[layer0_N623_wire];

wire [3:0] layer0_N624_wire = {M0[604], M0[551], M0[413], M0[383]};
wire [15:0] layer0_N624_lut = 16'h88AD;
assign M1[624] = layer0_N624_lut[layer0_N624_wire];

wire [3:0] layer0_N625_wire = {M0[685], M0[658], M0[656], M0[506]};
wire [15:0] layer0_N625_lut = 16'hFFCC;
assign M1[625] = layer0_N625_lut[layer0_N625_wire];

wire [3:0] layer0_N626_wire = {M0[714], M0[713], M0[712], M0[685]};
wire [15:0] layer0_N626_lut = 16'h3F37;
assign M1[626] = layer0_N626_lut[layer0_N626_wire];

wire [3:0] layer0_N627_wire = {M0[491], M0[296], M0[658], M0[490]};
wire [15:0] layer0_N627_lut = 16'h2264;
assign M1[627] = layer0_N627_lut[layer0_N627_wire];

wire [3:0] layer0_N628_wire = {M0[241], M0[270], M0[565], M0[243]};
wire [15:0] layer0_N628_lut = 16'hAA40;
assign M1[628] = layer0_N628_lut[layer0_N628_wire];

wire [3:0] layer0_N629_wire = {M0[353], M0[492], M0[292], M0[403]};
wire [15:0] layer0_N629_lut = 16'h0033;
assign M1[629] = layer0_N629_lut[layer0_N629_wire];

wire [3:0] layer0_N630_wire = {M0[350], M0[344], M0[345], M0[159]};
wire [15:0] layer0_N630_lut = 16'h20BB;
assign M1[630] = layer0_N630_lut[layer0_N630_wire];

wire [3:0] layer0_N631_wire = {M0[350], M0[345], M0[349], M0[292]};
wire [15:0] layer0_N631_lut = 16'hFFAA;
assign M1[631] = layer0_N631_lut[layer0_N631_wire];

wire [3:0] layer0_N632_wire = {M0[566], M0[567], M0[565], M0[470]};
wire [15:0] layer0_N632_lut = 16'hFBB2;
assign M1[632] = layer0_N632_lut[layer0_N632_wire];

wire [3:0] layer0_N633_wire = {M0[49], M0[360], M0[599], M0[577]};
wire [15:0] layer0_N633_lut = 16'hFF70;
assign M1[633] = layer0_N633_lut[layer0_N633_wire];

wire [3:0] layer0_N634_wire = {M0[469], M0[440], M0[426], M0[413]};
wire [15:0] layer0_N634_lut = 16'h0335;
assign M1[634] = layer0_N634_lut[layer0_N634_wire];

wire [3:0] layer0_N635_wire = {M0[512], M0[650], M0[398], M0[506]};
wire [15:0] layer0_N635_lut = 16'hA5BF;
assign M1[635] = layer0_N635_lut[layer0_N635_wire];

wire [3:0] layer0_N636_wire = {M0[541], M0[563], M0[534], M0[612]};
wire [15:0] layer0_N636_lut = 16'h1500;
assign M1[636] = layer0_N636_lut[layer0_N636_wire];

wire [3:0] layer0_N637_wire = {M0[267], M0[268], M0[262], M0[412]};
wire [15:0] layer0_N637_lut = 16'h3B3F;
assign M1[637] = layer0_N637_lut[layer0_N637_wire];

wire [3:0] layer0_N638_wire = {M0[487], M0[595], M0[491], M0[493]};
wire [15:0] layer0_N638_lut = 16'h0800;
assign M1[638] = layer0_N638_lut[layer0_N638_wire];

wire [3:0] layer0_N639_wire = {M0[547], M0[612], M0[573], M0[66]};
wire [15:0] layer0_N639_lut = 16'h5075;
assign M1[639] = layer0_N639_lut[layer0_N639_wire];

endmodule
module layer1 (input [639:0] M0, output [159:0] M1);

wire [3:0] layer1_N0_wire = {M0[0], M0[1], M0[2], M0[3]};
wire [15:0] layer1_N0_lut = 16'hB0AA;
assign M1[0] = layer1_N0_lut[layer1_N0_wire];

wire [3:0] layer1_N1_wire = {M0[4], M0[5], M0[6], M0[7]};
wire [15:0] layer1_N1_lut = 16'h8E0E;
assign M1[1] = layer1_N1_lut[layer1_N1_wire];

wire [3:0] layer1_N2_wire = {M0[8], M0[9], M0[10], M0[11]};
wire [15:0] layer1_N2_lut = 16'h7F40;
assign M1[2] = layer1_N2_lut[layer1_N2_wire];

wire [3:0] layer1_N3_wire = {M0[12], M0[13], M0[14], M0[15]};
wire [15:0] layer1_N3_lut = 16'hFEFC;
assign M1[3] = layer1_N3_lut[layer1_N3_wire];

wire [3:0] layer1_N4_wire = {M0[16], M0[17], M0[18], M0[19]};
wire [15:0] layer1_N4_lut = 16'h3033;
assign M1[4] = layer1_N4_lut[layer1_N4_wire];

wire [3:0] layer1_N5_wire = {M0[20], M0[21], M0[22], M0[23]};
wire [15:0] layer1_N5_lut = 16'h4DCF;
assign M1[5] = layer1_N5_lut[layer1_N5_wire];

wire [3:0] layer1_N6_wire = {M0[24], M0[25], M0[26], M0[27]};
wire [15:0] layer1_N6_lut = 16'hEC80;
assign M1[6] = layer1_N6_lut[layer1_N6_wire];

wire [3:0] layer1_N7_wire = {M0[28], M0[29], M0[30], M0[31]};
wire [15:0] layer1_N7_lut = 16'h054F;
assign M1[7] = layer1_N7_lut[layer1_N7_wire];

wire [3:0] layer1_N8_wire = {M0[32], M0[33], M0[34], M0[35]};
wire [15:0] layer1_N8_lut = 16'hC8FC;
assign M1[8] = layer1_N8_lut[layer1_N8_wire];

wire [3:0] layer1_N9_wire = {M0[36], M0[37], M0[38], M0[39]};
wire [15:0] layer1_N9_lut = 16'h4D5F;
assign M1[9] = layer1_N9_lut[layer1_N9_wire];

wire [3:0] layer1_N10_wire = {M0[40], M0[41], M0[42], M0[43]};
wire [15:0] layer1_N10_lut = 16'h71F1;
assign M1[10] = layer1_N10_lut[layer1_N10_wire];

wire [3:0] layer1_N11_wire = {M0[44], M0[45], M0[46], M0[47]};
wire [15:0] layer1_N11_lut = 16'hFEFC;
assign M1[11] = layer1_N11_lut[layer1_N11_wire];

wire [3:0] layer1_N12_wire = {M0[48], M0[49], M0[50], M0[51]};
wire [15:0] layer1_N12_lut = 16'hFCE8;
assign M1[12] = layer1_N12_lut[layer1_N12_wire];

wire [3:0] layer1_N13_wire = {M0[52], M0[53], M0[54], M0[55]};
wire [15:0] layer1_N13_lut = 16'hCC8E;
assign M1[13] = layer1_N13_lut[layer1_N13_wire];

wire [3:0] layer1_N14_wire = {M0[56], M0[57], M0[58], M0[59]};
wire [15:0] layer1_N14_lut = 16'h0BAB;
assign M1[14] = layer1_N14_lut[layer1_N14_wire];

wire [3:0] layer1_N15_wire = {M0[60], M0[61], M0[62], M0[63]};
wire [15:0] layer1_N15_lut = 16'hB030;
assign M1[15] = layer1_N15_lut[layer1_N15_wire];

wire [3:0] layer1_N16_wire = {M0[64], M0[65], M0[66], M0[67]};
wire [15:0] layer1_N16_lut = 16'hFCC0;
assign M1[16] = layer1_N16_lut[layer1_N16_wire];

wire [3:0] layer1_N17_wire = {M0[68], M0[69], M0[70], M0[71]};
wire [15:0] layer1_N17_lut = 16'hFB32;
assign M1[17] = layer1_N17_lut[layer1_N17_wire];

wire [3:0] layer1_N18_wire = {M0[72], M0[73], M0[74], M0[75]};
wire [15:0] layer1_N18_lut = 16'hFD50;
assign M1[18] = layer1_N18_lut[layer1_N18_wire];

wire [3:0] layer1_N19_wire = {M0[76], M0[77], M0[78], M0[79]};
wire [15:0] layer1_N19_lut = 16'h0077;
assign M1[19] = layer1_N19_lut[layer1_N19_wire];

wire [3:0] layer1_N20_wire = {M0[80], M0[81], M0[82], M0[83]};
wire [15:0] layer1_N20_lut = 16'hC5CD;
assign M1[20] = layer1_N20_lut[layer1_N20_wire];

wire [3:0] layer1_N21_wire = {M0[84], M0[85], M0[86], M0[87]};
wire [15:0] layer1_N21_lut = 16'h1FDF;
assign M1[21] = layer1_N21_lut[layer1_N21_wire];

wire [3:0] layer1_N22_wire = {M0[88], M0[89], M0[90], M0[91]};
wire [15:0] layer1_N22_lut = 16'h7F11;
assign M1[22] = layer1_N22_lut[layer1_N22_wire];

wire [3:0] layer1_N23_wire = {M0[92], M0[93], M0[94], M0[95]};
wire [15:0] layer1_N23_lut = 16'hFB0F;
assign M1[23] = layer1_N23_lut[layer1_N23_wire];

wire [3:0] layer1_N24_wire = {M0[96], M0[97], M0[98], M0[99]};
wire [15:0] layer1_N24_lut = 16'hC0FA;
assign M1[24] = layer1_N24_lut[layer1_N24_wire];

wire [3:0] layer1_N25_wire = {M0[100], M0[101], M0[102], M0[103]};
wire [15:0] layer1_N25_lut = 16'h0022;
assign M1[25] = layer1_N25_lut[layer1_N25_wire];

wire [3:0] layer1_N26_wire = {M0[104], M0[105], M0[106], M0[107]};
wire [15:0] layer1_N26_lut = 16'h23BB;
assign M1[26] = layer1_N26_lut[layer1_N26_wire];

wire [3:0] layer1_N27_wire = {M0[108], M0[109], M0[110], M0[111]};
wire [15:0] layer1_N27_lut = 16'h022B;
assign M1[27] = layer1_N27_lut[layer1_N27_wire];

wire [3:0] layer1_N28_wire = {M0[112], M0[113], M0[114], M0[115]};
wire [15:0] layer1_N28_lut = 16'h23BF;
assign M1[28] = layer1_N28_lut[layer1_N28_wire];

wire [3:0] layer1_N29_wire = {M0[116], M0[117], M0[118], M0[119]};
wire [15:0] layer1_N29_lut = 16'hBF8C;
assign M1[29] = layer1_N29_lut[layer1_N29_wire];

wire [3:0] layer1_N30_wire = {M0[120], M0[121], M0[122], M0[123]};
wire [15:0] layer1_N30_lut = 16'h0017;
assign M1[30] = layer1_N30_lut[layer1_N30_wire];

wire [3:0] layer1_N31_wire = {M0[124], M0[125], M0[126], M0[127]};
wire [15:0] layer1_N31_lut = 16'h23B3;
assign M1[31] = layer1_N31_lut[layer1_N31_wire];

wire [3:0] layer1_N32_wire = {M0[128], M0[129], M0[130], M0[131]};
wire [15:0] layer1_N32_lut = 16'h4F4C;
assign M1[32] = layer1_N32_lut[layer1_N32_wire];

wire [3:0] layer1_N33_wire = {M0[132], M0[133], M0[134], M0[135]};
wire [15:0] layer1_N33_lut = 16'h8203;
assign M1[33] = layer1_N33_lut[layer1_N33_wire];

wire [3:0] layer1_N34_wire = {M0[136], M0[137], M0[138], M0[139]};
wire [15:0] layer1_N34_lut = 16'h7570;
assign M1[34] = layer1_N34_lut[layer1_N34_wire];

wire [3:0] layer1_N35_wire = {M0[140], M0[141], M0[142], M0[143]};
wire [15:0] layer1_N35_lut = 16'hA0E0;
assign M1[35] = layer1_N35_lut[layer1_N35_wire];

wire [3:0] layer1_N36_wire = {M0[144], M0[145], M0[146], M0[147]};
wire [15:0] layer1_N36_lut = 16'hFEFC;
assign M1[36] = layer1_N36_lut[layer1_N36_wire];

wire [3:0] layer1_N37_wire = {M0[148], M0[149], M0[150], M0[151]};
wire [15:0] layer1_N37_lut = 16'h80FA;
assign M1[37] = layer1_N37_lut[layer1_N37_wire];

wire [3:0] layer1_N38_wire = {M0[152], M0[153], M0[154], M0[155]};
wire [15:0] layer1_N38_lut = 16'hF410;
assign M1[38] = layer1_N38_lut[layer1_N38_wire];

wire [3:0] layer1_N39_wire = {M0[156], M0[157], M0[158], M0[159]};
wire [15:0] layer1_N39_lut = 16'hAA8E;
assign M1[39] = layer1_N39_lut[layer1_N39_wire];

wire [3:0] layer1_N40_wire = {M0[160], M0[161], M0[162], M0[163]};
wire [15:0] layer1_N40_lut = 16'h177F;
assign M1[40] = layer1_N40_lut[layer1_N40_wire];

wire [3:0] layer1_N41_wire = {M0[164], M0[165], M0[166], M0[167]};
wire [15:0] layer1_N41_lut = 16'hF3B2;
assign M1[41] = layer1_N41_lut[layer1_N41_wire];

wire [3:0] layer1_N42_wire = {M0[168], M0[169], M0[170], M0[171]};
wire [15:0] layer1_N42_lut = 16'h017F;
assign M1[42] = layer1_N42_lut[layer1_N42_wire];

wire [3:0] layer1_N43_wire = {M0[172], M0[173], M0[174], M0[175]};
wire [15:0] layer1_N43_lut = 16'hE0EA;
assign M1[43] = layer1_N43_lut[layer1_N43_wire];

wire [3:0] layer1_N44_wire = {M0[176], M0[177], M0[178], M0[179]};
wire [15:0] layer1_N44_lut = 16'h5F1D;
assign M1[44] = layer1_N44_lut[layer1_N44_wire];

wire [3:0] layer1_N45_wire = {M0[180], M0[181], M0[182], M0[183]};
wire [15:0] layer1_N45_lut = 16'hBA20;
assign M1[45] = layer1_N45_lut[layer1_N45_wire];

wire [3:0] layer1_N46_wire = {M0[184], M0[185], M0[186], M0[187]};
wire [15:0] layer1_N46_lut = 16'h40C5;
assign M1[46] = layer1_N46_lut[layer1_N46_wire];

wire [3:0] layer1_N47_wire = {M0[188], M0[189], M0[190], M0[191]};
wire [15:0] layer1_N47_lut = 16'h0CDF;
assign M1[47] = layer1_N47_lut[layer1_N47_wire];

wire [3:0] layer1_N48_wire = {M0[192], M0[193], M0[194], M0[195]};
wire [15:0] layer1_N48_lut = 16'h0505;
assign M1[48] = layer1_N48_lut[layer1_N48_wire];

wire [3:0] layer1_N49_wire = {M0[196], M0[197], M0[198], M0[199]};
wire [15:0] layer1_N49_lut = 16'h0988;
assign M1[49] = layer1_N49_lut[layer1_N49_wire];

wire [3:0] layer1_N50_wire = {M0[200], M0[201], M0[202], M0[203]};
wire [15:0] layer1_N50_lut = 16'hCCFD;
assign M1[50] = layer1_N50_lut[layer1_N50_wire];

wire [3:0] layer1_N51_wire = {M0[204], M0[205], M0[206], M0[207]};
wire [15:0] layer1_N51_lut = 16'h70F1;
assign M1[51] = layer1_N51_lut[layer1_N51_wire];

wire [3:0] layer1_N52_wire = {M0[208], M0[209], M0[210], M0[211]};
wire [15:0] layer1_N52_lut = 16'h0008;
assign M1[52] = layer1_N52_lut[layer1_N52_wire];

wire [3:0] layer1_N53_wire = {M0[212], M0[213], M0[214], M0[215]};
wire [15:0] layer1_N53_lut = 16'hE880;
assign M1[53] = layer1_N53_lut[layer1_N53_wire];

wire [3:0] layer1_N54_wire = {M0[216], M0[217], M0[218], M0[219]};
wire [15:0] layer1_N54_lut = 16'hDF0D;
assign M1[54] = layer1_N54_lut[layer1_N54_wire];

wire [3:0] layer1_N55_wire = {M0[220], M0[221], M0[222], M0[223]};
wire [15:0] layer1_N55_lut = 16'h10F3;
assign M1[55] = layer1_N55_lut[layer1_N55_wire];

wire [3:0] layer1_N56_wire = {M0[224], M0[225], M0[226], M0[227]};
wire [15:0] layer1_N56_lut = 16'h7032;
assign M1[56] = layer1_N56_lut[layer1_N56_wire];

wire [3:0] layer1_N57_wire = {M0[228], M0[229], M0[230], M0[231]};
wire [15:0] layer1_N57_lut = 16'h5455;
assign M1[57] = layer1_N57_lut[layer1_N57_wire];

wire [3:0] layer1_N58_wire = {M0[232], M0[233], M0[234], M0[235]};
wire [15:0] layer1_N58_lut = 16'h011F;
assign M1[58] = layer1_N58_lut[layer1_N58_wire];

wire [3:0] layer1_N59_wire = {M0[236], M0[237], M0[238], M0[239]};
wire [15:0] layer1_N59_lut = 16'h222B;
assign M1[59] = layer1_N59_lut[layer1_N59_wire];

wire [3:0] layer1_N60_wire = {M0[240], M0[241], M0[242], M0[243]};
wire [15:0] layer1_N60_lut = 16'hC8FE;
assign M1[60] = layer1_N60_lut[layer1_N60_wire];

wire [3:0] layer1_N61_wire = {M0[244], M0[245], M0[246], M0[247]};
wire [15:0] layer1_N61_lut = 16'hFFBF;
assign M1[61] = layer1_N61_lut[layer1_N61_wire];

wire [3:0] layer1_N62_wire = {M0[248], M0[249], M0[250], M0[251]};
wire [15:0] layer1_N62_lut = 16'h4E4C;
assign M1[62] = layer1_N62_lut[layer1_N62_wire];

wire [3:0] layer1_N63_wire = {M0[252], M0[253], M0[254], M0[255]};
wire [15:0] layer1_N63_lut = 16'h4DDF;
assign M1[63] = layer1_N63_lut[layer1_N63_wire];

wire [3:0] layer1_N64_wire = {M0[256], M0[257], M0[258], M0[259]};
wire [15:0] layer1_N64_lut = 16'h80E0;
assign M1[64] = layer1_N64_lut[layer1_N64_wire];

wire [3:0] layer1_N65_wire = {M0[260], M0[261], M0[262], M0[263]};
wire [15:0] layer1_N65_lut = 16'hFAE8;
assign M1[65] = layer1_N65_lut[layer1_N65_wire];

wire [3:0] layer1_N66_wire = {M0[264], M0[265], M0[266], M0[267]};
wire [15:0] layer1_N66_lut = 16'hF2A0;
assign M1[66] = layer1_N66_lut[layer1_N66_wire];

wire [3:0] layer1_N67_wire = {M0[268], M0[269], M0[270], M0[271]};
wire [15:0] layer1_N67_lut = 16'h50DD;
assign M1[67] = layer1_N67_lut[layer1_N67_wire];

wire [3:0] layer1_N68_wire = {M0[272], M0[273], M0[274], M0[275]};
wire [15:0] layer1_N68_lut = 16'hBBB2;
assign M1[68] = layer1_N68_lut[layer1_N68_wire];

wire [3:0] layer1_N69_wire = {M0[276], M0[277], M0[278], M0[279]};
wire [15:0] layer1_N69_lut = 16'hC400;
assign M1[69] = layer1_N69_lut[layer1_N69_wire];

wire [3:0] layer1_N70_wire = {M0[280], M0[281], M0[282], M0[283]};
wire [15:0] layer1_N70_lut = 16'hBF01;
assign M1[70] = layer1_N70_lut[layer1_N70_wire];

wire [3:0] layer1_N71_wire = {M0[284], M0[285], M0[286], M0[287]};
wire [15:0] layer1_N71_lut = 16'h1317;
assign M1[71] = layer1_N71_lut[layer1_N71_wire];

wire [3:0] layer1_N72_wire = {M0[288], M0[289], M0[290], M0[291]};
wire [15:0] layer1_N72_lut = 16'h000C;
assign M1[72] = layer1_N72_lut[layer1_N72_wire];

wire [3:0] layer1_N73_wire = {M0[292], M0[293], M0[294], M0[295]};
wire [15:0] layer1_N73_lut = 16'hCCDC;
assign M1[73] = layer1_N73_lut[layer1_N73_wire];

wire [3:0] layer1_N74_wire = {M0[296], M0[297], M0[298], M0[299]};
wire [15:0] layer1_N74_lut = 16'h73F1;
assign M1[74] = layer1_N74_lut[layer1_N74_wire];

wire [3:0] layer1_N75_wire = {M0[300], M0[301], M0[302], M0[303]};
wire [15:0] layer1_N75_lut = 16'h0017;
assign M1[75] = layer1_N75_lut[layer1_N75_wire];

wire [3:0] layer1_N76_wire = {M0[304], M0[305], M0[306], M0[307]};
wire [15:0] layer1_N76_lut = 16'hEAC8;
assign M1[76] = layer1_N76_lut[layer1_N76_wire];

wire [3:0] layer1_N77_wire = {M0[308], M0[309], M0[310], M0[311]};
wire [15:0] layer1_N77_lut = 16'hD410;
assign M1[77] = layer1_N77_lut[layer1_N77_wire];

wire [3:0] layer1_N78_wire = {M0[312], M0[313], M0[314], M0[315]};
wire [15:0] layer1_N78_lut = 16'hD5FD;
assign M1[78] = layer1_N78_lut[layer1_N78_wire];

wire [3:0] layer1_N79_wire = {M0[316], M0[317], M0[318], M0[319]};
wire [15:0] layer1_N79_lut = 16'h050F;
assign M1[79] = layer1_N79_lut[layer1_N79_wire];

wire [3:0] layer1_N80_wire = {M0[320], M0[321], M0[322], M0[323]};
wire [15:0] layer1_N80_lut = 16'h0A0F;
assign M1[80] = layer1_N80_lut[layer1_N80_wire];

wire [3:0] layer1_N81_wire = {M0[324], M0[325], M0[326], M0[327]};
wire [15:0] layer1_N81_lut = 16'h3F2B;
assign M1[81] = layer1_N81_lut[layer1_N81_wire];

wire [3:0] layer1_N82_wire = {M0[328], M0[329], M0[330], M0[331]};
wire [15:0] layer1_N82_lut = 16'h2230;
assign M1[82] = layer1_N82_lut[layer1_N82_wire];

wire [3:0] layer1_N83_wire = {M0[332], M0[333], M0[334], M0[335]};
wire [15:0] layer1_N83_lut = 16'h4FDF;
assign M1[83] = layer1_N83_lut[layer1_N83_wire];

wire [3:0] layer1_N84_wire = {M0[336], M0[337], M0[338], M0[339]};
wire [15:0] layer1_N84_lut = 16'h3317;
assign M1[84] = layer1_N84_lut[layer1_N84_wire];

wire [3:0] layer1_N85_wire = {M0[340], M0[341], M0[342], M0[343]};
wire [15:0] layer1_N85_lut = 16'h4CFF;
assign M1[85] = layer1_N85_lut[layer1_N85_wire];

wire [3:0] layer1_N86_wire = {M0[344], M0[345], M0[346], M0[347]};
wire [15:0] layer1_N86_lut = 16'h1117;
assign M1[86] = layer1_N86_lut[layer1_N86_wire];

wire [3:0] layer1_N87_wire = {M0[348], M0[349], M0[350], M0[351]};
wire [15:0] layer1_N87_lut = 16'h7107;
assign M1[87] = layer1_N87_lut[layer1_N87_wire];

wire [3:0] layer1_N88_wire = {M0[352], M0[353], M0[354], M0[355]};
wire [15:0] layer1_N88_lut = 16'h0377;
assign M1[88] = layer1_N88_lut[layer1_N88_wire];

wire [3:0] layer1_N89_wire = {M0[356], M0[357], M0[358], M0[359]};
wire [15:0] layer1_N89_lut = 16'hEEEA;
assign M1[89] = layer1_N89_lut[layer1_N89_wire];

wire [3:0] layer1_N90_wire = {M0[360], M0[361], M0[362], M0[363]};
wire [15:0] layer1_N90_lut = 16'h0A2F;
assign M1[90] = layer1_N90_lut[layer1_N90_wire];

wire [3:0] layer1_N91_wire = {M0[364], M0[365], M0[366], M0[367]};
wire [15:0] layer1_N91_lut = 16'hA8BF;
assign M1[91] = layer1_N91_lut[layer1_N91_wire];

wire [3:0] layer1_N92_wire = {M0[368], M0[369], M0[370], M0[371]};
wire [15:0] layer1_N92_lut = 16'h7F57;
assign M1[92] = layer1_N92_lut[layer1_N92_wire];

wire [3:0] layer1_N93_wire = {M0[372], M0[373], M0[374], M0[375]};
wire [15:0] layer1_N93_lut = 16'hF372;
assign M1[93] = layer1_N93_lut[layer1_N93_wire];

wire [3:0] layer1_N94_wire = {M0[376], M0[377], M0[378], M0[379]};
wire [15:0] layer1_N94_lut = 16'hB313;
assign M1[94] = layer1_N94_lut[layer1_N94_wire];

wire [3:0] layer1_N95_wire = {M0[380], M0[381], M0[382], M0[383]};
wire [15:0] layer1_N95_lut = 16'hE8E0;
assign M1[95] = layer1_N95_lut[layer1_N95_wire];

wire [3:0] layer1_N96_wire = {M0[384], M0[385], M0[386], M0[387]};
wire [15:0] layer1_N96_lut = 16'hAAFA;
assign M1[96] = layer1_N96_lut[layer1_N96_wire];

wire [3:0] layer1_N97_wire = {M0[388], M0[389], M0[390], M0[391]};
wire [15:0] layer1_N97_lut = 16'h5100;
assign M1[97] = layer1_N97_lut[layer1_N97_wire];

wire [3:0] layer1_N98_wire = {M0[392], M0[393], M0[394], M0[395]};
wire [15:0] layer1_N98_lut = 16'hD040;
assign M1[98] = layer1_N98_lut[layer1_N98_wire];

wire [3:0] layer1_N99_wire = {M0[396], M0[397], M0[398], M0[399]};
wire [15:0] layer1_N99_lut = 16'h1037;
assign M1[99] = layer1_N99_lut[layer1_N99_wire];

wire [3:0] layer1_N100_wire = {M0[400], M0[401], M0[402], M0[403]};
wire [15:0] layer1_N100_lut = 16'hECFE;
assign M1[100] = layer1_N100_lut[layer1_N100_wire];

wire [3:0] layer1_N101_wire = {M0[404], M0[405], M0[406], M0[407]};
wire [15:0] layer1_N101_lut = 16'h073F;
assign M1[101] = layer1_N101_lut[layer1_N101_wire];

wire [3:0] layer1_N102_wire = {M0[408], M0[409], M0[410], M0[411]};
wire [15:0] layer1_N102_lut = 16'hB2B3;
assign M1[102] = layer1_N102_lut[layer1_N102_wire];

wire [3:0] layer1_N103_wire = {M0[412], M0[413], M0[414], M0[415]};
wire [15:0] layer1_N103_lut = 16'hCFBF;
assign M1[103] = layer1_N103_lut[layer1_N103_wire];

wire [3:0] layer1_N104_wire = {M0[416], M0[417], M0[418], M0[419]};
wire [15:0] layer1_N104_lut = 16'h0CEF;
assign M1[104] = layer1_N104_lut[layer1_N104_wire];

wire [3:0] layer1_N105_wire = {M0[420], M0[421], M0[422], M0[423]};
wire [15:0] layer1_N105_lut = 16'h054F;
assign M1[105] = layer1_N105_lut[layer1_N105_wire];

wire [3:0] layer1_N106_wire = {M0[424], M0[425], M0[426], M0[427]};
wire [15:0] layer1_N106_lut = 16'h5F13;
assign M1[106] = layer1_N106_lut[layer1_N106_wire];

wire [3:0] layer1_N107_wire = {M0[428], M0[429], M0[430], M0[431]};
wire [15:0] layer1_N107_lut = 16'h2B2B;
assign M1[107] = layer1_N107_lut[layer1_N107_wire];

wire [3:0] layer1_N108_wire = {M0[432], M0[433], M0[434], M0[435]};
wire [15:0] layer1_N108_lut = 16'h0A2F;
assign M1[108] = layer1_N108_lut[layer1_N108_wire];

wire [3:0] layer1_N109_wire = {M0[436], M0[437], M0[438], M0[439]};
wire [15:0] layer1_N109_lut = 16'hA800;
assign M1[109] = layer1_N109_lut[layer1_N109_wire];

wire [3:0] layer1_N110_wire = {M0[440], M0[441], M0[442], M0[443]};
wire [15:0] layer1_N110_lut = 16'h455F;
assign M1[110] = layer1_N110_lut[layer1_N110_wire];

wire [3:0] layer1_N111_wire = {M0[444], M0[445], M0[446], M0[447]};
wire [15:0] layer1_N111_lut = 16'hF111;
assign M1[111] = layer1_N111_lut[layer1_N111_wire];

wire [3:0] layer1_N112_wire = {M0[448], M0[449], M0[450], M0[451]};
wire [15:0] layer1_N112_lut = 16'h0F8C;
assign M1[112] = layer1_N112_lut[layer1_N112_wire];

wire [3:0] layer1_N113_wire = {M0[452], M0[453], M0[454], M0[455]};
wire [15:0] layer1_N113_lut = 16'hB2FB;
assign M1[113] = layer1_N113_lut[layer1_N113_wire];

wire [3:0] layer1_N114_wire = {M0[456], M0[457], M0[458], M0[459]};
wire [15:0] layer1_N114_lut = 16'h5504;
assign M1[114] = layer1_N114_lut[layer1_N114_wire];

wire [3:0] layer1_N115_wire = {M0[460], M0[461], M0[462], M0[463]};
wire [15:0] layer1_N115_lut = 16'h4CCC;
assign M1[115] = layer1_N115_lut[layer1_N115_wire];

wire [3:0] layer1_N116_wire = {M0[464], M0[465], M0[466], M0[467]};
wire [15:0] layer1_N116_lut = 16'hAFEF;
assign M1[116] = layer1_N116_lut[layer1_N116_wire];

wire [3:0] layer1_N117_wire = {M0[468], M0[469], M0[470], M0[471]};
wire [15:0] layer1_N117_lut = 16'h2300;
assign M1[117] = layer1_N117_lut[layer1_N117_wire];

wire [3:0] layer1_N118_wire = {M0[472], M0[473], M0[474], M0[475]};
wire [15:0] layer1_N118_lut = 16'hB3A0;
assign M1[118] = layer1_N118_lut[layer1_N118_wire];

wire [3:0] layer1_N119_wire = {M0[476], M0[477], M0[478], M0[479]};
wire [15:0] layer1_N119_lut = 16'h047F;
assign M1[119] = layer1_N119_lut[layer1_N119_wire];

wire [3:0] layer1_N120_wire = {M0[480], M0[481], M0[482], M0[483]};
wire [15:0] layer1_N120_lut = 16'h1757;
assign M1[120] = layer1_N120_lut[layer1_N120_wire];

wire [3:0] layer1_N121_wire = {M0[484], M0[485], M0[486], M0[487]};
wire [15:0] layer1_N121_lut = 16'hCCE0;
assign M1[121] = layer1_N121_lut[layer1_N121_wire];

wire [3:0] layer1_N122_wire = {M0[488], M0[489], M0[490], M0[491]};
wire [15:0] layer1_N122_lut = 16'hEB00;
assign M1[122] = layer1_N122_lut[layer1_N122_wire];

wire [3:0] layer1_N123_wire = {M0[492], M0[493], M0[494], M0[495]};
wire [15:0] layer1_N123_lut = 16'hAEEF;
assign M1[123] = layer1_N123_lut[layer1_N123_wire];

wire [3:0] layer1_N124_wire = {M0[496], M0[497], M0[498], M0[499]};
wire [15:0] layer1_N124_lut = 16'h7F77;
assign M1[124] = layer1_N124_lut[layer1_N124_wire];

wire [3:0] layer1_N125_wire = {M0[500], M0[501], M0[502], M0[503]};
wire [15:0] layer1_N125_lut = 16'hFBF0;
assign M1[125] = layer1_N125_lut[layer1_N125_wire];

wire [3:0] layer1_N126_wire = {M0[504], M0[505], M0[506], M0[507]};
wire [15:0] layer1_N126_lut = 16'hF330;
assign M1[126] = layer1_N126_lut[layer1_N126_wire];

wire [3:0] layer1_N127_wire = {M0[508], M0[509], M0[510], M0[511]};
wire [15:0] layer1_N127_lut = 16'h3B02;
assign M1[127] = layer1_N127_lut[layer1_N127_wire];

wire [3:0] layer1_N128_wire = {M0[512], M0[513], M0[514], M0[515]};
wire [15:0] layer1_N128_lut = 16'hFAF0;
assign M1[128] = layer1_N128_lut[layer1_N128_wire];

wire [3:0] layer1_N129_wire = {M0[516], M0[517], M0[518], M0[519]};
wire [15:0] layer1_N129_lut = 16'h7000;
assign M1[129] = layer1_N129_lut[layer1_N129_wire];

wire [3:0] layer1_N130_wire = {M0[520], M0[521], M0[522], M0[523]};
wire [15:0] layer1_N130_lut = 16'hFFA0;
assign M1[130] = layer1_N130_lut[layer1_N130_wire];

wire [3:0] layer1_N131_wire = {M0[524], M0[525], M0[526], M0[527]};
wire [15:0] layer1_N131_lut = 16'h3F00;
assign M1[131] = layer1_N131_lut[layer1_N131_wire];

wire [3:0] layer1_N132_wire = {M0[528], M0[529], M0[530], M0[531]};
wire [15:0] layer1_N132_lut = 16'h7771;
assign M1[132] = layer1_N132_lut[layer1_N132_wire];

wire [3:0] layer1_N133_wire = {M0[532], M0[533], M0[534], M0[535]};
wire [15:0] layer1_N133_lut = 16'hDFCD;
assign M1[133] = layer1_N133_lut[layer1_N133_wire];

wire [3:0] layer1_N134_wire = {M0[536], M0[537], M0[538], M0[539]};
wire [15:0] layer1_N134_lut = 16'h2ABB;
assign M1[134] = layer1_N134_lut[layer1_N134_wire];

wire [3:0] layer1_N135_wire = {M0[540], M0[541], M0[542], M0[543]};
wire [15:0] layer1_N135_lut = 16'hD0FC;
assign M1[135] = layer1_N135_lut[layer1_N135_wire];

wire [3:0] layer1_N136_wire = {M0[544], M0[545], M0[546], M0[547]};
wire [15:0] layer1_N136_lut = 16'h4C4D;
assign M1[136] = layer1_N136_lut[layer1_N136_wire];

wire [3:0] layer1_N137_wire = {M0[548], M0[549], M0[550], M0[551]};
wire [15:0] layer1_N137_lut = 16'h31F1;
assign M1[137] = layer1_N137_lut[layer1_N137_wire];

wire [3:0] layer1_N138_wire = {M0[552], M0[553], M0[554], M0[555]};
wire [15:0] layer1_N138_lut = 16'h080A;
assign M1[138] = layer1_N138_lut[layer1_N138_wire];

wire [3:0] layer1_N139_wire = {M0[556], M0[557], M0[558], M0[559]};
wire [15:0] layer1_N139_lut = 16'hCECC;
assign M1[139] = layer1_N139_lut[layer1_N139_wire];

wire [3:0] layer1_N140_wire = {M0[560], M0[561], M0[562], M0[563]};
wire [15:0] layer1_N140_lut = 16'hD0D4;
assign M1[140] = layer1_N140_lut[layer1_N140_wire];

wire [3:0] layer1_N141_wire = {M0[564], M0[565], M0[566], M0[567]};
wire [15:0] layer1_N141_lut = 16'h888E;
assign M1[141] = layer1_N141_lut[layer1_N141_wire];

wire [3:0] layer1_N142_wire = {M0[568], M0[569], M0[570], M0[571]};
wire [15:0] layer1_N142_lut = 16'hC8EC;
assign M1[142] = layer1_N142_lut[layer1_N142_wire];

wire [3:0] layer1_N143_wire = {M0[572], M0[573], M0[574], M0[575]};
wire [15:0] layer1_N143_lut = 16'hC8CE;
assign M1[143] = layer1_N143_lut[layer1_N143_wire];

wire [3:0] layer1_N144_wire = {M0[576], M0[577], M0[578], M0[579]};
wire [15:0] layer1_N144_lut = 16'h0E0C;
assign M1[144] = layer1_N144_lut[layer1_N144_wire];

wire [3:0] layer1_N145_wire = {M0[580], M0[581], M0[582], M0[583]};
wire [15:0] layer1_N145_lut = 16'hB131;
assign M1[145] = layer1_N145_lut[layer1_N145_wire];

wire [3:0] layer1_N146_wire = {M0[584], M0[585], M0[586], M0[587]};
wire [15:0] layer1_N146_lut = 16'h26AF;
assign M1[146] = layer1_N146_lut[layer1_N146_wire];

wire [3:0] layer1_N147_wire = {M0[588], M0[589], M0[590], M0[591]};
wire [15:0] layer1_N147_lut = 16'h71FF;
assign M1[147] = layer1_N147_lut[layer1_N147_wire];

wire [3:0] layer1_N148_wire = {M0[592], M0[593], M0[594], M0[595]};
wire [15:0] layer1_N148_lut = 16'hE0E0;
assign M1[148] = layer1_N148_lut[layer1_N148_wire];

wire [3:0] layer1_N149_wire = {M0[596], M0[597], M0[598], M0[599]};
wire [15:0] layer1_N149_lut = 16'h1F00;
assign M1[149] = layer1_N149_lut[layer1_N149_wire];

wire [3:0] layer1_N150_wire = {M0[600], M0[601], M0[602], M0[603]};
wire [15:0] layer1_N150_lut = 16'h23FF;
assign M1[150] = layer1_N150_lut[layer1_N150_wire];

wire [3:0] layer1_N151_wire = {M0[604], M0[605], M0[606], M0[607]};
wire [15:0] layer1_N151_lut = 16'hAEEF;
assign M1[151] = layer1_N151_lut[layer1_N151_wire];

wire [3:0] layer1_N152_wire = {M0[608], M0[609], M0[610], M0[611]};
wire [15:0] layer1_N152_lut = 16'h0D4D;
assign M1[152] = layer1_N152_lut[layer1_N152_wire];

wire [3:0] layer1_N153_wire = {M0[612], M0[613], M0[614], M0[615]};
wire [15:0] layer1_N153_lut = 16'h7173;
assign M1[153] = layer1_N153_lut[layer1_N153_wire];

wire [3:0] layer1_N154_wire = {M0[616], M0[617], M0[618], M0[619]};
wire [15:0] layer1_N154_lut = 16'hC000;
assign M1[154] = layer1_N154_lut[layer1_N154_wire];

wire [3:0] layer1_N155_wire = {M0[620], M0[621], M0[622], M0[623]};
wire [15:0] layer1_N155_lut = 16'h5F05;
assign M1[155] = layer1_N155_lut[layer1_N155_wire];

wire [3:0] layer1_N156_wire = {M0[624], M0[625], M0[626], M0[627]};
wire [15:0] layer1_N156_lut = 16'h33B3;
assign M1[156] = layer1_N156_lut[layer1_N156_wire];

wire [3:0] layer1_N157_wire = {M0[628], M0[629], M0[630], M0[631]};
wire [15:0] layer1_N157_lut = 16'h0044;
assign M1[157] = layer1_N157_lut[layer1_N157_wire];

wire [3:0] layer1_N158_wire = {M0[632], M0[633], M0[634], M0[635]};
wire [15:0] layer1_N158_lut = 16'h7531;
assign M1[158] = layer1_N158_lut[layer1_N158_wire];

wire [3:0] layer1_N159_wire = {M0[636], M0[637], M0[638], M0[639]};
wire [15:0] layer1_N159_lut = 16'hDFDD;
assign M1[159] = layer1_N159_lut[layer1_N159_wire];

endmodule
module layer2 (input [159:0] M0, output [639:0] M1);

wire [3:0] layer2_N0_wire = {M0[25], M0[0], M0[132], M0[110]};
wire [15:0] layer2_N0_lut = 16'h70F5;
assign M1[0] = layer2_N0_lut[layer2_N0_wire];

wire [3:0] layer2_N1_wire = {M0[36], M0[42], M0[87], M0[106]};
wire [15:0] layer2_N1_lut = 16'h0050;
assign M1[1] = layer2_N1_lut[layer2_N1_wire];

wire [3:0] layer2_N2_wire = {M0[81], M0[67], M0[87], M0[36]};
wire [15:0] layer2_N2_lut = 16'h3ABF;
assign M1[2] = layer2_N2_lut[layer2_N2_wire];

wire [3:0] layer2_N3_wire = {M0[42], M0[56], M0[11], M0[142]};
wire [15:0] layer2_N3_lut = 16'h5040;
assign M1[3] = layer2_N3_lut[layer2_N3_wire];

wire [3:0] layer2_N4_wire = {M0[151], M0[135], M0[101], M0[78]};
wire [15:0] layer2_N4_lut = 16'hFF3B;
assign M1[4] = layer2_N4_lut[layer2_N4_wire];

wire [3:0] layer2_N5_wire = {M0[141], M0[128], M0[74], M0[121]};
wire [15:0] layer2_N5_lut = 16'h00CE;
assign M1[5] = layer2_N5_lut[layer2_N5_wire];

wire [3:0] layer2_N6_wire = {M0[42], M0[47], M0[109], M0[5]};
wire [15:0] layer2_N6_lut = 16'h0505;
assign M1[6] = layer2_N6_lut[layer2_N6_wire];

wire [3:0] layer2_N7_wire = {M0[151], M0[135], M0[26], M0[140]};
wire [15:0] layer2_N7_lut = 16'h1032;
assign M1[7] = layer2_N7_lut[layer2_N7_wire];

wire [3:0] layer2_N8_wire = {M0[149], M0[35], M0[151], M0[17]};
wire [15:0] layer2_N8_lut = 16'hFDDC;
assign M1[8] = layer2_N8_lut[layer2_N8_wire];

wire [3:0] layer2_N9_wire = {M0[81], M0[94], M0[62], M0[149]};
wire [15:0] layer2_N9_lut = 16'h7F01;
assign M1[9] = layer2_N9_lut[layer2_N9_wire];

wire [3:0] layer2_N10_wire = {M0[43], M0[1], M0[8], M0[135]};
wire [15:0] layer2_N10_lut = 16'h88E8;
assign M1[10] = layer2_N10_lut[layer2_N10_wire];

wire [3:0] layer2_N11_wire = {M0[114], M0[87], M0[36], M0[135]};
wire [15:0] layer2_N11_lut = 16'h20B2;
assign M1[11] = layer2_N11_lut[layer2_N11_wire];

wire [3:0] layer2_N12_wire = {M0[18], M0[90], M0[120], M0[22]};
wire [15:0] layer2_N12_lut = 16'hDCC4;
assign M1[12] = layer2_N12_lut[layer2_N12_wire];

wire [3:0] layer2_N13_wire = {M0[132], M0[35], M0[100], M0[117]};
wire [15:0] layer2_N13_lut = 16'h30F0;
assign M1[13] = layer2_N13_lut[layer2_N13_wire];

wire [3:0] layer2_N14_wire = {M0[98], M0[120], M0[136], M0[110]};
wire [15:0] layer2_N14_lut = 16'hCCCC;
assign M1[14] = layer2_N14_lut[layer2_N14_wire];

wire [3:0] layer2_N15_wire = {M0[140], M0[126], M0[44], M0[137]};
wire [15:0] layer2_N15_lut = 16'h5F4F;
assign M1[15] = layer2_N15_lut[layer2_N15_wire];

wire [3:0] layer2_N16_wire = {M0[131], M0[97], M0[4], M0[128]};
wire [15:0] layer2_N16_lut = 16'hCF0D;
assign M1[16] = layer2_N16_lut[layer2_N16_wire];

wire [3:0] layer2_N17_wire = {M0[26], M0[17], M0[46], M0[131]};
wire [15:0] layer2_N17_lut = 16'h44EE;
assign M1[17] = layer2_N17_lut[layer2_N17_wire];

wire [3:0] layer2_N18_wire = {M0[0], M0[149], M0[148], M0[17]};
wire [15:0] layer2_N18_lut = 16'h0CFF;
assign M1[18] = layer2_N18_lut[layer2_N18_wire];

wire [3:0] layer2_N19_wire = {M0[11], M0[71], M0[74], M0[108]};
wire [15:0] layer2_N19_lut = 16'hBB2B;
assign M1[19] = layer2_N19_lut[layer2_N19_wire];

wire [3:0] layer2_N20_wire = {M0[36], M0[135], M0[45], M0[138]};
wire [15:0] layer2_N20_lut = 16'hEF0C;
assign M1[20] = layer2_N20_lut[layer2_N20_wire];

wire [3:0] layer2_N21_wire = {M0[36], M0[81], M0[100], M0[4]};
wire [15:0] layer2_N21_lut = 16'hF4FC;
assign M1[21] = layer2_N21_lut[layer2_N21_wire];

wire [3:0] layer2_N22_wire = {M0[140], M0[131], M0[105], M0[144]};
wire [15:0] layer2_N22_lut = 16'hD0D8;
assign M1[22] = layer2_N22_lut[layer2_N22_wire];

wire [3:0] layer2_N23_wire = {M0[109], M0[11], M0[113], M0[88]};
wire [15:0] layer2_N23_lut = 16'hC0F0;
assign M1[23] = layer2_N23_lut[layer2_N23_wire];

wire [3:0] layer2_N24_wire = {M0[131], M0[140], M0[84], M0[67]};
wire [15:0] layer2_N24_lut = 16'hF711;
assign M1[24] = layer2_N24_lut[layer2_N24_wire];

wire [3:0] layer2_N25_wire = {M0[140], M0[23], M0[131], M0[57]};
wire [15:0] layer2_N25_lut = 16'hF0E8;
assign M1[25] = layer2_N25_lut[layer2_N25_wire];

wire [3:0] layer2_N26_wire = {M0[80], M0[131], M0[116], M0[104]};
wire [15:0] layer2_N26_lut = 16'hDCD8;
assign M1[26] = layer2_N26_lut[layer2_N26_wire];

wire [3:0] layer2_N27_wire = {M0[138], M0[76], M0[25], M0[64]};
wire [15:0] layer2_N27_lut = 16'h88F8;
assign M1[27] = layer2_N27_lut[layer2_N27_wire];

wire [3:0] layer2_N28_wire = {M0[99], M0[66], M0[17], M0[27]};
wire [15:0] layer2_N28_lut = 16'h0FFF;
assign M1[28] = layer2_N28_lut[layer2_N28_wire];

wire [3:0] layer2_N29_wire = {M0[36], M0[128], M0[42], M0[141]};
wire [15:0] layer2_N29_lut = 16'h8AFE;
assign M1[29] = layer2_N29_lut[layer2_N29_wire];

wire [3:0] layer2_N30_wire = {M0[119], M0[34], M0[61], M0[128]};
wire [15:0] layer2_N30_lut = 16'h0ACF;
assign M1[30] = layer2_N30_lut[layer2_N30_wire];

wire [3:0] layer2_N31_wire = {M0[111], M0[42], M0[56], M0[128]};
wire [15:0] layer2_N31_lut = 16'h3333;
assign M1[31] = layer2_N31_lut[layer2_N31_wire];

wire [3:0] layer2_N32_wire = {M0[76], M0[108], M0[152], M0[72]};
wire [15:0] layer2_N32_lut = 16'h0B4D;
assign M1[32] = layer2_N32_lut[layer2_N32_wire];

wire [3:0] layer2_N33_wire = {M0[109], M0[33], M0[36], M0[100]};
wire [15:0] layer2_N33_lut = 16'h0B2B;
assign M1[33] = layer2_N33_lut[layer2_N33_wire];

wire [3:0] layer2_N34_wire = {M0[151], M0[8], M0[104], M0[99]};
wire [15:0] layer2_N34_lut = 16'h00D5;
assign M1[34] = layer2_N34_lut[layer2_N34_wire];

wire [3:0] layer2_N35_wire = {M0[159], M0[75], M0[132], M0[16]};
wire [15:0] layer2_N35_lut = 16'h8CEF;
assign M1[35] = layer2_N35_lut[layer2_N35_wire];

wire [3:0] layer2_N36_wire = {M0[110], M0[28], M0[86], M0[84]};
wire [15:0] layer2_N36_lut = 16'hFF00;
assign M1[36] = layer2_N36_lut[layer2_N36_wire];

wire [3:0] layer2_N37_wire = {M0[6], M0[159], M0[124], M0[154]};
wire [15:0] layer2_N37_lut = 16'h020F;
assign M1[37] = layer2_N37_lut[layer2_N37_wire];

wire [3:0] layer2_N38_wire = {M0[140], M0[6], M0[84], M0[9]};
wire [15:0] layer2_N38_lut = 16'h454D;
assign M1[38] = layer2_N38_lut[layer2_N38_wire];

wire [3:0] layer2_N39_wire = {M0[139], M0[154], M0[26], M0[21]};
wire [15:0] layer2_N39_lut = 16'hFF44;
assign M1[39] = layer2_N39_lut[layer2_N39_wire];

wire [3:0] layer2_N40_wire = {M0[36], M0[159], M0[33], M0[157]};
wire [15:0] layer2_N40_lut = 16'h0133;
assign M1[40] = layer2_N40_lut[layer2_N40_wire];

wire [3:0] layer2_N41_wire = {M0[110], M0[16], M0[71], M0[137]};
wire [15:0] layer2_N41_lut = 16'hB2A2;
assign M1[41] = layer2_N41_lut[layer2_N41_wire];

wire [3:0] layer2_N42_wire = {M0[0], M0[80], M0[110], M0[157]};
wire [15:0] layer2_N42_lut = 16'hFFB2;
assign M1[42] = layer2_N42_lut[layer2_N42_wire];

wire [3:0] layer2_N43_wire = {M0[0], M0[47], M0[131], M0[151]};
wire [15:0] layer2_N43_lut = 16'h0105;
assign M1[43] = layer2_N43_lut[layer2_N43_wire];

wire [3:0] layer2_N44_wire = {M0[36], M0[95], M0[157], M0[114]};
wire [15:0] layer2_N44_lut = 16'h0557;
assign M1[44] = layer2_N44_lut[layer2_N44_wire];

wire [3:0] layer2_N45_wire = {M0[131], M0[63], M0[66], M0[16]};
wire [15:0] layer2_N45_lut = 16'hDD4C;
assign M1[45] = layer2_N45_lut[layer2_N45_wire];

wire [3:0] layer2_N46_wire = {M0[159], M0[36], M0[66], M0[62]};
wire [15:0] layer2_N46_lut = 16'hDDC0;
assign M1[46] = layer2_N46_lut[layer2_N46_wire];

wire [3:0] layer2_N47_wire = {M0[0], M0[8], M0[45], M0[87]};
wire [15:0] layer2_N47_lut = 16'hCF45;
assign M1[47] = layer2_N47_lut[layer2_N47_wire];

wire [3:0] layer2_N48_wire = {M0[132], M0[159], M0[120], M0[66]};
wire [15:0] layer2_N48_lut = 16'h32B2;
assign M1[48] = layer2_N48_lut[layer2_N48_wire];

wire [3:0] layer2_N49_wire = {M0[44], M0[119], M0[35], M0[0]};
wire [15:0] layer2_N49_lut = 16'h0077;
assign M1[49] = layer2_N49_lut[layer2_N49_wire];

wire [3:0] layer2_N50_wire = {M0[2], M0[96], M0[157], M0[100]};
wire [15:0] layer2_N50_lut = 16'h04F5;
assign M1[50] = layer2_N50_lut[layer2_N50_wire];

wire [3:0] layer2_N51_wire = {M0[96], M0[35], M0[110], M0[149]};
wire [15:0] layer2_N51_lut = 16'h32B3;
assign M1[51] = layer2_N51_lut[layer2_N51_wire];

wire [3:0] layer2_N52_wire = {M0[131], M0[80], M0[42], M0[125]};
wire [15:0] layer2_N52_lut = 16'h08EF;
assign M1[52] = layer2_N52_lut[layer2_N52_wire];

wire [3:0] layer2_N53_wire = {M0[80], M0[25], M0[44], M0[60]};
wire [15:0] layer2_N53_lut = 16'hCF0E;
assign M1[53] = layer2_N53_lut[layer2_N53_wire];

wire [3:0] layer2_N54_wire = {M0[42], M0[76], M0[109], M0[125]};
wire [15:0] layer2_N54_lut = 16'hFB0A;
assign M1[54] = layer2_N54_lut[layer2_N54_wire];

wire [3:0] layer2_N55_wire = {M0[131], M0[109], M0[145], M0[8]};
wire [15:0] layer2_N55_lut = 16'h3333;
assign M1[55] = layer2_N55_lut[layer2_N55_wire];

wire [3:0] layer2_N56_wire = {M0[118], M0[142], M0[99], M0[157]};
wire [15:0] layer2_N56_lut = 16'h073F;
assign M1[56] = layer2_N56_lut[layer2_N56_wire];

wire [3:0] layer2_N57_wire = {M0[125], M0[118], M0[155], M0[16]};
wire [15:0] layer2_N57_lut = 16'h2300;
assign M1[57] = layer2_N57_lut[layer2_N57_wire];

wire [3:0] layer2_N58_wire = {M0[119], M0[84], M0[124], M0[58]};
wire [15:0] layer2_N58_lut = 16'h8E8C;
assign M1[58] = layer2_N58_lut[layer2_N58_wire];

wire [3:0] layer2_N59_wire = {M0[57], M0[117], M0[141], M0[72]};
wire [15:0] layer2_N59_lut = 16'h888F;
assign M1[59] = layer2_N59_lut[layer2_N59_wire];

wire [3:0] layer2_N60_wire = {M0[67], M0[7], M0[141], M0[150]};
wire [15:0] layer2_N60_lut = 16'h3177;
assign M1[60] = layer2_N60_lut[layer2_N60_wire];

wire [3:0] layer2_N61_wire = {M0[0], M0[119], M0[12], M0[125]};
wire [15:0] layer2_N61_lut = 16'h44CC;
assign M1[61] = layer2_N61_lut[layer2_N61_wire];

wire [3:0] layer2_N62_wire = {M0[7], M0[42], M0[137], M0[36]};
wire [15:0] layer2_N62_lut = 16'hD4D4;
assign M1[62] = layer2_N62_lut[layer2_N62_wire];

wire [3:0] layer2_N63_wire = {M0[131], M0[8], M0[125], M0[46]};
wire [15:0] layer2_N63_lut = 16'h80AA;
assign M1[63] = layer2_N63_lut[layer2_N63_wire];

wire [3:0] layer2_N64_wire = {M0[1], M0[32], M0[30], M0[11]};
wire [15:0] layer2_N64_lut = 16'hCCEC;
assign M1[64] = layer2_N64_lut[layer2_N64_wire];

wire [3:0] layer2_N65_wire = {M0[95], M0[100], M0[122], M0[83]};
wire [15:0] layer2_N65_lut = 16'h1F0F;
assign M1[65] = layer2_N65_lut[layer2_N65_wire];

wire [3:0] layer2_N66_wire = {M0[11], M0[3], M0[51], M0[17]};
wire [15:0] layer2_N66_lut = 16'h9F0C;
assign M1[66] = layer2_N66_lut[layer2_N66_wire];

wire [3:0] layer2_N67_wire = {M0[16], M0[104], M0[42], M0[28]};
wire [15:0] layer2_N67_lut = 16'h0F0F;
assign M1[67] = layer2_N67_lut[layer2_N67_wire];

wire [3:0] layer2_N68_wire = {M0[37], M0[74], M0[103], M0[81]};
wire [15:0] layer2_N68_lut = 16'h3133;
assign M1[68] = layer2_N68_lut[layer2_N68_wire];

wire [3:0] layer2_N69_wire = {M0[40], M0[3], M0[42], M0[84]};
wire [15:0] layer2_N69_lut = 16'h7070;
assign M1[69] = layer2_N69_lut[layer2_N69_wire];

wire [3:0] layer2_N70_wire = {M0[121], M0[1], M0[7], M0[19]};
wire [15:0] layer2_N70_lut = 16'hAB02;
assign M1[70] = layer2_N70_lut[layer2_N70_wire];

wire [3:0] layer2_N71_wire = {M0[1], M0[3], M0[77], M0[63]};
wire [15:0] layer2_N71_lut = 16'hFCC0;
assign M1[71] = layer2_N71_lut[layer2_N71_wire];

wire [3:0] layer2_N72_wire = {M0[3], M0[82], M0[109], M0[142]};
wire [15:0] layer2_N72_lut = 16'hBF3D;
assign M1[72] = layer2_N72_lut[layer2_N72_wire];

wire [3:0] layer2_N73_wire = {M0[148], M0[76], M0[117], M0[86]};
wire [15:0] layer2_N73_lut = 16'hB300;
assign M1[73] = layer2_N73_lut[layer2_N73_wire];

wire [3:0] layer2_N74_wire = {M0[36], M0[101], M0[144], M0[115]};
wire [15:0] layer2_N74_lut = 16'h44DC;
assign M1[74] = layer2_N74_lut[layer2_N74_wire];

wire [3:0] layer2_N75_wire = {M0[109], M0[25], M0[82], M0[15]};
wire [15:0] layer2_N75_lut = 16'hD0C0;
assign M1[75] = layer2_N75_lut[layer2_N75_wire];

wire [3:0] layer2_N76_wire = {M0[141], M0[1], M0[31], M0[140]};
wire [15:0] layer2_N76_lut = 16'hFFCC;
assign M1[76] = layer2_N76_lut[layer2_N76_wire];

wire [3:0] layer2_N77_wire = {M0[25], M0[152], M0[109], M0[40]};
wire [15:0] layer2_N77_lut = 16'h00AF;
assign M1[77] = layer2_N77_lut[layer2_N77_wire];

wire [3:0] layer2_N78_wire = {M0[42], M0[79], M0[37], M0[95]};
wire [15:0] layer2_N78_lut = 16'h0745;
assign M1[78] = layer2_N78_lut[layer2_N78_wire];

wire [3:0] layer2_N79_wire = {M0[40], M0[122], M0[109], M0[90]};
wire [15:0] layer2_N79_lut = 16'hCCFD;
assign M1[79] = layer2_N79_lut[layer2_N79_wire];

wire [3:0] layer2_N80_wire = {M0[142], M0[16], M0[30], M0[27]};
wire [15:0] layer2_N80_lut = 16'hAAB2;
assign M1[80] = layer2_N80_lut[layer2_N80_wire];

wire [3:0] layer2_N81_wire = {M0[10], M0[140], M0[11], M0[76]};
wire [15:0] layer2_N81_lut = 16'hF333;
assign M1[81] = layer2_N81_lut[layer2_N81_wire];

wire [3:0] layer2_N82_wire = {M0[123], M0[46], M0[92], M0[30]};
wire [15:0] layer2_N82_lut = 16'hCCCF;
assign M1[82] = layer2_N82_lut[layer2_N82_wire];

wire [3:0] layer2_N83_wire = {M0[122], M0[95], M0[2], M0[132]};
wire [15:0] layer2_N83_lut = 16'h455D;
assign M1[83] = layer2_N83_lut[layer2_N83_wire];

wire [3:0] layer2_N84_wire = {M0[144], M0[86], M0[116], M0[148]};
wire [15:0] layer2_N84_lut = 16'h2302;
assign M1[84] = layer2_N84_lut[layer2_N84_wire];

wire [3:0] layer2_N85_wire = {M0[1], M0[3], M0[66], M0[125]};
wire [15:0] layer2_N85_lut = 16'hE2D0;
assign M1[85] = layer2_N85_lut[layer2_N85_wire];

wire [3:0] layer2_N86_wire = {M0[17], M0[158], M0[152], M0[142]};
wire [15:0] layer2_N86_lut = 16'h054D;
assign M1[86] = layer2_N86_lut[layer2_N86_wire];

wire [3:0] layer2_N87_wire = {M0[52], M0[29], M0[9], M0[79]};
wire [15:0] layer2_N87_lut = 16'h2302;
assign M1[87] = layer2_N87_lut[layer2_N87_wire];

wire [3:0] layer2_N88_wire = {M0[10], M0[11], M0[109], M0[129]};
wire [15:0] layer2_N88_lut = 16'h88AA;
assign M1[88] = layer2_N88_lut[layer2_N88_wire];

wire [3:0] layer2_N89_wire = {M0[121], M0[10], M0[131], M0[91]};
wire [15:0] layer2_N89_lut = 16'h7F04;
assign M1[89] = layer2_N89_lut[layer2_N89_wire];

wire [3:0] layer2_N90_wire = {M0[105], M0[1], M0[53], M0[43]};
wire [15:0] layer2_N90_lut = 16'hA9AA;
assign M1[90] = layer2_N90_lut[layer2_N90_wire];

wire [3:0] layer2_N91_wire = {M0[45], M0[27], M0[3], M0[143]};
wire [15:0] layer2_N91_lut = 16'h033B;
assign M1[91] = layer2_N91_lut[layer2_N91_wire];

wire [3:0] layer2_N92_wire = {M0[58], M0[123], M0[88], M0[9]};
wire [15:0] layer2_N92_lut = 16'h5551;
assign M1[92] = layer2_N92_lut[layer2_N92_wire];

wire [3:0] layer2_N93_wire = {M0[148], M0[9], M0[8], M0[20]};
wire [15:0] layer2_N93_lut = 16'h0505;
assign M1[93] = layer2_N93_lut[layer2_N93_wire];

wire [3:0] layer2_N94_wire = {M0[151], M0[44], M0[111], M0[106]};
wire [15:0] layer2_N94_lut = 16'h00FA;
assign M1[94] = layer2_N94_lut[layer2_N94_wire];

wire [3:0] layer2_N95_wire = {M0[121], M0[100], M0[122], M0[3]};
wire [15:0] layer2_N95_lut = 16'h5D15;
assign M1[95] = layer2_N95_lut[layer2_N95_wire];

wire [3:0] layer2_N96_wire = {M0[11], M0[19], M0[158], M0[95]};
wire [15:0] layer2_N96_lut = 16'hAA00;
assign M1[96] = layer2_N96_lut[layer2_N96_wire];

wire [3:0] layer2_N97_wire = {M0[19], M0[10], M0[56], M0[64]};
wire [15:0] layer2_N97_lut = 16'h10FF;
assign M1[97] = layer2_N97_lut[layer2_N97_wire];

wire [3:0] layer2_N98_wire = {M0[105], M0[32], M0[93], M0[104]};
wire [15:0] layer2_N98_lut = 16'h45CD;
assign M1[98] = layer2_N98_lut[layer2_N98_wire];

wire [3:0] layer2_N99_wire = {M0[19], M0[81], M0[27], M0[36]};
wire [15:0] layer2_N99_lut = 16'h3F04;
assign M1[99] = layer2_N99_lut[layer2_N99_wire];

wire [3:0] layer2_N100_wire = {M0[13], M0[10], M0[148], M0[79]};
wire [15:0] layer2_N100_lut = 16'h5555;
assign M1[100] = layer2_N100_lut[layer2_N100_wire];

wire [3:0] layer2_N101_wire = {M0[109], M0[84], M0[115], M0[133]};
wire [15:0] layer2_N101_lut = 16'hAAEF;
assign M1[101] = layer2_N101_lut[layer2_N101_wire];

wire [3:0] layer2_N102_wire = {M0[13], M0[10], M0[153], M0[61]};
wire [15:0] layer2_N102_lut = 16'hFEEA;
assign M1[102] = layer2_N102_lut[layer2_N102_wire];

wire [3:0] layer2_N103_wire = {M0[109], M0[42], M0[84], M0[142]};
wire [15:0] layer2_N103_lut = 16'h5D5D;
assign M1[103] = layer2_N103_lut[layer2_N103_wire];

wire [3:0] layer2_N104_wire = {M0[39], M0[97], M0[139], M0[144]};
wire [15:0] layer2_N104_lut = 16'hAAE8;
assign M1[104] = layer2_N104_lut[layer2_N104_wire];

wire [3:0] layer2_N105_wire = {M0[111], M0[102], M0[85], M0[28]};
wire [15:0] layer2_N105_lut = 16'h2302;
assign M1[105] = layer2_N105_lut[layer2_N105_wire];

wire [3:0] layer2_N106_wire = {M0[0], M0[148], M0[151], M0[15]};
wire [15:0] layer2_N106_lut = 16'h2231;
assign M1[106] = layer2_N106_lut[layer2_N106_wire];

wire [3:0] layer2_N107_wire = {M0[109], M0[0], M0[140], M0[73]};
wire [15:0] layer2_N107_lut = 16'h04DD;
assign M1[107] = layer2_N107_lut[layer2_N107_wire];

wire [3:0] layer2_N108_wire = {M0[68], M0[159], M0[103], M0[142]};
wire [15:0] layer2_N108_lut = 16'h0033;
assign M1[108] = layer2_N108_lut[layer2_N108_wire];

wire [3:0] layer2_N109_wire = {M0[93], M0[1], M0[61], M0[132]};
wire [15:0] layer2_N109_lut = 16'h223A;
assign M1[109] = layer2_N109_lut[layer2_N109_wire];

wire [3:0] layer2_N110_wire = {M0[51], M0[87], M0[37], M0[89]};
wire [15:0] layer2_N110_lut = 16'h70F0;
assign M1[110] = layer2_N110_lut[layer2_N110_wire];

wire [3:0] layer2_N111_wire = {M0[159], M0[93], M0[37], M0[148]};
wire [15:0] layer2_N111_lut = 16'hFF50;
assign M1[111] = layer2_N111_lut[layer2_N111_wire];

wire [3:0] layer2_N112_wire = {M0[1], M0[147], M0[61], M0[93]};
wire [15:0] layer2_N112_lut = 16'hEECE;
assign M1[112] = layer2_N112_lut[layer2_N112_wire];

wire [3:0] layer2_N113_wire = {M0[93], M0[120], M0[148], M0[73]};
wire [15:0] layer2_N113_lut = 16'h00E8;
assign M1[113] = layer2_N113_lut[layer2_N113_wire];

wire [3:0] layer2_N114_wire = {M0[1], M0[93], M0[8], M0[140]};
wire [15:0] layer2_N114_lut = 16'h131B;
assign M1[114] = layer2_N114_lut[layer2_N114_wire];

wire [3:0] layer2_N115_wire = {M0[69], M0[63], M0[151], M0[157]};
wire [15:0] layer2_N115_lut = 16'hDDDD;
assign M1[115] = layer2_N115_lut[layer2_N115_wire];

wire [3:0] layer2_N116_wire = {M0[109], M0[35], M0[67], M0[115]};
wire [15:0] layer2_N116_lut = 16'h1311;
assign M1[116] = layer2_N116_lut[layer2_N116_wire];

wire [3:0] layer2_N117_wire = {M0[109], M0[90], M0[142], M0[14]};
wire [15:0] layer2_N117_lut = 16'h54FF;
assign M1[117] = layer2_N117_lut[layer2_N117_wire];

wire [3:0] layer2_N118_wire = {M0[111], M0[100], M0[2], M0[59]};
wire [15:0] layer2_N118_lut = 16'hD5FF;
assign M1[118] = layer2_N118_lut[layer2_N118_wire];

wire [3:0] layer2_N119_wire = {M0[142], M0[90], M0[138], M0[119]};
wire [15:0] layer2_N119_lut = 16'hCCDF;
assign M1[119] = layer2_N119_lut[layer2_N119_wire];

wire [3:0] layer2_N120_wire = {M0[133], M0[148], M0[100], M0[56]};
wire [15:0] layer2_N120_lut = 16'h2033;
assign M1[120] = layer2_N120_lut[layer2_N120_wire];

wire [3:0] layer2_N121_wire = {M0[100], M0[14], M0[142], M0[90]};
wire [15:0] layer2_N121_lut = 16'hF1CF;
assign M1[121] = layer2_N121_lut[layer2_N121_wire];

wire [3:0] layer2_N122_wire = {M0[14], M0[90], M0[76], M0[16]};
wire [15:0] layer2_N122_lut = 16'h2320;
assign M1[122] = layer2_N122_lut[layer2_N122_wire];

wire [3:0] layer2_N123_wire = {M0[47], M0[112], M0[113], M0[133]};
wire [15:0] layer2_N123_lut = 16'h5151;
assign M1[123] = layer2_N123_lut[layer2_N123_wire];

wire [3:0] layer2_N124_wire = {M0[1], M0[13], M0[57], M0[140]};
wire [15:0] layer2_N124_lut = 16'hA3E2;
assign M1[124] = layer2_N124_lut[layer2_N124_wire];

wire [3:0] layer2_N125_wire = {M0[42], M0[104], M0[3], M0[129]};
wire [15:0] layer2_N125_lut = 16'h5FDF;
assign M1[125] = layer2_N125_lut[layer2_N125_wire];

wire [3:0] layer2_N126_wire = {M0[1], M0[140], M0[68], M0[63]};
wire [15:0] layer2_N126_lut = 16'hC444;
assign M1[126] = layer2_N126_lut[layer2_N126_wire];

wire [3:0] layer2_N127_wire = {M0[140], M0[19], M0[1], M0[42]};
wire [15:0] layer2_N127_lut = 16'hCD0F;
assign M1[127] = layer2_N127_lut[layer2_N127_wire];

wire [3:0] layer2_N128_wire = {M0[103], M0[105], M0[158], M0[106]};
wire [15:0] layer2_N128_lut = 16'hAA37;
assign M1[128] = layer2_N128_lut[layer2_N128_wire];

wire [3:0] layer2_N129_wire = {M0[53], M0[105], M0[28], M0[79]};
wire [15:0] layer2_N129_lut = 16'hDDC0;
assign M1[129] = layer2_N129_lut[layer2_N129_wire];

wire [3:0] layer2_N130_wire = {M0[20], M0[46], M0[72], M0[106]};
wire [15:0] layer2_N130_lut = 16'h02F6;
assign M1[130] = layer2_N130_lut[layer2_N130_wire];

wire [3:0] layer2_N131_wire = {M0[35], M0[80], M0[145], M0[51]};
wire [15:0] layer2_N131_lut = 16'hDD50;
assign M1[131] = layer2_N131_lut[layer2_N131_wire];

wire [3:0] layer2_N132_wire = {M0[140], M0[120], M0[148], M0[80]};
wire [15:0] layer2_N132_lut = 16'h3120;
assign M1[132] = layer2_N132_lut[layer2_N132_wire];

wire [3:0] layer2_N133_wire = {M0[105], M0[61], M0[111], M0[122]};
wire [15:0] layer2_N133_lut = 16'h557F;
assign M1[133] = layer2_N133_lut[layer2_N133_wire];

wire [3:0] layer2_N134_wire = {M0[152], M0[4], M0[83], M0[63]};
wire [15:0] layer2_N134_lut = 16'h00D4;
assign M1[134] = layer2_N134_lut[layer2_N134_wire];

wire [3:0] layer2_N135_wire = {M0[92], M0[111], M0[140], M0[149]};
wire [15:0] layer2_N135_lut = 16'hFA80;
assign M1[135] = layer2_N135_lut[layer2_N135_wire];

wire [3:0] layer2_N136_wire = {M0[30], M0[66], M0[35], M0[151]};
wire [15:0] layer2_N136_lut = 16'h5010;
assign M1[136] = layer2_N136_lut[layer2_N136_wire];

wire [3:0] layer2_N137_wire = {M0[96], M0[69], M0[10], M0[68]};
wire [15:0] layer2_N137_lut = 16'hF733;
assign M1[137] = layer2_N137_lut[layer2_N137_wire];

wire [3:0] layer2_N138_wire = {M0[107], M0[16], M0[60], M0[65]};
wire [15:0] layer2_N138_lut = 16'hF0FF;
assign M1[138] = layer2_N138_lut[layer2_N138_wire];

wire [3:0] layer2_N139_wire = {M0[2], M0[106], M0[77], M0[109]};
wire [15:0] layer2_N139_lut = 16'hFA54;
assign M1[139] = layer2_N139_lut[layer2_N139_wire];

wire [3:0] layer2_N140_wire = {M0[125], M0[11], M0[54], M0[19]};
wire [15:0] layer2_N140_lut = 16'hEEDF;
assign M1[140] = layer2_N140_lut[layer2_N140_wire];

wire [3:0] layer2_N141_wire = {M0[79], M0[53], M0[105], M0[35]};
wire [15:0] layer2_N141_lut = 16'hAF2F;
assign M1[141] = layer2_N141_lut[layer2_N141_wire];

wire [3:0] layer2_N142_wire = {M0[28], M0[107], M0[118], M0[108]};
wire [15:0] layer2_N142_lut = 16'h2FBF;
assign M1[142] = layer2_N142_lut[layer2_N142_wire];

wire [3:0] layer2_N143_wire = {M0[77], M0[131], M0[79], M0[16]};
wire [15:0] layer2_N143_lut = 16'h5050;
assign M1[143] = layer2_N143_lut[layer2_N143_wire];

wire [3:0] layer2_N144_wire = {M0[85], M0[11], M0[64], M0[36]};
wire [15:0] layer2_N144_lut = 16'h2231;
assign M1[144] = layer2_N144_lut[layer2_N144_wire];

wire [3:0] layer2_N145_wire = {M0[35], M0[9], M0[80], M0[30]};
wire [15:0] layer2_N145_lut = 16'hDD4C;
assign M1[145] = layer2_N145_lut[layer2_N145_wire];

wire [3:0] layer2_N146_wire = {M0[109], M0[140], M0[133], M0[18]};
wire [15:0] layer2_N146_lut = 16'hBBBB;
assign M1[146] = layer2_N146_lut[layer2_N146_wire];

wire [3:0] layer2_N147_wire = {M0[109], M0[32], M0[36], M0[114]};
wire [15:0] layer2_N147_lut = 16'hBF03;
assign M1[147] = layer2_N147_lut[layer2_N147_wire];

wire [3:0] layer2_N148_wire = {M0[61], M0[79], M0[126], M0[0]};
wire [15:0] layer2_N148_lut = 16'hCDCD;
assign M1[148] = layer2_N148_lut[layer2_N148_wire];

wire [3:0] layer2_N149_wire = {M0[115], M0[158], M0[79], M0[28]};
wire [15:0] layer2_N149_lut = 16'h455F;
assign M1[149] = layer2_N149_lut[layer2_N149_wire];

wire [3:0] layer2_N150_wire = {M0[12], M0[76], M0[146], M0[64]};
wire [15:0] layer2_N150_lut = 16'hFFEC;
assign M1[150] = layer2_N150_lut[layer2_N150_wire];

wire [3:0] layer2_N151_wire = {M0[154], M0[74], M0[39], M0[98]};
wire [15:0] layer2_N151_lut = 16'hFFAF;
assign M1[151] = layer2_N151_lut[layer2_N151_wire];

wire [3:0] layer2_N152_wire = {M0[30], M0[73], M0[38], M0[142]};
wire [15:0] layer2_N152_lut = 16'h7177;
assign M1[152] = layer2_N152_lut[layer2_N152_wire];

wire [3:0] layer2_N153_wire = {M0[105], M0[111], M0[14], M0[50]};
wire [15:0] layer2_N153_lut = 16'hCCDF;
assign M1[153] = layer2_N153_lut[layer2_N153_wire];

wire [3:0] layer2_N154_wire = {M0[11], M0[87], M0[61], M0[106]};
wire [15:0] layer2_N154_lut = 16'h22AF;
assign M1[154] = layer2_N154_lut[layer2_N154_wire];

wire [3:0] layer2_N155_wire = {M0[46], M0[19], M0[110], M0[105]};
wire [15:0] layer2_N155_lut = 16'h1133;
assign M1[155] = layer2_N155_lut[layer2_N155_wire];

wire [3:0] layer2_N156_wire = {M0[8], M0[97], M0[62], M0[95]};
wire [15:0] layer2_N156_lut = 16'h0F0F;
assign M1[156] = layer2_N156_lut[layer2_N156_wire];

wire [3:0] layer2_N157_wire = {M0[120], M0[20], M0[95], M0[132]};
wire [15:0] layer2_N157_lut = 16'hF051;
assign M1[157] = layer2_N157_lut[layer2_N157_wire];

wire [3:0] layer2_N158_wire = {M0[79], M0[95], M0[154], M0[94]};
wire [15:0] layer2_N158_lut = 16'hDDDC;
assign M1[158] = layer2_N158_lut[layer2_N158_wire];

wire [3:0] layer2_N159_wire = {M0[20], M0[19], M0[46], M0[68]};
wire [15:0] layer2_N159_lut = 16'h22FA;
assign M1[159] = layer2_N159_lut[layer2_N159_wire];

wire [3:0] layer2_N160_wire = {M0[11], M0[109], M0[0], M0[138]};
wire [15:0] layer2_N160_lut = 16'hEAEE;
assign M1[160] = layer2_N160_lut[layer2_N160_wire];

wire [3:0] layer2_N161_wire = {M0[56], M0[109], M0[97], M0[0]};
wire [15:0] layer2_N161_lut = 16'h10B3;
assign M1[161] = layer2_N161_lut[layer2_N161_wire];

wire [3:0] layer2_N162_wire = {M0[11], M0[109], M0[145], M0[2]};
wire [15:0] layer2_N162_lut = 16'h3303;
assign M1[162] = layer2_N162_lut[layer2_N162_wire];

wire [3:0] layer2_N163_wire = {M0[11], M0[125], M0[9], M0[109]};
wire [15:0] layer2_N163_lut = 16'h3F2F;
assign M1[163] = layer2_N163_lut[layer2_N163_wire];

wire [3:0] layer2_N164_wire = {M0[11], M0[77], M0[109], M0[2]};
wire [15:0] layer2_N164_lut = 16'h2F02;
assign M1[164] = layer2_N164_lut[layer2_N164_wire];

wire [3:0] layer2_N165_wire = {M0[127], M0[151], M0[80], M0[31]};
wire [15:0] layer2_N165_lut = 16'hF8FE;
assign M1[165] = layer2_N165_lut[layer2_N165_wire];

wire [3:0] layer2_N166_wire = {M0[109], M0[54], M0[102], M0[10]};
wire [15:0] layer2_N166_lut = 16'h0AAA;
assign M1[166] = layer2_N166_lut[layer2_N166_wire];

wire [3:0] layer2_N167_wire = {M0[109], M0[149], M0[11], M0[102]};
wire [15:0] layer2_N167_lut = 16'h8888;
assign M1[167] = layer2_N167_lut[layer2_N167_wire];

wire [3:0] layer2_N168_wire = {M0[30], M0[77], M0[0], M0[132]};
wire [15:0] layer2_N168_lut = 16'h1D00;
assign M1[168] = layer2_N168_lut[layer2_N168_wire];

wire [3:0] layer2_N169_wire = {M0[126], M0[1], M0[11], M0[125]};
wire [15:0] layer2_N169_lut = 16'h171F;
assign M1[169] = layer2_N169_lut[layer2_N169_wire];

wire [3:0] layer2_N170_wire = {M0[62], M0[79], M0[0], M0[127]};
wire [15:0] layer2_N170_lut = 16'h5410;
assign M1[170] = layer2_N170_lut[layer2_N170_wire];

wire [3:0] layer2_N171_wire = {M0[126], M0[1], M0[62], M0[76]};
wire [15:0] layer2_N171_lut = 16'hF2F0;
assign M1[171] = layer2_N171_lut[layer2_N171_wire];

wire [3:0] layer2_N172_wire = {M0[76], M0[73], M0[80], M0[117]};
wire [15:0] layer2_N172_lut = 16'h88F8;
assign M1[172] = layer2_N172_lut[layer2_N172_wire];

wire [3:0] layer2_N173_wire = {M0[119], M0[128], M0[140], M0[157]};
wire [15:0] layer2_N173_lut = 16'hF3D3;
assign M1[173] = layer2_N173_lut[layer2_N173_wire];

wire [3:0] layer2_N174_wire = {M0[152], M0[107], M0[32], M0[45]};
wire [15:0] layer2_N174_lut = 16'hE0F0;
assign M1[174] = layer2_N174_lut[layer2_N174_wire];

wire [3:0] layer2_N175_wire = {M0[76], M0[119], M0[140], M0[103]};
wire [15:0] layer2_N175_lut = 16'h7515;
assign M1[175] = layer2_N175_lut[layer2_N175_wire];

wire [3:0] layer2_N176_wire = {M0[26], M0[95], M0[144], M0[142]};
wire [15:0] layer2_N176_lut = 16'h5055;
assign M1[176] = layer2_N176_lut[layer2_N176_wire];

wire [3:0] layer2_N177_wire = {M0[109], M0[36], M0[83], M0[79]};
wire [15:0] layer2_N177_lut = 16'hC1F0;
assign M1[177] = layer2_N177_lut[layer2_N177_wire];

wire [3:0] layer2_N178_wire = {M0[155], M0[109], M0[41], M0[30]};
wire [15:0] layer2_N178_lut = 16'h2233;
assign M1[178] = layer2_N178_lut[layer2_N178_wire];

wire [3:0] layer2_N179_wire = {M0[95], M0[1], M0[106], M0[11]};
wire [15:0] layer2_N179_lut = 16'h0F0D;
assign M1[179] = layer2_N179_lut[layer2_N179_wire];

wire [3:0] layer2_N180_wire = {M0[105], M0[158], M0[157], M0[88]};
wire [15:0] layer2_N180_lut = 16'hA3BF;
assign M1[180] = layer2_N180_lut[layer2_N180_wire];

wire [3:0] layer2_N181_wire = {M0[102], M0[158], M0[127], M0[106]};
wire [15:0] layer2_N181_lut = 16'hDC40;
assign M1[181] = layer2_N181_lut[layer2_N181_wire];

wire [3:0] layer2_N182_wire = {M0[19], M0[61], M0[157], M0[21]};
wire [15:0] layer2_N182_lut = 16'hA705;
assign M1[182] = layer2_N182_lut[layer2_N182_wire];

wire [3:0] layer2_N183_wire = {M0[83], M0[149], M0[141], M0[1]};
wire [15:0] layer2_N183_lut = 16'hAA22;
assign M1[183] = layer2_N183_lut[layer2_N183_wire];

wire [3:0] layer2_N184_wire = {M0[55], M0[15], M0[95], M0[11]};
wire [15:0] layer2_N184_lut = 16'h0D5F;
assign M1[184] = layer2_N184_lut[layer2_N184_wire];

wire [3:0] layer2_N185_wire = {M0[20], M0[114], M0[101], M0[32]};
wire [15:0] layer2_N185_lut = 16'h01F7;
assign M1[185] = layer2_N185_lut[layer2_N185_wire];

wire [3:0] layer2_N186_wire = {M0[8], M0[30], M0[79], M0[145]};
wire [15:0] layer2_N186_lut = 16'h30F0;
assign M1[186] = layer2_N186_lut[layer2_N186_wire];

wire [3:0] layer2_N187_wire = {M0[11], M0[50], M0[114], M0[156]};
wire [15:0] layer2_N187_lut = 16'h5454;
assign M1[187] = layer2_N187_lut[layer2_N187_wire];

wire [3:0] layer2_N188_wire = {M0[76], M0[80], M0[109], M0[95]};
wire [15:0] layer2_N188_lut = 16'h1F07;
assign M1[188] = layer2_N188_lut[layer2_N188_wire];

wire [3:0] layer2_N189_wire = {M0[105], M0[31], M0[84], M0[111]};
wire [15:0] layer2_N189_lut = 16'hF5F7;
assign M1[189] = layer2_N189_lut[layer2_N189_wire];

wire [3:0] layer2_N190_wire = {M0[83], M0[142], M0[76], M0[106]};
wire [15:0] layer2_N190_lut = 16'h5410;
assign M1[190] = layer2_N190_lut[layer2_N190_wire];

wire [3:0] layer2_N191_wire = {M0[145], M0[35], M0[77], M0[98]};
wire [15:0] layer2_N191_lut = 16'h0501;
assign M1[191] = layer2_N191_lut[layer2_N191_wire];

wire [3:0] layer2_N192_wire = {M0[142], M0[6], M0[83], M0[114]};
wire [15:0] layer2_N192_lut = 16'h7010;
assign M1[192] = layer2_N192_lut[layer2_N192_wire];

wire [3:0] layer2_N193_wire = {M0[122], M0[38], M0[13], M0[10]};
wire [15:0] layer2_N193_lut = 16'hDC44;
assign M1[193] = layer2_N193_lut[layer2_N193_wire];

wire [3:0] layer2_N194_wire = {M0[142], M0[147], M0[157], M0[118]};
wire [15:0] layer2_N194_lut = 16'hFCF8;
assign M1[194] = layer2_N194_lut[layer2_N194_wire];

wire [3:0] layer2_N195_wire = {M0[11], M0[114], M0[79], M0[125]};
wire [15:0] layer2_N195_lut = 16'hBB22;
assign M1[195] = layer2_N195_lut[layer2_N195_wire];

wire [3:0] layer2_N196_wire = {M0[11], M0[10], M0[6], M0[96]};
wire [15:0] layer2_N196_lut = 16'hCE02;
assign M1[196] = layer2_N196_lut[layer2_N196_wire];

wire [3:0] layer2_N197_wire = {M0[13], M0[2], M0[71], M0[46]};
wire [15:0] layer2_N197_lut = 16'hA2F3;
assign M1[197] = layer2_N197_lut[layer2_N197_wire];

wire [3:0] layer2_N198_wire = {M0[148], M0[84], M0[15], M0[61]};
wire [15:0] layer2_N198_lut = 16'hFEEA;
assign M1[198] = layer2_N198_lut[layer2_N198_wire];

wire [3:0] layer2_N199_wire = {M0[62], M0[157], M0[81], M0[69]};
wire [15:0] layer2_N199_lut = 16'hAE0A;
assign M1[199] = layer2_N199_lut[layer2_N199_wire];

wire [3:0] layer2_N200_wire = {M0[88], M0[106], M0[34], M0[46]};
wire [15:0] layer2_N200_lut = 16'hFB3B;
assign M1[200] = layer2_N200_lut[layer2_N200_wire];

wire [3:0] layer2_N201_wire = {M0[65], M0[135], M0[34], M0[96]};
wire [15:0] layer2_N201_lut = 16'hFF11;
assign M1[201] = layer2_N201_lut[layer2_N201_wire];

wire [3:0] layer2_N202_wire = {M0[133], M0[105], M0[89], M0[11]};
wire [15:0] layer2_N202_lut = 16'h2C04;
assign M1[202] = layer2_N202_lut[layer2_N202_wire];

wire [3:0] layer2_N203_wire = {M0[46], M0[145], M0[16], M0[67]};
wire [15:0] layer2_N203_lut = 16'h3717;
assign M1[203] = layer2_N203_lut[layer2_N203_wire];

wire [3:0] layer2_N204_wire = {M0[147], M0[123], M0[115], M0[49]};
wire [15:0] layer2_N204_lut = 16'hFFAA;
assign M1[204] = layer2_N204_lut[layer2_N204_wire];

wire [3:0] layer2_N205_wire = {M0[145], M0[142], M0[58], M0[86]};
wire [15:0] layer2_N205_lut = 16'hFD50;
assign M1[205] = layer2_N205_lut[layer2_N205_wire];

wire [3:0] layer2_N206_wire = {M0[62], M0[147], M0[142], M0[58]};
wire [15:0] layer2_N206_lut = 16'h8F00;
assign M1[206] = layer2_N206_lut[layer2_N206_wire];

wire [3:0] layer2_N207_wire = {M0[48], M0[87], M0[132], M0[124]};
wire [15:0] layer2_N207_lut = 16'hFF2B;
assign M1[207] = layer2_N207_lut[layer2_N207_wire];

wire [3:0] layer2_N208_wire = {M0[88], M0[40], M0[87], M0[28]};
wire [15:0] layer2_N208_lut = 16'hBBAB;
assign M1[208] = layer2_N208_lut[layer2_N208_wire];

wire [3:0] layer2_N209_wire = {M0[88], M0[83], M0[87], M0[40]};
wire [15:0] layer2_N209_lut = 16'h888A;
assign M1[209] = layer2_N209_lut[layer2_N209_wire];

wire [3:0] layer2_N210_wire = {M0[13], M0[39], M0[154], M0[2]};
wire [15:0] layer2_N210_lut = 16'hF4FE;
assign M1[210] = layer2_N210_lut[layer2_N210_wire];

wire [3:0] layer2_N211_wire = {M0[84], M0[67], M0[132], M0[154]};
wire [15:0] layer2_N211_lut = 16'h80F4;
assign M1[211] = layer2_N211_lut[layer2_N211_wire];

wire [3:0] layer2_N212_wire = {M0[97], M0[95], M0[70], M0[46]};
wire [15:0] layer2_N212_lut = 16'h2E22;
assign M1[212] = layer2_N212_lut[layer2_N212_wire];

wire [3:0] layer2_N213_wire = {M0[88], M0[132], M0[51], M0[123]};
wire [15:0] layer2_N213_lut = 16'h00FA;
assign M1[213] = layer2_N213_lut[layer2_N213_wire];

wire [3:0] layer2_N214_wire = {M0[13], M0[51], M0[132], M0[72]};
wire [15:0] layer2_N214_lut = 16'h5544;
assign M1[214] = layer2_N214_lut[layer2_N214_wire];

wire [3:0] layer2_N215_wire = {M0[51], M0[132], M0[46], M0[39]};
wire [15:0] layer2_N215_lut = 16'h5051;
assign M1[215] = layer2_N215_lut[layer2_N215_wire];

wire [3:0] layer2_N216_wire = {M0[65], M0[159], M0[61], M0[122]};
wire [15:0] layer2_N216_lut = 16'h3033;
assign M1[216] = layer2_N216_lut[layer2_N216_wire];

wire [3:0] layer2_N217_wire = {M0[55], M0[143], M0[71], M0[118]};
wire [15:0] layer2_N217_lut = 16'h54F4;
assign M1[217] = layer2_N217_lut[layer2_N217_wire];

wire [3:0] layer2_N218_wire = {M0[142], M0[72], M0[49], M0[115]};
wire [15:0] layer2_N218_lut = 16'hFCFD;
assign M1[218] = layer2_N218_lut[layer2_N218_wire];

wire [3:0] layer2_N219_wire = {M0[146], M0[119], M0[49], M0[39]};
wire [15:0] layer2_N219_lut = 16'hD500;
assign M1[219] = layer2_N219_lut[layer2_N219_wire];

wire [3:0] layer2_N220_wire = {M0[123], M0[11], M0[51], M0[56]};
wire [15:0] layer2_N220_lut = 16'hAF8F;
assign M1[220] = layer2_N220_lut[layer2_N220_wire];

wire [3:0] layer2_N221_wire = {M0[95], M0[51], M0[124], M0[46]};
wire [15:0] layer2_N221_lut = 16'h3713;
assign M1[221] = layer2_N221_lut[layer2_N221_wire];

wire [3:0] layer2_N222_wire = {M0[79], M0[43], M0[13], M0[103]};
wire [15:0] layer2_N222_lut = 16'h00DC;
assign M1[222] = layer2_N222_lut[layer2_N222_wire];

wire [3:0] layer2_N223_wire = {M0[68], M0[120], M0[55], M0[84]};
wire [15:0] layer2_N223_lut = 16'h0F00;
assign M1[223] = layer2_N223_lut[layer2_N223_wire];

wire [3:0] layer2_N224_wire = {M0[86], M0[135], M0[88], M0[122]};
wire [15:0] layer2_N224_lut = 16'hFF44;
assign M1[224] = layer2_N224_lut[layer2_N224_wire];

wire [3:0] layer2_N225_wire = {M0[49], M0[132], M0[157], M0[31]};
wire [15:0] layer2_N225_lut = 16'h1010;
assign M1[225] = layer2_N225_lut[layer2_N225_wire];

wire [3:0] layer2_N226_wire = {M0[2], M0[92], M0[49], M0[31]};
wire [15:0] layer2_N226_lut = 16'h3030;
assign M1[226] = layer2_N226_lut[layer2_N226_wire];

wire [3:0] layer2_N227_wire = {M0[129], M0[87], M0[64], M0[88]};
wire [15:0] layer2_N227_lut = 16'hCCCF;
assign M1[227] = layer2_N227_lut[layer2_N227_wire];

wire [3:0] layer2_N228_wire = {M0[49], M0[40], M0[132], M0[57]};
wire [15:0] layer2_N228_lut = 16'h88E8;
assign M1[228] = layer2_N228_lut[layer2_N228_wire];

wire [3:0] layer2_N229_wire = {M0[56], M0[154], M0[49], M0[137]};
wire [15:0] layer2_N229_lut = 16'h01AF;
assign M1[229] = layer2_N229_lut[layer2_N229_wire];

wire [3:0] layer2_N230_wire = {M0[144], M0[105], M0[111], M0[11]};
wire [15:0] layer2_N230_lut = 16'h4464;
assign M1[230] = layer2_N230_lut[layer2_N230_wire];

wire [3:0] layer2_N231_wire = {M0[23], M0[56], M0[145], M0[31]};
wire [15:0] layer2_N231_lut = 16'hDF4C;
assign M1[231] = layer2_N231_lut[layer2_N231_wire];

wire [3:0] layer2_N232_wire = {M0[145], M0[122], M0[147], M0[55]};
wire [15:0] layer2_N232_lut = 16'hF711;
assign M1[232] = layer2_N232_lut[layer2_N232_wire];

wire [3:0] layer2_N233_wire = {M0[13], M0[128], M0[71], M0[87]};
wire [15:0] layer2_N233_lut = 16'hAE8C;
assign M1[233] = layer2_N233_lut[layer2_N233_wire];

wire [3:0] layer2_N234_wire = {M0[13], M0[136], M0[46], M0[2]};
wire [15:0] layer2_N234_lut = 16'hF773;
assign M1[234] = layer2_N234_lut[layer2_N234_wire];

wire [3:0] layer2_N235_wire = {M0[81], M0[88], M0[67], M0[31]};
wire [15:0] layer2_N235_lut = 16'hDD00;
assign M1[235] = layer2_N235_lut[layer2_N235_wire];

wire [3:0] layer2_N236_wire = {M0[62], M0[128], M0[103], M0[130]};
wire [15:0] layer2_N236_lut = 16'hACAE;
assign M1[236] = layer2_N236_lut[layer2_N236_wire];

wire [3:0] layer2_N237_wire = {M0[11], M0[2], M0[13], M0[92]};
wire [15:0] layer2_N237_lut = 16'h1055;
assign M1[237] = layer2_N237_lut[layer2_N237_wire];

wire [3:0] layer2_N238_wire = {M0[88], M0[158], M0[124], M0[97]};
wire [15:0] layer2_N238_lut = 16'hEEE0;
assign M1[238] = layer2_N238_lut[layer2_N238_wire];

wire [3:0] layer2_N239_wire = {M0[13], M0[36], M0[62], M0[128]};
wire [15:0] layer2_N239_lut = 16'h30F2;
assign M1[239] = layer2_N239_lut[layer2_N239_wire];

wire [3:0] layer2_N240_wire = {M0[154], M0[152], M0[67], M0[56]};
wire [15:0] layer2_N240_lut = 16'hB3BA;
assign M1[240] = layer2_N240_lut[layer2_N240_wire];

wire [3:0] layer2_N241_wire = {M0[79], M0[97], M0[40], M0[38]};
wire [15:0] layer2_N241_lut = 16'h0CCC;
assign M1[241] = layer2_N241_lut[layer2_N241_wire];

wire [3:0] layer2_N242_wire = {M0[154], M0[36], M0[38], M0[142]};
wire [15:0] layer2_N242_lut = 16'hF510;
assign M1[242] = layer2_N242_lut[layer2_N242_wire];

wire [3:0] layer2_N243_wire = {M0[79], M0[38], M0[97], M0[149]};
wire [15:0] layer2_N243_lut = 16'h00BB;
assign M1[243] = layer2_N243_lut[layer2_N243_wire];

wire [3:0] layer2_N244_wire = {M0[95], M0[131], M0[2], M0[11]};
wire [15:0] layer2_N244_lut = 16'h52D3;
assign M1[244] = layer2_N244_lut[layer2_N244_wire];

wire [3:0] layer2_N245_wire = {M0[84], M0[45], M0[56], M0[62]};
wire [15:0] layer2_N245_lut = 16'h5F5D;
assign M1[245] = layer2_N245_lut[layer2_N245_wire];

wire [3:0] layer2_N246_wire = {M0[36], M0[44], M0[79], M0[51]};
wire [15:0] layer2_N246_lut = 16'hF0E0;
assign M1[246] = layer2_N246_lut[layer2_N246_wire];

wire [3:0] layer2_N247_wire = {M0[13], M0[2], M0[18], M0[46]};
wire [15:0] layer2_N247_lut = 16'h5F00;
assign M1[247] = layer2_N247_lut[layer2_N247_wire];

wire [3:0] layer2_N248_wire = {M0[87], M0[88], M0[100], M0[129]};
wire [15:0] layer2_N248_lut = 16'h3377;
assign M1[248] = layer2_N248_lut[layer2_N248_wire];

wire [3:0] layer2_N249_wire = {M0[88], M0[94], M0[97], M0[124]};
wire [15:0] layer2_N249_lut = 16'h0133;
assign M1[249] = layer2_N249_lut[layer2_N249_wire];

wire [3:0] layer2_N250_wire = {M0[76], M0[88], M0[141], M0[108]};
wire [15:0] layer2_N250_lut = 16'h40C5;
assign M1[250] = layer2_N250_lut[layer2_N250_wire];

wire [3:0] layer2_N251_wire = {M0[84], M0[129], M0[46], M0[13]};
wire [15:0] layer2_N251_lut = 16'hDFDF;
assign M1[251] = layer2_N251_lut[layer2_N251_wire];

wire [3:0] layer2_N252_wire = {M0[124], M0[108], M0[97], M0[67]};
wire [15:0] layer2_N252_lut = 16'hFDD4;
assign M1[252] = layer2_N252_lut[layer2_N252_wire];

wire [3:0] layer2_N253_wire = {M0[21], M0[1], M0[12], M0[106]};
wire [15:0] layer2_N253_lut = 16'h013F;
assign M1[253] = layer2_N253_lut[layer2_N253_wire];

wire [3:0] layer2_N254_wire = {M0[42], M0[80], M0[1], M0[113]};
wire [15:0] layer2_N254_lut = 16'h2353;
assign M1[254] = layer2_N254_lut[layer2_N254_wire];

wire [3:0] layer2_N255_wire = {M0[106], M0[117], M0[67], M0[63]};
wire [15:0] layer2_N255_lut = 16'hF1BB;
assign M1[255] = layer2_N255_lut[layer2_N255_wire];

wire [3:0] layer2_N256_wire = {M0[152], M0[17], M0[63], M0[4]};
wire [15:0] layer2_N256_lut = 16'h0A7F;
assign M1[256] = layer2_N256_lut[layer2_N256_wire];

wire [3:0] layer2_N257_wire = {M0[126], M0[121], M0[6], M0[101]};
wire [15:0] layer2_N257_lut = 16'h00DD;
assign M1[257] = layer2_N257_lut[layer2_N257_wire];

wire [3:0] layer2_N258_wire = {M0[151], M0[121], M0[6], M0[22]};
wire [15:0] layer2_N258_lut = 16'h00EF;
assign M1[258] = layer2_N258_lut[layer2_N258_wire];

wire [3:0] layer2_N259_wire = {M0[21], M0[0], M0[127], M0[90]};
wire [15:0] layer2_N259_lut = 16'h022F;
assign M1[259] = layer2_N259_lut[layer2_N259_wire];

wire [3:0] layer2_N260_wire = {M0[80], M0[117], M0[127], M0[33]};
wire [15:0] layer2_N260_lut = 16'hAF22;
assign M1[260] = layer2_N260_lut[layer2_N260_wire];

wire [3:0] layer2_N261_wire = {M0[109], M0[117], M0[56], M0[76]};
wire [15:0] layer2_N261_lut = 16'hEEEE;
assign M1[261] = layer2_N261_lut[layer2_N261_wire];

wire [3:0] layer2_N262_wire = {M0[159], M0[19], M0[151], M0[125]};
wire [15:0] layer2_N262_lut = 16'h5715;
assign M1[262] = layer2_N262_lut[layer2_N262_wire];

wire [3:0] layer2_N263_wire = {M0[4], M0[30], M0[49], M0[131]};
wire [15:0] layer2_N263_lut = 16'h0ABA;
assign M1[263] = layer2_N263_lut[layer2_N263_wire];

wire [3:0] layer2_N264_wire = {M0[32], M0[55], M0[87], M0[28]};
wire [15:0] layer2_N264_lut = 16'h1313;
assign M1[264] = layer2_N264_lut[layer2_N264_wire];

wire [3:0] layer2_N265_wire = {M0[144], M0[37], M0[41], M0[107]};
wire [15:0] layer2_N265_lut = 16'h04E4;
assign M1[265] = layer2_N265_lut[layer2_N265_wire];

wire [3:0] layer2_N266_wire = {M0[20], M0[74], M0[55], M0[140]};
wire [15:0] layer2_N266_lut = 16'hFCCC;
assign M1[266] = layer2_N266_lut[layer2_N266_wire];

wire [3:0] layer2_N267_wire = {M0[90], M0[138], M0[114], M0[45]};
wire [15:0] layer2_N267_lut = 16'h7313;
assign M1[267] = layer2_N267_lut[layer2_N267_wire];

wire [3:0] layer2_N268_wire = {M0[103], M0[92], M0[67], M0[6]};
wire [15:0] layer2_N268_lut = 16'h1D1C;
assign M1[268] = layer2_N268_lut[layer2_N268_wire];

wire [3:0] layer2_N269_wire = {M0[72], M0[149], M0[58], M0[50]};
wire [15:0] layer2_N269_lut = 16'hFABA;
assign M1[269] = layer2_N269_lut[layer2_N269_wire];

wire [3:0] layer2_N270_wire = {M0[103], M0[115], M0[55], M0[45]};
wire [15:0] layer2_N270_lut = 16'h3310;
assign M1[270] = layer2_N270_lut[layer2_N270_wire];

wire [3:0] layer2_N271_wire = {M0[152], M0[115], M0[19], M0[121]};
wire [15:0] layer2_N271_lut = 16'hCCFF;
assign M1[271] = layer2_N271_lut[layer2_N271_wire];

wire [3:0] layer2_N272_wire = {M0[115], M0[130], M0[56], M0[85]};
wire [15:0] layer2_N272_lut = 16'h0D0D;
assign M1[272] = layer2_N272_lut[layer2_N272_wire];

wire [3:0] layer2_N273_wire = {M0[63], M0[111], M0[128], M0[132]};
wire [15:0] layer2_N273_lut = 16'h7233;
assign M1[273] = layer2_N273_lut[layer2_N273_wire];

wire [3:0] layer2_N274_wire = {M0[106], M0[9], M0[47], M0[7]};
wire [15:0] layer2_N274_lut = 16'hF7C0;
assign M1[274] = layer2_N274_lut[layer2_N274_wire];

wire [3:0] layer2_N275_wire = {M0[128], M0[115], M0[111], M0[156]};
wire [15:0] layer2_N275_lut = 16'h5511;
assign M1[275] = layer2_N275_lut[layer2_N275_wire];

wire [3:0] layer2_N276_wire = {M0[128], M0[115], M0[111], M0[149]};
wire [15:0] layer2_N276_lut = 16'h80AA;
assign M1[276] = layer2_N276_lut[layer2_N276_wire];

wire [3:0] layer2_N277_wire = {M0[96], M0[105], M0[111], M0[6]};
wire [15:0] layer2_N277_lut = 16'h37FF;
assign M1[277] = layer2_N277_lut[layer2_N277_wire];

wire [3:0] layer2_N278_wire = {M0[158], M0[6], M0[154], M0[47]};
wire [15:0] layer2_N278_lut = 16'hE8FE;
assign M1[278] = layer2_N278_lut[layer2_N278_wire];

wire [3:0] layer2_N279_wire = {M0[35], M0[152], M0[47], M0[90]};
wire [15:0] layer2_N279_lut = 16'h0505;
assign M1[279] = layer2_N279_lut[layer2_N279_wire];

wire [3:0] layer2_N280_wire = {M0[105], M0[55], M0[12], M0[159]};
wire [15:0] layer2_N280_lut = 16'h3F3F;
assign M1[280] = layer2_N280_lut[layer2_N280_wire];

wire [3:0] layer2_N281_wire = {M0[20], M0[151], M0[129], M0[24]};
wire [15:0] layer2_N281_lut = 16'h1333;
assign M1[281] = layer2_N281_lut[layer2_N281_wire];

wire [3:0] layer2_N282_wire = {M0[149], M0[147], M0[116], M0[8]};
wire [15:0] layer2_N282_lut = 16'h8C8C;
assign M1[282] = layer2_N282_lut[layer2_N282_wire];

wire [3:0] layer2_N283_wire = {M0[7], M0[49], M0[55], M0[101]};
wire [15:0] layer2_N283_lut = 16'h1717;
assign M1[283] = layer2_N283_lut[layer2_N283_wire];

wire [3:0] layer2_N284_wire = {M0[154], M0[6], M0[11], M0[58]};
wire [15:0] layer2_N284_lut = 16'hCC4C;
assign M1[284] = layer2_N284_lut[layer2_N284_wire];

wire [3:0] layer2_N285_wire = {M0[90], M0[157], M0[105], M0[111]};
wire [15:0] layer2_N285_lut = 16'h0A0A;
assign M1[285] = layer2_N285_lut[layer2_N285_wire];

wire [3:0] layer2_N286_wire = {M0[111], M0[149], M0[128], M0[151]};
wire [15:0] layer2_N286_lut = 16'h454D;
assign M1[286] = layer2_N286_lut[layer2_N286_wire];

wire [3:0] layer2_N287_wire = {M0[76], M0[62], M0[36], M0[90]};
wire [15:0] layer2_N287_lut = 16'h33F7;
assign M1[287] = layer2_N287_lut[layer2_N287_wire];

wire [3:0] layer2_N288_wire = {M0[49], M0[22], M0[126], M0[21]};
wire [15:0] layer2_N288_lut = 16'h1171;
assign M1[288] = layer2_N288_lut[layer2_N288_wire];

wire [3:0] layer2_N289_wire = {M0[22], M0[128], M0[62], M0[94]};
wire [15:0] layer2_N289_lut = 16'hAEAF;
assign M1[289] = layer2_N289_lut[layer2_N289_wire];

wire [3:0] layer2_N290_wire = {M0[148], M0[127], M0[151], M0[107]};
wire [15:0] layer2_N290_lut = 16'h0705;
assign M1[290] = layer2_N290_lut[layer2_N290_wire];

wire [3:0] layer2_N291_wire = {M0[142], M0[158], M0[106], M0[47]};
wire [15:0] layer2_N291_lut = 16'h00EC;
assign M1[291] = layer2_N291_lut[layer2_N291_wire];

wire [3:0] layer2_N292_wire = {M0[151], M0[154], M0[123], M0[158]};
wire [15:0] layer2_N292_lut = 16'h44CC;
assign M1[292] = layer2_N292_lut[layer2_N292_wire];

wire [3:0] layer2_N293_wire = {M0[22], M0[44], M0[115], M0[154]};
wire [15:0] layer2_N293_lut = 16'hF4F0;
assign M1[293] = layer2_N293_lut[layer2_N293_wire];

wire [3:0] layer2_N294_wire = {M0[44], M0[96], M0[74], M0[133]};
wire [15:0] layer2_N294_lut = 16'hCACE;
assign M1[294] = layer2_N294_lut[layer2_N294_wire];

wire [3:0] layer2_N295_wire = {M0[49], M0[121], M0[123], M0[76]};
wire [15:0] layer2_N295_lut = 16'h80C8;
assign M1[295] = layer2_N295_lut[layer2_N295_wire];

wire [3:0] layer2_N296_wire = {M0[141], M0[48], M0[100], M0[82]};
wire [15:0] layer2_N296_lut = 16'hFF4D;
assign M1[296] = layer2_N296_lut[layer2_N296_wire];

wire [3:0] layer2_N297_wire = {M0[8], M0[112], M0[37], M0[145]};
wire [15:0] layer2_N297_lut = 16'h1110;
assign M1[297] = layer2_N297_lut[layer2_N297_wire];

wire [3:0] layer2_N298_wire = {M0[133], M0[81], M0[42], M0[124]};
wire [15:0] layer2_N298_lut = 16'hDFCD;
assign M1[298] = layer2_N298_lut[layer2_N298_wire];

wire [3:0] layer2_N299_wire = {M0[12], M0[6], M0[106], M0[107]};
wire [15:0] layer2_N299_lut = 16'h44E4;
assign M1[299] = layer2_N299_lut[layer2_N299_wire];

wire [3:0] layer2_N300_wire = {M0[63], M0[151], M0[112], M0[51]};
wire [15:0] layer2_N300_lut = 16'hEAAA;
assign M1[300] = layer2_N300_lut[layer2_N300_wire];

wire [3:0] layer2_N301_wire = {M0[135], M0[126], M0[101], M0[76]};
wire [15:0] layer2_N301_lut = 16'hF5F5;
assign M1[301] = layer2_N301_lut[layer2_N301_wire];

wire [3:0] layer2_N302_wire = {M0[76], M0[151], M0[63], M0[71]};
wire [15:0] layer2_N302_lut = 16'hEF04;
assign M1[302] = layer2_N302_lut[layer2_N302_wire];

wire [3:0] layer2_N303_wire = {M0[76], M0[151], M0[3], M0[126]};
wire [15:0] layer2_N303_lut = 16'h1108;
assign M1[303] = layer2_N303_lut[layer2_N303_wire];

wire [3:0] layer2_N304_wire = {M0[67], M0[142], M0[81], M0[69]};
wire [15:0] layer2_N304_lut = 16'hF171;
assign M1[304] = layer2_N304_lut[layer2_N304_wire];

wire [3:0] layer2_N305_wire = {M0[67], M0[45], M0[21], M0[12]};
wire [15:0] layer2_N305_lut = 16'h2203;
assign M1[305] = layer2_N305_lut[layer2_N305_wire];

wire [3:0] layer2_N306_wire = {M0[105], M0[67], M0[151], M0[111]};
wire [15:0] layer2_N306_lut = 16'hEC8E;
assign M1[306] = layer2_N306_lut[layer2_N306_wire];

wire [3:0] layer2_N307_wire = {M0[128], M0[111], M0[115], M0[4]};
wire [15:0] layer2_N307_lut = 16'h5511;
assign M1[307] = layer2_N307_lut[layer2_N307_wire];

wire [3:0] layer2_N308_wire = {M0[128], M0[38], M0[80], M0[10]};
wire [15:0] layer2_N308_lut = 16'h5504;
assign M1[308] = layer2_N308_lut[layer2_N308_wire];

wire [3:0] layer2_N309_wire = {M0[80], M0[62], M0[128], M0[54]};
wire [15:0] layer2_N309_lut = 16'h0F8C;
assign M1[309] = layer2_N309_lut[layer2_N309_wire];

wire [3:0] layer2_N310_wire = {M0[69], M0[98], M0[103], M0[121]};
wire [15:0] layer2_N310_lut = 16'h170F;
assign M1[310] = layer2_N310_lut[layer2_N310_wire];

wire [3:0] layer2_N311_wire = {M0[154], M0[148], M0[50], M0[132]};
wire [15:0] layer2_N311_lut = 16'h5DD5;
assign M1[311] = layer2_N311_lut[layer2_N311_wire];

wire [3:0] layer2_N312_wire = {M0[133], M0[89], M0[115], M0[101]};
wire [15:0] layer2_N312_lut = 16'h0F1F;
assign M1[312] = layer2_N312_lut[layer2_N312_wire];

wire [3:0] layer2_N313_wire = {M0[16], M0[149], M0[63], M0[87]};
wire [15:0] layer2_N313_lut = 16'h0500;
assign M1[313] = layer2_N313_lut[layer2_N313_wire];

wire [3:0] layer2_N314_wire = {M0[9], M0[151], M0[128], M0[50]};
wire [15:0] layer2_N314_lut = 16'hCF00;
assign M1[314] = layer2_N314_lut[layer2_N314_wire];

wire [3:0] layer2_N315_wire = {M0[121], M0[71], M0[35], M0[102]};
wire [15:0] layer2_N315_lut = 16'hD554;
assign M1[315] = layer2_N315_lut[layer2_N315_wire];

wire [3:0] layer2_N316_wire = {M0[114], M0[144], M0[111], M0[145]};
wire [15:0] layer2_N316_lut = 16'h1555;
assign M1[316] = layer2_N316_lut[layer2_N316_wire];

wire [3:0] layer2_N317_wire = {M0[115], M0[114], M0[61], M0[4]};
wire [15:0] layer2_N317_lut = 16'hCDDD;
assign M1[317] = layer2_N317_lut[layer2_N317_wire];

wire [3:0] layer2_N318_wire = {M0[68], M0[74], M0[114], M0[0]};
wire [15:0] layer2_N318_lut = 16'h1557;
assign M1[318] = layer2_N318_lut[layer2_N318_wire];

wire [3:0] layer2_N319_wire = {M0[114], M0[111], M0[90], M0[128]};
wire [15:0] layer2_N319_lut = 16'h88EE;
assign M1[319] = layer2_N319_lut[layer2_N319_wire];

wire [3:0] layer2_N320_wire = {M0[86], M0[156], M0[43], M0[117]};
wire [15:0] layer2_N320_lut = 16'h3222;
assign M1[320] = layer2_N320_lut[layer2_N320_wire];

wire [3:0] layer2_N321_wire = {M0[134], M0[157], M0[30], M0[156]};
wire [15:0] layer2_N321_lut = 16'h22BA;
assign M1[321] = layer2_N321_lut[layer2_N321_wire];

wire [3:0] layer2_N322_wire = {M0[84], M0[19], M0[9], M0[30]};
wire [15:0] layer2_N322_lut = 16'h1153;
assign M1[322] = layer2_N322_lut[layer2_N322_wire];

wire [3:0] layer2_N323_wire = {M0[150], M0[82], M0[97], M0[122]};
wire [15:0] layer2_N323_lut = 16'hCCCF;
assign M1[323] = layer2_N323_lut[layer2_N323_wire];

wire [3:0] layer2_N324_wire = {M0[81], M0[17], M0[54], M0[31]};
wire [15:0] layer2_N324_lut = 16'h0117;
assign M1[324] = layer2_N324_lut[layer2_N324_wire];

wire [3:0] layer2_N325_wire = {M0[147], M0[99], M0[79], M0[56]};
wire [15:0] layer2_N325_lut = 16'hEEEC;
assign M1[325] = layer2_N325_lut[layer2_N325_wire];

wire [3:0] layer2_N326_wire = {M0[34], M0[157], M0[0], M0[110]};
wire [15:0] layer2_N326_lut = 16'h7501;
assign M1[326] = layer2_N326_lut[layer2_N326_wire];

wire [3:0] layer2_N327_wire = {M0[58], M0[151], M0[17], M0[113]};
wire [15:0] layer2_N327_lut = 16'h7410;
assign M1[327] = layer2_N327_lut[layer2_N327_wire];

wire [3:0] layer2_N328_wire = {M0[73], M0[83], M0[105], M0[39]};
wire [15:0] layer2_N328_lut = 16'h00FF;
assign M1[328] = layer2_N328_lut[layer2_N328_wire];

wire [3:0] layer2_N329_wire = {M0[1], M0[117], M0[73], M0[12]};
wire [15:0] layer2_N329_lut = 16'h1070;
assign M1[329] = layer2_N329_lut[layer2_N329_wire];

wire [3:0] layer2_N330_wire = {M0[12], M0[153], M0[72], M0[117]};
wire [15:0] layer2_N330_lut = 16'hF575;
assign M1[330] = layer2_N330_lut[layer2_N330_wire];

wire [3:0] layer2_N331_wire = {M0[0], M0[35], M0[117], M0[83]};
wire [15:0] layer2_N331_lut = 16'hCCCD;
assign M1[331] = layer2_N331_lut[layer2_N331_wire];

wire [3:0] layer2_N332_wire = {M0[72], M0[1], M0[83], M0[0]};
wire [15:0] layer2_N332_lut = 16'h5700;
assign M1[332] = layer2_N332_lut[layer2_N332_wire];

wire [3:0] layer2_N333_wire = {M0[42], M0[118], M0[61], M0[96]};
wire [15:0] layer2_N333_lut = 16'hAAAA;
assign M1[333] = layer2_N333_lut[layer2_N333_wire];

wire [3:0] layer2_N334_wire = {M0[60], M0[118], M0[14], M0[63]};
wire [15:0] layer2_N334_lut = 16'h8800;
assign M1[334] = layer2_N334_lut[layer2_N334_wire];

wire [3:0] layer2_N335_wire = {M0[42], M0[159], M0[75], M0[57]};
wire [15:0] layer2_N335_lut = 16'h32B0;
assign M1[335] = layer2_N335_lut[layer2_N335_wire];

wire [3:0] layer2_N336_wire = {M0[126], M0[142], M0[37], M0[122]};
wire [15:0] layer2_N336_lut = 16'h7272;
assign M1[336] = layer2_N336_lut[layer2_N336_wire];

wire [3:0] layer2_N337_wire = {M0[64], M0[20], M0[132], M0[7]};
wire [15:0] layer2_N337_lut = 16'hD1FF;
assign M1[337] = layer2_N337_lut[layer2_N337_wire];

wire [3:0] layer2_N338_wire = {M0[146], M0[37], M0[118], M0[115]};
wire [15:0] layer2_N338_lut = 16'h00FF;
assign M1[338] = layer2_N338_lut[layer2_N338_wire];

wire [3:0] layer2_N339_wire = {M0[87], M0[19], M0[126], M0[111]};
wire [15:0] layer2_N339_lut = 16'h00F5;
assign M1[339] = layer2_N339_lut[layer2_N339_wire];

wire [3:0] layer2_N340_wire = {M0[50], M0[12], M0[106], M0[105]};
wire [15:0] layer2_N340_lut = 16'h00FE;
assign M1[340] = layer2_N340_lut[layer2_N340_wire];

wire [3:0] layer2_N341_wire = {M0[128], M0[105], M0[117], M0[28]};
wire [15:0] layer2_N341_lut = 16'h33BB;
assign M1[341] = layer2_N341_lut[layer2_N341_wire];

wire [3:0] layer2_N342_wire = {M0[128], M0[115], M0[109], M0[63]};
wire [15:0] layer2_N342_lut = 16'hF8FA;
assign M1[342] = layer2_N342_lut[layer2_N342_wire];

wire [3:0] layer2_N343_wire = {M0[56], M0[76], M0[15], M0[99]};
wire [15:0] layer2_N343_lut = 16'h8F8E;
assign M1[343] = layer2_N343_lut[layer2_N343_wire];

wire [3:0] layer2_N344_wire = {M0[115], M0[118], M0[7], M0[20]};
wire [15:0] layer2_N344_lut = 16'h1357;
assign M1[344] = layer2_N344_lut[layer2_N344_wire];

wire [3:0] layer2_N345_wire = {M0[118], M0[1], M0[39], M0[3]};
wire [15:0] layer2_N345_lut = 16'hAAAA;
assign M1[345] = layer2_N345_lut[layer2_N345_wire];

wire [3:0] layer2_N346_wire = {M0[73], M0[14], M0[142], M0[115]};
wire [15:0] layer2_N346_lut = 16'hC0F0;
assign M1[346] = layer2_N346_lut[layer2_N346_wire];

wire [3:0] layer2_N347_wire = {M0[122], M0[26], M0[118], M0[60]};
wire [15:0] layer2_N347_lut = 16'hA0A8;
assign M1[347] = layer2_N347_lut[layer2_N347_wire];

wire [3:0] layer2_N348_wire = {M0[115], M0[67], M0[118], M0[31]};
wire [15:0] layer2_N348_lut = 16'hAFAF;
assign M1[348] = layer2_N348_lut[layer2_N348_wire];

wire [3:0] layer2_N349_wire = {M0[38], M0[105], M0[115], M0[80]};
wire [15:0] layer2_N349_lut = 16'h00F0;
assign M1[349] = layer2_N349_lut[layer2_N349_wire];

wire [3:0] layer2_N350_wire = {M0[12], M0[159], M0[157], M0[50]};
wire [15:0] layer2_N350_lut = 16'h030B;
assign M1[350] = layer2_N350_lut[layer2_N350_wire];

wire [3:0] layer2_N351_wire = {M0[70], M0[8], M0[118], M0[115]};
wire [15:0] layer2_N351_lut = 16'h007F;
assign M1[351] = layer2_N351_lut[layer2_N351_wire];

wire [3:0] layer2_N352_wire = {M0[118], M0[1], M0[67], M0[81]};
wire [15:0] layer2_N352_lut = 16'hB273;
assign M1[352] = layer2_N352_lut[layer2_N352_wire];

wire [3:0] layer2_N353_wire = {M0[68], M0[1], M0[0], M0[111]};
wire [15:0] layer2_N353_lut = 16'h2323;
assign M1[353] = layer2_N353_lut[layer2_N353_wire];

wire [3:0] layer2_N354_wire = {M0[33], M0[3], M0[1], M0[42]};
wire [15:0] layer2_N354_lut = 16'h60F0;
assign M1[354] = layer2_N354_lut[layer2_N354_wire];

wire [3:0] layer2_N355_wire = {M0[18], M0[67], M0[14], M0[37]};
wire [15:0] layer2_N355_lut = 16'h3727;
assign M1[355] = layer2_N355_lut[layer2_N355_wire];

wire [3:0] layer2_N356_wire = {M0[38], M0[132], M0[39], M0[84]};
wire [15:0] layer2_N356_lut = 16'h1500;
assign M1[356] = layer2_N356_lut[layer2_N356_wire];

wire [3:0] layer2_N357_wire = {M0[150], M0[1], M0[61], M0[132]};
wire [15:0] layer2_N357_lut = 16'h3305;
assign M1[357] = layer2_N357_lut[layer2_N357_wire];

wire [3:0] layer2_N358_wire = {M0[39], M0[72], M0[46], M0[4]};
wire [15:0] layer2_N358_lut = 16'h0F8F;
assign M1[358] = layer2_N358_lut[layer2_N358_wire];

wire [3:0] layer2_N359_wire = {M0[7], M0[14], M0[84], M0[81]};
wire [15:0] layer2_N359_lut = 16'hCFDF;
assign M1[359] = layer2_N359_lut[layer2_N359_wire];

wire [3:0] layer2_N360_wire = {M0[118], M0[84], M0[7], M0[33]};
wire [15:0] layer2_N360_lut = 16'hF1F0;
assign M1[360] = layer2_N360_lut[layer2_N360_wire];

wire [3:0] layer2_N361_wire = {M0[39], M0[33], M0[55], M0[95]};
wire [15:0] layer2_N361_lut = 16'h4450;
assign M1[361] = layer2_N361_lut[layer2_N361_wire];

wire [3:0] layer2_N362_wire = {M0[33], M0[61], M0[122], M0[82]};
wire [15:0] layer2_N362_lut = 16'hAAAB;
assign M1[362] = layer2_N362_lut[layer2_N362_wire];

wire [3:0] layer2_N363_wire = {M0[7], M0[81], M0[42], M0[118]};
wire [15:0] layer2_N363_lut = 16'hEA40;
assign M1[363] = layer2_N363_lut[layer2_N363_wire];

wire [3:0] layer2_N364_wire = {M0[96], M0[36], M0[20], M0[139]};
wire [15:0] layer2_N364_lut = 16'hEAFF;
assign M1[364] = layer2_N364_lut[layer2_N364_wire];

wire [3:0] layer2_N365_wire = {M0[83], M0[11], M0[9], M0[122]};
wire [15:0] layer2_N365_lut = 16'hCCCC;
assign M1[365] = layer2_N365_lut[layer2_N365_wire];

wire [3:0] layer2_N366_wire = {M0[84], M0[24], M0[127], M0[56]};
wire [15:0] layer2_N366_lut = 16'h050F;
assign M1[366] = layer2_N366_lut[layer2_N366_wire];

wire [3:0] layer2_N367_wire = {M0[42], M0[128], M0[44], M0[0]};
wire [15:0] layer2_N367_lut = 16'h51D1;
assign M1[367] = layer2_N367_lut[layer2_N367_wire];

wire [3:0] layer2_N368_wire = {M0[56], M0[47], M0[41], M0[38]};
wire [15:0] layer2_N368_lut = 16'hF777;
assign M1[368] = layer2_N368_lut[layer2_N368_wire];

wire [3:0] layer2_N369_wire = {M0[56], M0[81], M0[7], M0[16]};
wire [15:0] layer2_N369_lut = 16'hADAC;
assign M1[369] = layer2_N369_lut[layer2_N369_wire];

wire [3:0] layer2_N370_wire = {M0[16], M0[56], M0[85], M0[156]};
wire [15:0] layer2_N370_lut = 16'hABEF;
assign M1[370] = layer2_N370_lut[layer2_N370_wire];

wire [3:0] layer2_N371_wire = {M0[131], M0[99], M0[59], M0[117]};
wire [15:0] layer2_N371_lut = 16'hDCD4;
assign M1[371] = layer2_N371_lut[layer2_N371_wire];

wire [3:0] layer2_N372_wire = {M0[0], M0[61], M0[81], M0[118]};
wire [15:0] layer2_N372_lut = 16'hFDF0;
assign M1[372] = layer2_N372_lut[layer2_N372_wire];

wire [3:0] layer2_N373_wire = {M0[118], M0[156], M0[22], M0[119]};
wire [15:0] layer2_N373_lut = 16'hE8B2;
assign M1[373] = layer2_N373_lut[layer2_N373_wire];

wire [3:0] layer2_N374_wire = {M0[118], M0[81], M0[1], M0[33]};
wire [15:0] layer2_N374_lut = 16'h3310;
assign M1[374] = layer2_N374_lut[layer2_N374_wire];

wire [3:0] layer2_N375_wire = {M0[60], M0[97], M0[15], M0[137]};
wire [15:0] layer2_N375_lut = 16'h0300;
assign M1[375] = layer2_N375_lut[layer2_N375_wire];

wire [3:0] layer2_N376_wire = {M0[4], M0[64], M0[33], M0[2]};
wire [15:0] layer2_N376_lut = 16'h30FC;
assign M1[376] = layer2_N376_lut[layer2_N376_wire];

wire [3:0] layer2_N377_wire = {M0[2], M0[81], M0[65], M0[24]};
wire [15:0] layer2_N377_lut = 16'hABAA;
assign M1[377] = layer2_N377_lut[layer2_N377_wire];

wire [3:0] layer2_N378_wire = {M0[81], M0[56], M0[122], M0[9]};
wire [15:0] layer2_N378_lut = 16'hAAE2;
assign M1[378] = layer2_N378_lut[layer2_N378_wire];

wire [3:0] layer2_N379_wire = {M0[4], M0[81], M0[152], M0[132]};
wire [15:0] layer2_N379_lut = 16'hFBFB;
assign M1[379] = layer2_N379_lut[layer2_N379_wire];

wire [3:0] layer2_N380_wire = {M0[137], M0[14], M0[61], M0[157]};
wire [15:0] layer2_N380_lut = 16'hAACC;
assign M1[380] = layer2_N380_lut[layer2_N380_wire];

wire [3:0] layer2_N381_wire = {M0[12], M0[40], M0[50], M0[137]};
wire [15:0] layer2_N381_lut = 16'hCCCC;
assign M1[381] = layer2_N381_lut[layer2_N381_wire];

wire [3:0] layer2_N382_wire = {M0[80], M0[18], M0[14], M0[88]};
wire [15:0] layer2_N382_lut = 16'h3331;
assign M1[382] = layer2_N382_lut[layer2_N382_wire];

wire [3:0] layer2_N383_wire = {M0[115], M0[118], M0[86], M0[95]};
wire [15:0] layer2_N383_lut = 16'hFCC8;
assign M1[383] = layer2_N383_lut[layer2_N383_wire];

wire [3:0] layer2_N384_wire = {M0[128], M0[148], M0[43], M0[137]};
wire [15:0] layer2_N384_lut = 16'hEC44;
assign M1[384] = layer2_N384_lut[layer2_N384_wire];

wire [3:0] layer2_N385_wire = {M0[158], M0[128], M0[124], M0[108]};
wire [15:0] layer2_N385_lut = 16'h7F46;
assign M1[385] = layer2_N385_lut[layer2_N385_wire];

wire [3:0] layer2_N386_wire = {M0[158], M0[3], M0[121], M0[152]};
wire [15:0] layer2_N386_lut = 16'hDF0F;
assign M1[386] = layer2_N386_lut[layer2_N386_wire];

wire [3:0] layer2_N387_wire = {M0[148], M0[87], M0[2], M0[158]};
wire [15:0] layer2_N387_lut = 16'h0E0F;
assign M1[387] = layer2_N387_lut[layer2_N387_wire];

wire [3:0] layer2_N388_wire = {M0[147], M0[63], M0[122], M0[124]};
wire [15:0] layer2_N388_lut = 16'h0A1B;
assign M1[388] = layer2_N388_lut[layer2_N388_wire];

wire [3:0] layer2_N389_wire = {M0[4], M0[100], M0[30], M0[158]};
wire [15:0] layer2_N389_lut = 16'h3725;
assign M1[389] = layer2_N389_lut[layer2_N389_wire];

wire [3:0] layer2_N390_wire = {M0[147], M0[148], M0[91], M0[121]};
wire [15:0] layer2_N390_lut = 16'hC0FD;
assign M1[390] = layer2_N390_lut[layer2_N390_wire];

wire [3:0] layer2_N391_wire = {M0[97], M0[24], M0[156], M0[128]};
wire [15:0] layer2_N391_lut = 16'h7371;
assign M1[391] = layer2_N391_lut[layer2_N391_wire];

wire [3:0] layer2_N392_wire = {M0[148], M0[147], M0[1], M0[53]};
wire [15:0] layer2_N392_lut = 16'h0702;
assign M1[392] = layer2_N392_lut[layer2_N392_wire];

wire [3:0] layer2_N393_wire = {M0[11], M0[148], M0[92], M0[5]};
wire [15:0] layer2_N393_lut = 16'h1537;
assign M1[393] = layer2_N393_lut[layer2_N393_wire];

wire [3:0] layer2_N394_wire = {M0[148], M0[69], M0[147], M0[59]};
wire [15:0] layer2_N394_lut = 16'hAAEE;
assign M1[394] = layer2_N394_lut[layer2_N394_wire];

wire [3:0] layer2_N395_wire = {M0[13], M0[11], M0[35], M0[148]};
wire [15:0] layer2_N395_lut = 16'h04FF;
assign M1[395] = layer2_N395_lut[layer2_N395_wire];

wire [3:0] layer2_N396_wire = {M0[37], M0[121], M0[75], M0[60]};
wire [15:0] layer2_N396_lut = 16'h8088;
assign M1[396] = layer2_N396_lut[layer2_N396_wire];

wire [3:0] layer2_N397_wire = {M0[91], M0[58], M0[4], M0[86]};
wire [15:0] layer2_N397_lut = 16'hAFAF;
assign M1[397] = layer2_N397_lut[layer2_N397_wire];

wire [3:0] layer2_N398_wire = {M0[59], M0[1], M0[75], M0[39]};
wire [15:0] layer2_N398_lut = 16'hFBB2;
assign M1[398] = layer2_N398_lut[layer2_N398_wire];

wire [3:0] layer2_N399_wire = {M0[39], M0[95], M0[69], M0[121]};
wire [15:0] layer2_N399_lut = 16'hFF2F;
assign M1[399] = layer2_N399_lut[layer2_N399_wire];

wire [3:0] layer2_N400_wire = {M0[158], M0[97], M0[18], M0[94]};
wire [15:0] layer2_N400_lut = 16'h223B;
assign M1[400] = layer2_N400_lut[layer2_N400_wire];

wire [3:0] layer2_N401_wire = {M0[97], M0[128], M0[11], M0[19]};
wire [15:0] layer2_N401_lut = 16'h80FC;
assign M1[401] = layer2_N401_lut[layer2_N401_wire];

wire [3:0] layer2_N402_wire = {M0[10], M0[90], M0[147], M0[102]};
wire [15:0] layer2_N402_lut = 16'h011F;
assign M1[402] = layer2_N402_lut[layer2_N402_wire];

wire [3:0] layer2_N403_wire = {M0[24], M0[133], M0[145], M0[68]};
wire [15:0] layer2_N403_lut = 16'hCCFF;
assign M1[403] = layer2_N403_lut[layer2_N403_wire];

wire [3:0] layer2_N404_wire = {M0[39], M0[156], M0[96], M0[121]};
wire [15:0] layer2_N404_lut = 16'h4F0C;
assign M1[404] = layer2_N404_lut[layer2_N404_wire];

wire [3:0] layer2_N405_wire = {M0[58], M0[36], M0[131], M0[134]};
wire [15:0] layer2_N405_lut = 16'hAAEF;
assign M1[405] = layer2_N405_lut[layer2_N405_wire];

wire [3:0] layer2_N406_wire = {M0[97], M0[39], M0[56], M0[157]};
wire [15:0] layer2_N406_lut = 16'h103B;
assign M1[406] = layer2_N406_lut[layer2_N406_wire];

wire [3:0] layer2_N407_wire = {M0[39], M0[4], M0[103], M0[124]};
wire [15:0] layer2_N407_lut = 16'h3B33;
assign M1[407] = layer2_N407_lut[layer2_N407_wire];

wire [3:0] layer2_N408_wire = {M0[56], M0[68], M0[121], M0[97]};
wire [15:0] layer2_N408_lut = 16'h4055;
assign M1[408] = layer2_N408_lut[layer2_N408_wire];

wire [3:0] layer2_N409_wire = {M0[97], M0[128], M0[68], M0[56]};
wire [15:0] layer2_N409_lut = 16'h50F5;
assign M1[409] = layer2_N409_lut[layer2_N409_wire];

wire [3:0] layer2_N410_wire = {M0[121], M0[148], M0[74], M0[75]};
wire [15:0] layer2_N410_lut = 16'hA2A2;
assign M1[410] = layer2_N410_lut[layer2_N410_wire];

wire [3:0] layer2_N411_wire = {M0[148], M0[121], M0[33], M0[56]};
wire [15:0] layer2_N411_lut = 16'h1311;
assign M1[411] = layer2_N411_lut[layer2_N411_wire];

wire [3:0] layer2_N412_wire = {M0[41], M0[93], M0[63], M0[67]};
wire [15:0] layer2_N412_lut = 16'hF8E8;
assign M1[412] = layer2_N412_lut[layer2_N412_wire];

wire [3:0] layer2_N413_wire = {M0[128], M0[111], M0[41], M0[67]};
wire [15:0] layer2_N413_lut = 16'h7111;
assign M1[413] = layer2_N413_lut[layer2_N413_wire];

wire [3:0] layer2_N414_wire = {M0[105], M0[31], M0[145], M0[28]};
wire [15:0] layer2_N414_lut = 16'h7577;
assign M1[414] = layer2_N414_lut[layer2_N414_wire];

wire [3:0] layer2_N415_wire = {M0[89], M0[39], M0[125], M0[145]};
wire [15:0] layer2_N415_lut = 16'hF773;
assign M1[415] = layer2_N415_lut[layer2_N415_wire];

wire [3:0] layer2_N416_wire = {M0[128], M0[45], M0[158], M0[92]};
wire [15:0] layer2_N416_lut = 16'hBF02;
assign M1[416] = layer2_N416_lut[layer2_N416_wire];

wire [3:0] layer2_N417_wire = {M0[37], M0[11], M0[83], M0[59]};
wire [15:0] layer2_N417_lut = 16'hBB82;
assign M1[417] = layer2_N417_lut[layer2_N417_wire];

wire [3:0] layer2_N418_wire = {M0[26], M0[59], M0[45], M0[90]};
wire [15:0] layer2_N418_lut = 16'h4555;
assign M1[418] = layer2_N418_lut[layer2_N418_wire];

wire [3:0] layer2_N419_wire = {M0[83], M0[11], M0[128], M0[45]};
wire [15:0] layer2_N419_lut = 16'hCCF0;
assign M1[419] = layer2_N419_lut[layer2_N419_wire];

wire [3:0] layer2_N420_wire = {M0[147], M0[39], M0[158], M0[121]};
wire [15:0] layer2_N420_lut = 16'hFCFD;
assign M1[420] = layer2_N420_lut[layer2_N420_wire];

wire [3:0] layer2_N421_wire = {M0[156], M0[145], M0[105], M0[147]};
wire [15:0] layer2_N421_lut = 16'h00BF;
assign M1[421] = layer2_N421_lut[layer2_N421_wire];

wire [3:0] layer2_N422_wire = {M0[145], M0[72], M0[68], M0[158]};
wire [15:0] layer2_N422_lut = 16'h1D0D;
assign M1[422] = layer2_N422_lut[layer2_N422_wire];

wire [3:0] layer2_N423_wire = {M0[105], M0[48], M0[59], M0[39]};
wire [15:0] layer2_N423_lut = 16'hECFE;
assign M1[423] = layer2_N423_lut[layer2_N423_wire];

wire [3:0] layer2_N424_wire = {M0[147], M0[148], M0[128], M0[81]};
wire [15:0] layer2_N424_lut = 16'hBFAB;
assign M1[424] = layer2_N424_lut[layer2_N424_wire];

wire [3:0] layer2_N425_wire = {M0[96], M0[27], M0[114], M0[4]};
wire [15:0] layer2_N425_lut = 16'h3F33;
assign M1[425] = layer2_N425_lut[layer2_N425_wire];

wire [3:0] layer2_N426_wire = {M0[147], M0[148], M0[105], M0[75]};
wire [15:0] layer2_N426_lut = 16'hFF5F;
assign M1[426] = layer2_N426_lut[layer2_N426_wire];

wire [3:0] layer2_N427_wire = {M0[97], M0[145], M0[19], M0[128]};
wire [15:0] layer2_N427_lut = 16'h5F05;
assign M1[427] = layer2_N427_lut[layer2_N427_wire];

wire [3:0] layer2_N428_wire = {M0[122], M0[154], M0[148], M0[66]};
wire [15:0] layer2_N428_lut = 16'h5F0F;
assign M1[428] = layer2_N428_lut[layer2_N428_wire];

wire [3:0] layer2_N429_wire = {M0[111], M0[97], M0[51], M0[44]};
wire [15:0] layer2_N429_lut = 16'hE4F4;
assign M1[429] = layer2_N429_lut[layer2_N429_wire];

wire [3:0] layer2_N430_wire = {M0[28], M0[67], M0[147], M0[32]};
wire [15:0] layer2_N430_lut = 16'h55F5;
assign M1[430] = layer2_N430_lut[layer2_N430_wire];

wire [3:0] layer2_N431_wire = {M0[148], M0[60], M0[28], M0[118]};
wire [15:0] layer2_N431_lut = 16'h0D3F;
assign M1[431] = layer2_N431_lut[layer2_N431_wire];

wire [3:0] layer2_N432_wire = {M0[119], M0[1], M0[117], M0[80]};
wire [15:0] layer2_N432_lut = 16'hCD0C;
assign M1[432] = layer2_N432_lut[layer2_N432_wire];

wire [3:0] layer2_N433_wire = {M0[39], M0[148], M0[150], M0[139]};
wire [15:0] layer2_N433_lut = 16'hFEEA;
assign M1[433] = layer2_N433_lut[layer2_N433_wire];

wire [3:0] layer2_N434_wire = {M0[103], M0[158], M0[152], M0[79]};
wire [15:0] layer2_N434_lut = 16'h4F04;
assign M1[434] = layer2_N434_lut[layer2_N434_wire];

wire [3:0] layer2_N435_wire = {M0[157], M0[27], M0[42], M0[85]};
wire [15:0] layer2_N435_lut = 16'h0213;
assign M1[435] = layer2_N435_lut[layer2_N435_wire];

wire [3:0] layer2_N436_wire = {M0[83], M0[111], M0[35], M0[37]};
wire [15:0] layer2_N436_lut = 16'hDC50;
assign M1[436] = layer2_N436_lut[layer2_N436_wire];

wire [3:0] layer2_N437_wire = {M0[109], M0[81], M0[145], M0[17]};
wire [15:0] layer2_N437_lut = 16'hF2F3;
assign M1[437] = layer2_N437_lut[layer2_N437_wire];

wire [3:0] layer2_N438_wire = {M0[83], M0[18], M0[157], M0[30]};
wire [15:0] layer2_N438_lut = 16'hFAFA;
assign M1[438] = layer2_N438_lut[layer2_N438_wire];

wire [3:0] layer2_N439_wire = {M0[39], M0[63], M0[154], M0[58]};
wire [15:0] layer2_N439_lut = 16'h7371;
assign M1[439] = layer2_N439_lut[layer2_N439_wire];

wire [3:0] layer2_N440_wire = {M0[90], M0[4], M0[43], M0[32]};
wire [15:0] layer2_N440_lut = 16'hA0AA;
assign M1[440] = layer2_N440_lut[layer2_N440_wire];

wire [3:0] layer2_N441_wire = {M0[97], M0[96], M0[145], M0[56]};
wire [15:0] layer2_N441_lut = 16'hFBBA;
assign M1[441] = layer2_N441_lut[layer2_N441_wire];

wire [3:0] layer2_N442_wire = {M0[13], M0[153], M0[0], M0[122]};
wire [15:0] layer2_N442_lut = 16'hB2FB;
assign M1[442] = layer2_N442_lut[layer2_N442_wire];

wire [3:0] layer2_N443_wire = {M0[97], M0[96], M0[145], M0[38]};
wire [15:0] layer2_N443_lut = 16'hFFF5;
assign M1[443] = layer2_N443_lut[layer2_N443_wire];

wire [3:0] layer2_N444_wire = {M0[105], M0[159], M0[63], M0[125]};
wire [15:0] layer2_N444_lut = 16'hDC55;
assign M1[444] = layer2_N444_lut[layer2_N444_wire];

wire [3:0] layer2_N445_wire = {M0[148], M0[91], M0[147], M0[37]};
wire [15:0] layer2_N445_lut = 16'h7311;
assign M1[445] = layer2_N445_lut[layer2_N445_wire];

wire [3:0] layer2_N446_wire = {M0[98], M0[64], M0[152], M0[145]};
wire [15:0] layer2_N446_lut = 16'h00AE;
assign M1[446] = layer2_N446_lut[layer2_N446_wire];

wire [3:0] layer2_N447_wire = {M0[36], M0[148], M0[128], M0[110]};
wire [15:0] layer2_N447_lut = 16'h44DC;
assign M1[447] = layer2_N447_lut[layer2_N447_wire];

wire [3:0] layer2_N448_wire = {M0[49], M0[51], M0[113], M0[100]};
wire [15:0] layer2_N448_lut = 16'hD5C0;
assign M1[448] = layer2_N448_lut[layer2_N448_wire];

wire [3:0] layer2_N449_wire = {M0[35], M0[41], M0[100], M0[63]};
wire [15:0] layer2_N449_lut = 16'h0F0F;
assign M1[449] = layer2_N449_lut[layer2_N449_wire];

wire [3:0] layer2_N450_wire = {M0[18], M0[113], M0[97], M0[25]};
wire [15:0] layer2_N450_lut = 16'hAEEF;
assign M1[450] = layer2_N450_lut[layer2_N450_wire];

wire [3:0] layer2_N451_wire = {M0[91], M0[42], M0[151], M0[140]};
wire [15:0] layer2_N451_lut = 16'hB38B;
assign M1[451] = layer2_N451_lut[layer2_N451_wire];

wire [3:0] layer2_N452_wire = {M0[66], M0[3], M0[111], M0[128]};
wire [15:0] layer2_N452_lut = 16'h23FB;
assign M1[452] = layer2_N452_lut[layer2_N452_wire];

wire [3:0] layer2_N453_wire = {M0[66], M0[32], M0[116], M0[1]};
wire [15:0] layer2_N453_lut = 16'hFBB2;
assign M1[453] = layer2_N453_lut[layer2_N453_wire];

wire [3:0] layer2_N454_wire = {M0[1], M0[128], M0[159], M0[63]};
wire [15:0] layer2_N454_lut = 16'hCCEC;
assign M1[454] = layer2_N454_lut[layer2_N454_wire];

wire [3:0] layer2_N455_wire = {M0[51], M0[105], M0[96], M0[60]};
wire [15:0] layer2_N455_lut = 16'hA0E0;
assign M1[455] = layer2_N455_lut[layer2_N455_wire];

wire [3:0] layer2_N456_wire = {M0[58], M0[136], M0[3], M0[114]};
wire [15:0] layer2_N456_lut = 16'h7F10;
assign M1[456] = layer2_N456_lut[layer2_N456_wire];

wire [3:0] layer2_N457_wire = {M0[4], M0[137], M0[8], M0[58]};
wire [15:0] layer2_N457_lut = 16'h000C;
assign M1[457] = layer2_N457_lut[layer2_N457_wire];

wire [3:0] layer2_N458_wire = {M0[122], M0[49], M0[12], M0[123]};
wire [15:0] layer2_N458_lut = 16'hC0C4;
assign M1[458] = layer2_N458_lut[layer2_N458_wire];

wire [3:0] layer2_N459_wire = {M0[133], M0[17], M0[51], M0[7]};
wire [15:0] layer2_N459_lut = 16'h80FF;
assign M1[459] = layer2_N459_lut[layer2_N459_wire];

wire [3:0] layer2_N460_wire = {M0[49], M0[122], M0[99], M0[2]};
wire [15:0] layer2_N460_lut = 16'h0F08;
assign M1[460] = layer2_N460_lut[layer2_N460_wire];

wire [3:0] layer2_N461_wire = {M0[7], M0[35], M0[76], M0[84]};
wire [15:0] layer2_N461_lut = 16'hAABF;
assign M1[461] = layer2_N461_lut[layer2_N461_wire];

wire [3:0] layer2_N462_wire = {M0[114], M0[35], M0[4], M0[119]};
wire [15:0] layer2_N462_lut = 16'h3110;
assign M1[462] = layer2_N462_lut[layer2_N462_wire];

wire [3:0] layer2_N463_wire = {M0[63], M0[13], M0[134], M0[140]};
wire [15:0] layer2_N463_lut = 16'h5454;
assign M1[463] = layer2_N463_lut[layer2_N463_wire];

wire [3:0] layer2_N464_wire = {M0[119], M0[55], M0[128], M0[18]};
wire [15:0] layer2_N464_lut = 16'h7F11;
assign M1[464] = layer2_N464_lut[layer2_N464_wire];

wire [3:0] layer2_N465_wire = {M0[51], M0[3], M0[128], M0[63]};
wire [15:0] layer2_N465_lut = 16'h0AAF;
assign M1[465] = layer2_N465_lut[layer2_N465_wire];

wire [3:0] layer2_N466_wire = {M0[54], M0[69], M0[110], M0[37]};
wire [15:0] layer2_N466_lut = 16'hF0AA;
assign M1[466] = layer2_N466_lut[layer2_N466_wire];

wire [3:0] layer2_N467_wire = {M0[66], M0[130], M0[122], M0[56]};
wire [15:0] layer2_N467_lut = 16'h0003;
assign M1[467] = layer2_N467_lut[layer2_N467_wire];

wire [3:0] layer2_N468_wire = {M0[51], M0[109], M0[111], M0[44]};
wire [15:0] layer2_N468_lut = 16'hEAFA;
assign M1[468] = layer2_N468_lut[layer2_N468_wire];

wire [3:0] layer2_N469_wire = {M0[51], M0[156], M0[6], M0[115]};
wire [15:0] layer2_N469_lut = 16'h1F1F;
assign M1[469] = layer2_N469_lut[layer2_N469_wire];

wire [3:0] layer2_N470_wire = {M0[111], M0[86], M0[3], M0[135]};
wire [15:0] layer2_N470_lut = 16'hFF70;
assign M1[470] = layer2_N470_lut[layer2_N470_wire];

wire [3:0] layer2_N471_wire = {M0[50], M0[6], M0[40], M0[128]};
wire [15:0] layer2_N471_lut = 16'hC0E8;
assign M1[471] = layer2_N471_lut[layer2_N471_wire];

wire [3:0] layer2_N472_wire = {M0[156], M0[155], M0[59], M0[0]};
wire [15:0] layer2_N472_lut = 16'h1F1F;
assign M1[472] = layer2_N472_lut[layer2_N472_wire];

wire [3:0] layer2_N473_wire = {M0[2], M0[13], M0[59], M0[133]};
wire [15:0] layer2_N473_lut = 16'h1011;
assign M1[473] = layer2_N473_lut[layer2_N473_wire];

wire [3:0] layer2_N474_wire = {M0[119], M0[101], M0[34], M0[24]};
wire [15:0] layer2_N474_lut = 16'h1151;
assign M1[474] = layer2_N474_lut[layer2_N474_wire];

wire [3:0] layer2_N475_wire = {M0[142], M0[42], M0[67], M0[49]};
wire [15:0] layer2_N475_lut = 16'hD545;
assign M1[475] = layer2_N475_lut[layer2_N475_wire];

wire [3:0] layer2_N476_wire = {M0[51], M0[54], M0[114], M0[101]};
wire [15:0] layer2_N476_lut = 16'h2C20;
assign M1[476] = layer2_N476_lut[layer2_N476_wire];

wire [3:0] layer2_N477_wire = {M0[40], M0[109], M0[115], M0[88]};
wire [15:0] layer2_N477_lut = 16'h57FF;
assign M1[477] = layer2_N477_lut[layer2_N477_wire];

wire [3:0] layer2_N478_wire = {M0[114], M0[74], M0[107], M0[101]};
wire [15:0] layer2_N478_lut = 16'h0F8C;
assign M1[478] = layer2_N478_lut[layer2_N478_wire];

wire [3:0] layer2_N479_wire = {M0[157], M0[55], M0[87], M0[110]};
wire [15:0] layer2_N479_lut = 16'hEFCD;
assign M1[479] = layer2_N479_lut[layer2_N479_wire];

wire [3:0] layer2_N480_wire = {M0[100], M0[44], M0[103], M0[128]};
wire [15:0] layer2_N480_lut = 16'hF1F0;
assign M1[480] = layer2_N480_lut[layer2_N480_wire];

wire [3:0] layer2_N481_wire = {M0[6], M0[3], M0[17], M0[9]};
wire [15:0] layer2_N481_lut = 16'h02FB;
assign M1[481] = layer2_N481_lut[layer2_N481_wire];

wire [3:0] layer2_N482_wire = {M0[81], M0[78], M0[84], M0[69]};
wire [15:0] layer2_N482_lut = 16'h0501;
assign M1[482] = layer2_N482_lut[layer2_N482_wire];

wire [3:0] layer2_N483_wire = {M0[115], M0[18], M0[39], M0[100]};
wire [15:0] layer2_N483_lut = 16'hD140;
assign M1[483] = layer2_N483_lut[layer2_N483_wire];

wire [3:0] layer2_N484_wire = {M0[139], M0[140], M0[87], M0[91]};
wire [15:0] layer2_N484_lut = 16'h4423;
assign M1[484] = layer2_N484_lut[layer2_N484_wire];

wire [3:0] layer2_N485_wire = {M0[76], M0[35], M0[0], M0[2]};
wire [15:0] layer2_N485_lut = 16'h88E5;
assign M1[485] = layer2_N485_lut[layer2_N485_wire];

wire [3:0] layer2_N486_wire = {M0[38], M0[97], M0[76], M0[109]};
wire [15:0] layer2_N486_lut = 16'h045F;
assign M1[486] = layer2_N486_lut[layer2_N486_wire];

wire [3:0] layer2_N487_wire = {M0[97], M0[38], M0[49], M0[39]};
wire [15:0] layer2_N487_lut = 16'h7571;
assign M1[487] = layer2_N487_lut[layer2_N487_wire];

wire [3:0] layer2_N488_wire = {M0[96], M0[5], M0[159], M0[87]};
wire [15:0] layer2_N488_lut = 16'h44C4;
assign M1[488] = layer2_N488_lut[layer2_N488_wire];

wire [3:0] layer2_N489_wire = {M0[110], M0[40], M0[130], M0[117]};
wire [15:0] layer2_N489_lut = 16'hB032;
assign M1[489] = layer2_N489_lut[layer2_N489_wire];

wire [3:0] layer2_N490_wire = {M0[90], M0[126], M0[10], M0[157]};
wire [15:0] layer2_N490_lut = 16'h0F0B;
assign M1[490] = layer2_N490_lut[layer2_N490_wire];

wire [3:0] layer2_N491_wire = {M0[57], M0[34], M0[98], M0[5]};
wire [15:0] layer2_N491_lut = 16'h05CF;
assign M1[491] = layer2_N491_lut[layer2_N491_wire];

wire [3:0] layer2_N492_wire = {M0[125], M0[70], M0[50], M0[35]};
wire [15:0] layer2_N492_lut = 16'h330F;
assign M1[492] = layer2_N492_lut[layer2_N492_wire];

wire [3:0] layer2_N493_wire = {M0[38], M0[56], M0[109], M0[107]};
wire [15:0] layer2_N493_lut = 16'hFED4;
assign M1[493] = layer2_N493_lut[layer2_N493_wire];

wire [3:0] layer2_N494_wire = {M0[66], M0[38], M0[51], M0[17]};
wire [15:0] layer2_N494_lut = 16'h00FE;
assign M1[494] = layer2_N494_lut[layer2_N494_wire];

wire [3:0] layer2_N495_wire = {M0[98], M0[35], M0[81], M0[128]};
wire [15:0] layer2_N495_lut = 16'h3FFF;
assign M1[495] = layer2_N495_lut[layer2_N495_wire];

wire [3:0] layer2_N496_wire = {M0[49], M0[86], M0[109], M0[98]};
wire [15:0] layer2_N496_lut = 16'hF0F0;
assign M1[496] = layer2_N496_lut[layer2_N496_wire];

wire [3:0] layer2_N497_wire = {M0[97], M0[109], M0[18], M0[24]};
wire [15:0] layer2_N497_lut = 16'h5545;
assign M1[497] = layer2_N497_lut[layer2_N497_wire];

wire [3:0] layer2_N498_wire = {M0[49], M0[63], M0[86], M0[127]};
wire [15:0] layer2_N498_lut = 16'hABAA;
assign M1[498] = layer2_N498_lut[layer2_N498_wire];

wire [3:0] layer2_N499_wire = {M0[37], M0[89], M0[56], M0[68]};
wire [15:0] layer2_N499_lut = 16'hAFAC;
assign M1[499] = layer2_N499_lut[layer2_N499_wire];

wire [3:0] layer2_N500_wire = {M0[128], M0[35], M0[37], M0[72]};
wire [15:0] layer2_N500_lut = 16'hEEEE;
assign M1[500] = layer2_N500_lut[layer2_N500_wire];

wire [3:0] layer2_N501_wire = {M0[101], M0[113], M0[1], M0[121]};
wire [15:0] layer2_N501_lut = 16'h5D5F;
assign M1[501] = layer2_N501_lut[layer2_N501_wire];

wire [3:0] layer2_N502_wire = {M0[101], M0[37], M0[113], M0[80]};
wire [15:0] layer2_N502_lut = 16'h4C05;
assign M1[502] = layer2_N502_lut[layer2_N502_wire];

wire [3:0] layer2_N503_wire = {M0[42], M0[1], M0[125], M0[108]};
wire [15:0] layer2_N503_lut = 16'hEA8A;
assign M1[503] = layer2_N503_lut[layer2_N503_wire];

wire [3:0] layer2_N504_wire = {M0[109], M0[49], M0[56], M0[156]};
wire [15:0] layer2_N504_lut = 16'h20AA;
assign M1[504] = layer2_N504_lut[layer2_N504_wire];

wire [3:0] layer2_N505_wire = {M0[49], M0[37], M0[86], M0[140]};
wire [15:0] layer2_N505_lut = 16'hEAFF;
assign M1[505] = layer2_N505_lut[layer2_N505_wire];

wire [3:0] layer2_N506_wire = {M0[118], M0[13], M0[37], M0[80]};
wire [15:0] layer2_N506_lut = 16'h7010;
assign M1[506] = layer2_N506_lut[layer2_N506_wire];

wire [3:0] layer2_N507_wire = {M0[56], M0[99], M0[109], M0[49]};
wire [15:0] layer2_N507_lut = 16'h00F0;
assign M1[507] = layer2_N507_lut[layer2_N507_wire];

wire [3:0] layer2_N508_wire = {M0[37], M0[39], M0[97], M0[78]};
wire [15:0] layer2_N508_lut = 16'h0011;
assign M1[508] = layer2_N508_lut[layer2_N508_wire];

wire [3:0] layer2_N509_wire = {M0[61], M0[158], M0[142], M0[84]};
wire [15:0] layer2_N509_lut = 16'h7D1C;
assign M1[509] = layer2_N509_lut[layer2_N509_wire];

wire [3:0] layer2_N510_wire = {M0[80], M0[159], M0[96], M0[73]};
wire [15:0] layer2_N510_lut = 16'hF0F0;
assign M1[510] = layer2_N510_lut[layer2_N510_wire];

wire [3:0] layer2_N511_wire = {M0[28], M0[64], M0[50], M0[96]};
wire [15:0] layer2_N511_lut = 16'h2F2F;
assign M1[511] = layer2_N511_lut[layer2_N511_wire];

wire [3:0] layer2_N512_wire = {M0[45], M0[47], M0[57], M0[156]};
wire [15:0] layer2_N512_lut = 16'h8D8D;
assign M1[512] = layer2_N512_lut[layer2_N512_wire];

wire [3:0] layer2_N513_wire = {M0[45], M0[151], M0[156], M0[9]};
wire [15:0] layer2_N513_lut = 16'h81A2;
assign M1[513] = layer2_N513_lut[layer2_N513_wire];

wire [3:0] layer2_N514_wire = {M0[104], M0[31], M0[77], M0[8]};
wire [15:0] layer2_N514_lut = 16'hC4FF;
assign M1[514] = layer2_N514_lut[layer2_N514_wire];

wire [3:0] layer2_N515_wire = {M0[7], M0[150], M0[23], M0[130]};
wire [15:0] layer2_N515_lut = 16'hBBB8;
assign M1[515] = layer2_N515_lut[layer2_N515_wire];

wire [3:0] layer2_N516_wire = {M0[85], M0[100], M0[119], M0[94]};
wire [15:0] layer2_N516_lut = 16'h40D0;
assign M1[516] = layer2_N516_lut[layer2_N516_wire];

wire [3:0] layer2_N517_wire = {M0[150], M0[71], M0[83], M0[102]};
wire [15:0] layer2_N517_lut = 16'h0500;
assign M1[517] = layer2_N517_lut[layer2_N517_wire];

wire [3:0] layer2_N518_wire = {M0[47], M0[0], M0[125], M0[11]};
wire [15:0] layer2_N518_lut = 16'h8888;
assign M1[518] = layer2_N518_lut[layer2_N518_wire];

wire [3:0] layer2_N519_wire = {M0[3], M0[88], M0[45], M0[43]};
wire [15:0] layer2_N519_lut = 16'h40FC;
assign M1[519] = layer2_N519_lut[layer2_N519_wire];

wire [3:0] layer2_N520_wire = {M0[20], M0[59], M0[101], M0[149]};
wire [15:0] layer2_N520_lut = 16'hAEAF;
assign M1[520] = layer2_N520_lut[layer2_N520_wire];

wire [3:0] layer2_N521_wire = {M0[33], M0[158], M0[101], M0[138]};
wire [15:0] layer2_N521_lut = 16'h88FF;
assign M1[521] = layer2_N521_lut[layer2_N521_wire];

wire [3:0] layer2_N522_wire = {M0[20], M0[25], M0[9], M0[156]};
wire [15:0] layer2_N522_lut = 16'hF033;
assign M1[522] = layer2_N522_lut[layer2_N522_wire];

wire [3:0] layer2_N523_wire = {M0[9], M0[95], M0[69], M0[23]};
wire [15:0] layer2_N523_lut = 16'h3333;
assign M1[523] = layer2_N523_lut[layer2_N523_wire];

wire [3:0] layer2_N524_wire = {M0[148], M0[40], M0[92], M0[4]};
wire [15:0] layer2_N524_lut = 16'hCCFF;
assign M1[524] = layer2_N524_lut[layer2_N524_wire];

wire [3:0] layer2_N525_wire = {M0[9], M0[61], M0[77], M0[157]};
wire [15:0] layer2_N525_lut = 16'h45D4;
assign M1[525] = layer2_N525_lut[layer2_N525_wire];

wire [3:0] layer2_N526_wire = {M0[149], M0[63], M0[101], M0[4]};
wire [15:0] layer2_N526_lut = 16'h22A2;
assign M1[526] = layer2_N526_lut[layer2_N526_wire];

wire [3:0] layer2_N527_wire = {M0[9], M0[53], M0[121], M0[36]};
wire [15:0] layer2_N527_lut = 16'h31B0;
assign M1[527] = layer2_N527_lut[layer2_N527_wire];

wire [3:0] layer2_N528_wire = {M0[45], M0[73], M0[151], M0[152]};
wire [15:0] layer2_N528_lut = 16'h0E0E;
assign M1[528] = layer2_N528_lut[layer2_N528_wire];

wire [3:0] layer2_N529_wire = {M0[76], M0[129], M0[21], M0[45]};
wire [15:0] layer2_N529_lut = 16'h8CFD;
assign M1[529] = layer2_N529_lut[layer2_N529_wire];

wire [3:0] layer2_N530_wire = {M0[79], M0[73], M0[24], M0[1]};
wire [15:0] layer2_N530_lut = 16'h30FF;
assign M1[530] = layer2_N530_lut[layer2_N530_wire];

wire [3:0] layer2_N531_wire = {M0[76], M0[21], M0[53], M0[45]};
wire [15:0] layer2_N531_lut = 16'h30FA;
assign M1[531] = layer2_N531_lut[layer2_N531_wire];

wire [3:0] layer2_N532_wire = {M0[9], M0[8], M0[40], M0[150]};
wire [15:0] layer2_N532_lut = 16'hBAEE;
assign M1[532] = layer2_N532_lut[layer2_N532_wire];

wire [3:0] layer2_N533_wire = {M0[53], M0[118], M0[2], M0[9]};
wire [15:0] layer2_N533_lut = 16'hC4C0;
assign M1[533] = layer2_N533_lut[layer2_N533_wire];

wire [3:0] layer2_N534_wire = {M0[151], M0[76], M0[7], M0[9]};
wire [15:0] layer2_N534_lut = 16'h0F2E;
assign M1[534] = layer2_N534_lut[layer2_N534_wire];

wire [3:0] layer2_N535_wire = {M0[53], M0[9], M0[1], M0[150]};
wire [15:0] layer2_N535_lut = 16'h88FF;
assign M1[535] = layer2_N535_lut[layer2_N535_wire];

wire [3:0] layer2_N536_wire = {M0[96], M0[100], M0[101], M0[152]};
wire [15:0] layer2_N536_lut = 16'h2200;
assign M1[536] = layer2_N536_lut[layer2_N536_wire];

wire [3:0] layer2_N537_wire = {M0[45], M0[106], M0[59], M0[47]};
wire [15:0] layer2_N537_lut = 16'hFF0B;
assign M1[537] = layer2_N537_lut[layer2_N537_wire];

wire [3:0] layer2_N538_wire = {M0[107], M0[0], M0[151], M0[50]};
wire [15:0] layer2_N538_lut = 16'h1A0A;
assign M1[538] = layer2_N538_lut[layer2_N538_wire];

wire [3:0] layer2_N539_wire = {M0[26], M0[100], M0[51], M0[152]};
wire [15:0] layer2_N539_lut = 16'h80E8;
assign M1[539] = layer2_N539_lut[layer2_N539_wire];

wire [3:0] layer2_N540_wire = {M0[83], M0[45], M0[68], M0[101]};
wire [15:0] layer2_N540_lut = 16'hBBAA;
assign M1[540] = layer2_N540_lut[layer2_N540_wire];

wire [3:0] layer2_N541_wire = {M0[9], M0[129], M0[113], M0[50]};
wire [15:0] layer2_N541_lut = 16'h0C34;
assign M1[541] = layer2_N541_lut[layer2_N541_wire];

wire [3:0] layer2_N542_wire = {M0[68], M0[81], M0[133], M0[17]};
wire [15:0] layer2_N542_lut = 16'h5D40;
assign M1[542] = layer2_N542_lut[layer2_N542_wire];

wire [3:0] layer2_N543_wire = {M0[83], M0[104], M0[150], M0[100]};
wire [15:0] layer2_N543_lut = 16'h202F;
assign M1[543] = layer2_N543_lut[layer2_N543_wire];

wire [3:0] layer2_N544_wire = {M0[21], M0[92], M0[125], M0[11]};
wire [15:0] layer2_N544_lut = 16'h0457;
assign M1[544] = layer2_N544_lut[layer2_N544_wire];

wire [3:0] layer2_N545_wire = {M0[92], M0[21], M0[125], M0[31]};
wire [15:0] layer2_N545_lut = 16'h0223;
assign M1[545] = layer2_N545_lut[layer2_N545_wire];

wire [3:0] layer2_N546_wire = {M0[9], M0[121], M0[129], M0[72]};
wire [15:0] layer2_N546_lut = 16'h0D07;
assign M1[546] = layer2_N546_lut[layer2_N546_wire];

wire [3:0] layer2_N547_wire = {M0[150], M0[53], M0[9], M0[88]};
wire [15:0] layer2_N547_lut = 16'hAF07;
assign M1[547] = layer2_N547_lut[layer2_N547_wire];

wire [3:0] layer2_N548_wire = {M0[156], M0[96], M0[63], M0[66]};
wire [15:0] layer2_N548_lut = 16'hFFF1;
assign M1[548] = layer2_N548_lut[layer2_N548_wire];

wire [3:0] layer2_N549_wire = {M0[151], M0[109], M0[144], M0[21]};
wire [15:0] layer2_N549_lut = 16'h54F7;
assign M1[549] = layer2_N549_lut[layer2_N549_wire];

wire [3:0] layer2_N550_wire = {M0[9], M0[98], M0[159], M0[129]};
wire [15:0] layer2_N550_lut = 16'hA6F5;
assign M1[550] = layer2_N550_lut[layer2_N550_wire];

wire [3:0] layer2_N551_wire = {M0[151], M0[150], M0[147], M0[67]};
wire [15:0] layer2_N551_lut = 16'h22AE;
assign M1[551] = layer2_N551_lut[layer2_N551_wire];

wire [3:0] layer2_N552_wire = {M0[84], M0[56], M0[61], M0[109]};
wire [15:0] layer2_N552_lut = 16'h10F7;
assign M1[552] = layer2_N552_lut[layer2_N552_wire];

wire [3:0] layer2_N553_wire = {M0[156], M0[21], M0[98], M0[126]};
wire [15:0] layer2_N553_lut = 16'h075F;
assign M1[553] = layer2_N553_lut[layer2_N553_wire];

wire [3:0] layer2_N554_wire = {M0[156], M0[136], M0[105], M0[47]};
wire [15:0] layer2_N554_lut = 16'h050D;
assign M1[554] = layer2_N554_lut[layer2_N554_wire];

wire [3:0] layer2_N555_wire = {M0[56], M0[152], M0[98], M0[76]};
wire [15:0] layer2_N555_lut = 16'h6EEA;
assign M1[555] = layer2_N555_lut[layer2_N555_wire];

wire [3:0] layer2_N556_wire = {M0[127], M0[45], M0[21], M0[56]};
wire [15:0] layer2_N556_lut = 16'hF8C8;
assign M1[556] = layer2_N556_lut[layer2_N556_wire];

wire [3:0] layer2_N557_wire = {M0[98], M0[92], M0[156], M0[125]};
wire [15:0] layer2_N557_lut = 16'h0355;
assign M1[557] = layer2_N557_lut[layer2_N557_wire];

wire [3:0] layer2_N558_wire = {M0[9], M0[77], M0[27], M0[157]};
wire [15:0] layer2_N558_lut = 16'hEF0A;
assign M1[558] = layer2_N558_lut[layer2_N558_wire];

wire [3:0] layer2_N559_wire = {M0[68], M0[20], M0[97], M0[92]};
wire [15:0] layer2_N559_lut = 16'h1F00;
assign M1[559] = layer2_N559_lut[layer2_N559_wire];

wire [3:0] layer2_N560_wire = {M0[92], M0[150], M0[101], M0[9]};
wire [15:0] layer2_N560_lut = 16'h000B;
assign M1[560] = layer2_N560_lut[layer2_N560_wire];

wire [3:0] layer2_N561_wire = {M0[53], M0[101], M0[0], M0[68]};
wire [15:0] layer2_N561_lut = 16'hAF00;
assign M1[561] = layer2_N561_lut[layer2_N561_wire];

wire [3:0] layer2_N562_wire = {M0[9], M0[112], M0[13], M0[68]};
wire [15:0] layer2_N562_lut = 16'hA0A0;
assign M1[562] = layer2_N562_lut[layer2_N562_wire];

wire [3:0] layer2_N563_wire = {M0[20], M0[155], M0[143], M0[108]};
wire [15:0] layer2_N563_lut = 16'h32F7;
assign M1[563] = layer2_N563_lut[layer2_N563_wire];

wire [3:0] layer2_N564_wire = {M0[13], M0[9], M0[77], M0[62]};
wire [15:0] layer2_N564_lut = 16'h5073;
assign M1[564] = layer2_N564_lut[layer2_N564_wire];

wire [3:0] layer2_N565_wire = {M0[63], M0[119], M0[140], M0[128]};
wire [15:0] layer2_N565_lut = 16'h50D4;
assign M1[565] = layer2_N565_lut[layer2_N565_wire];

wire [3:0] layer2_N566_wire = {M0[156], M0[9], M0[2], M0[77]};
wire [15:0] layer2_N566_lut = 16'hEEEE;
assign M1[566] = layer2_N566_lut[layer2_N566_wire];

wire [3:0] layer2_N567_wire = {M0[124], M0[156], M0[39], M0[63]};
wire [15:0] layer2_N567_lut = 16'h3177;
assign M1[567] = layer2_N567_lut[layer2_N567_wire];

wire [3:0] layer2_N568_wire = {M0[143], M0[45], M0[148], M0[159]};
wire [15:0] layer2_N568_lut = 16'h8CCF;
assign M1[568] = layer2_N568_lut[layer2_N568_wire];

wire [3:0] layer2_N569_wire = {M0[21], M0[4], M0[128], M0[114]};
wire [15:0] layer2_N569_lut = 16'hCF0F;
assign M1[569] = layer2_N569_lut[layer2_N569_wire];

wire [3:0] layer2_N570_wire = {M0[157], M0[22], M0[74], M0[82]};
wire [15:0] layer2_N570_lut = 16'h00CD;
assign M1[570] = layer2_N570_lut[layer2_N570_wire];

wire [3:0] layer2_N571_wire = {M0[9], M0[67], M0[157], M0[76]};
wire [15:0] layer2_N571_lut = 16'h0F0D;
assign M1[571] = layer2_N571_lut[layer2_N571_wire];

wire [3:0] layer2_N572_wire = {M0[105], M0[57], M0[149], M0[144]};
wire [15:0] layer2_N572_lut = 16'h2323;
assign M1[572] = layer2_N572_lut[layer2_N572_wire];

wire [3:0] layer2_N573_wire = {M0[76], M0[7], M0[62], M0[21]};
wire [15:0] layer2_N573_lut = 16'hDF00;
assign M1[573] = layer2_N573_lut[layer2_N573_wire];

wire [3:0] layer2_N574_wire = {M0[45], M0[122], M0[61], M0[68]};
wire [15:0] layer2_N574_lut = 16'hFF0F;
assign M1[574] = layer2_N574_lut[layer2_N574_wire];

wire [3:0] layer2_N575_wire = {M0[9], M0[68], M0[151], M0[101]};
wire [15:0] layer2_N575_lut = 16'h1070;
assign M1[575] = layer2_N575_lut[layer2_N575_wire];

wire [3:0] layer2_N576_wire = {M0[28], M0[50], M0[98], M0[67]};
wire [15:0] layer2_N576_lut = 16'hC444;
assign M1[576] = layer2_N576_lut[layer2_N576_wire];

wire [3:0] layer2_N577_wire = {M0[149], M0[31], M0[111], M0[28]};
wire [15:0] layer2_N577_lut = 16'hCFCC;
assign M1[577] = layer2_N577_lut[layer2_N577_wire];

wire [3:0] layer2_N578_wire = {M0[22], M0[59], M0[125], M0[46]};
wire [15:0] layer2_N578_lut = 16'hB2FB;
assign M1[578] = layer2_N578_lut[layer2_N578_wire];

wire [3:0] layer2_N579_wire = {M0[141], M0[156], M0[88], M0[149]};
wire [15:0] layer2_N579_lut = 16'h0115;
assign M1[579] = layer2_N579_lut[layer2_N579_wire];

wire [3:0] layer2_N580_wire = {M0[84], M0[149], M0[119], M0[106]};
wire [15:0] layer2_N580_lut = 16'hFAE8;
assign M1[580] = layer2_N580_lut[layer2_N580_wire];

wire [3:0] layer2_N581_wire = {M0[131], M0[84], M0[97], M0[13]};
wire [15:0] layer2_N581_lut = 16'h89BB;
assign M1[581] = layer2_N581_lut[layer2_N581_wire];

wire [3:0] layer2_N582_wire = {M0[31], M0[86], M0[126], M0[42]};
wire [15:0] layer2_N582_lut = 16'h54DD;
assign M1[582] = layer2_N582_lut[layer2_N582_wire];

wire [3:0] layer2_N583_wire = {M0[70], M0[15], M0[122], M0[107]};
wire [15:0] layer2_N583_lut = 16'h44FF;
assign M1[583] = layer2_N583_lut[layer2_N583_wire];

wire [3:0] layer2_N584_wire = {M0[84], M0[31], M0[38], M0[26]};
wire [15:0] layer2_N584_lut = 16'h32B2;
assign M1[584] = layer2_N584_lut[layer2_N584_wire];

wire [3:0] layer2_N585_wire = {M0[31], M0[95], M0[130], M0[38]};
wire [15:0] layer2_N585_lut = 16'hCC14;
assign M1[585] = layer2_N585_lut[layer2_N585_wire];

wire [3:0] layer2_N586_wire = {M0[84], M0[17], M0[112], M0[96]};
wire [15:0] layer2_N586_lut = 16'hB2B1;
assign M1[586] = layer2_N586_lut[layer2_N586_wire];

wire [3:0] layer2_N587_wire = {M0[84], M0[7], M0[37], M0[94]};
wire [15:0] layer2_N587_lut = 16'hCF8F;
assign M1[587] = layer2_N587_lut[layer2_N587_wire];

wire [3:0] layer2_N588_wire = {M0[84], M0[114], M0[39], M0[83]};
wire [15:0] layer2_N588_lut = 16'h0F8F;
assign M1[588] = layer2_N588_lut[layer2_N588_wire];

wire [3:0] layer2_N589_wire = {M0[39], M0[83], M0[84], M0[105]};
wire [15:0] layer2_N589_lut = 16'h0C4F;
assign M1[589] = layer2_N589_lut[layer2_N589_wire];

wire [3:0] layer2_N590_wire = {M0[0], M0[91], M0[105], M0[9]};
wire [15:0] layer2_N590_lut = 16'hB2F5;
assign M1[590] = layer2_N590_lut[layer2_N590_wire];

wire [3:0] layer2_N591_wire = {M0[101], M0[84], M0[118], M0[36]};
wire [15:0] layer2_N591_lut = 16'h2A02;
assign M1[591] = layer2_N591_lut[layer2_N591_wire];

wire [3:0] layer2_N592_wire = {M0[37], M0[1], M0[15], M0[151]};
wire [15:0] layer2_N592_lut = 16'h31BB;
assign M1[592] = layer2_N592_lut[layer2_N592_wire];

wire [3:0] layer2_N593_wire = {M0[151], M0[138], M0[111], M0[37]};
wire [15:0] layer2_N593_lut = 16'h3070;
assign M1[593] = layer2_N593_lut[layer2_N593_wire];

wire [3:0] layer2_N594_wire = {M0[31], M0[88], M0[107], M0[151]};
wire [15:0] layer2_N594_lut = 16'hEF88;
assign M1[594] = layer2_N594_lut[layer2_N594_wire];

wire [3:0] layer2_N595_wire = {M0[59], M0[28], M0[1], M0[6]};
wire [15:0] layer2_N595_lut = 16'hAAA0;
assign M1[595] = layer2_N595_lut[layer2_N595_wire];

wire [3:0] layer2_N596_wire = {M0[113], M0[101], M0[21], M0[139]};
wire [15:0] layer2_N596_lut = 16'h0757;
assign M1[596] = layer2_N596_lut[layer2_N596_wire];

wire [3:0] layer2_N597_wire = {M0[91], M0[139], M0[17], M0[114]};
wire [15:0] layer2_N597_lut = 16'h40D0;
assign M1[597] = layer2_N597_lut[layer2_N597_wire];

wire [3:0] layer2_N598_wire = {M0[139], M0[86], M0[114], M0[113]};
wire [15:0] layer2_N598_lut = 16'h22AA;
assign M1[598] = layer2_N598_lut[layer2_N598_wire];

wire [3:0] layer2_N599_wire = {M0[13], M0[17], M0[86], M0[91]};
wire [15:0] layer2_N599_lut = 16'h2AAE;
assign M1[599] = layer2_N599_lut[layer2_N599_wire];

wire [3:0] layer2_N600_wire = {M0[6], M0[28], M0[70], M0[33]};
wire [15:0] layer2_N600_lut = 16'h44C4;
assign M1[600] = layer2_N600_lut[layer2_N600_wire];

wire [3:0] layer2_N601_wire = {M0[85], M0[27], M0[156], M0[63]};
wire [15:0] layer2_N601_lut = 16'h4D5F;
assign M1[601] = layer2_N601_lut[layer2_N601_wire];

wire [3:0] layer2_N602_wire = {M0[61], M0[27], M0[22], M0[6]};
wire [15:0] layer2_N602_lut = 16'hD450;
assign M1[602] = layer2_N602_lut[layer2_N602_wire];

wire [3:0] layer2_N603_wire = {M0[61], M0[94], M0[22], M0[126]};
wire [15:0] layer2_N603_lut = 16'h4D44;
assign M1[603] = layer2_N603_lut[layer2_N603_wire];

wire [3:0] layer2_N604_wire = {M0[128], M0[8], M0[46], M0[27]};
wire [15:0] layer2_N604_lut = 16'hC5D5;
assign M1[604] = layer2_N604_lut[layer2_N604_wire];

wire [3:0] layer2_N605_wire = {M0[128], M0[8], M0[156], M0[49]};
wire [15:0] layer2_N605_lut = 16'h7F1F;
assign M1[605] = layer2_N605_lut[layer2_N605_wire];

wire [3:0] layer2_N606_wire = {M0[8], M0[49], M0[86], M0[36]};
wire [15:0] layer2_N606_lut = 16'hA2B0;
assign M1[606] = layer2_N606_lut[layer2_N606_wire];

wire [3:0] layer2_N607_wire = {M0[105], M0[13], M0[14], M0[82]};
wire [15:0] layer2_N607_lut = 16'h5404;
assign M1[607] = layer2_N607_lut[layer2_N607_wire];

wire [3:0] layer2_N608_wire = {M0[15], M0[84], M0[111], M0[127]};
wire [15:0] layer2_N608_lut = 16'h0133;
assign M1[608] = layer2_N608_lut[layer2_N608_wire];

wire [3:0] layer2_N609_wire = {M0[84], M0[17], M0[83], M0[54]};
wire [15:0] layer2_N609_lut = 16'hC8E8;
assign M1[609] = layer2_N609_lut[layer2_N609_wire];

wire [3:0] layer2_N610_wire = {M0[84], M0[63], M0[127], M0[17]};
wire [15:0] layer2_N610_lut = 16'h5F4F;
assign M1[610] = layer2_N610_lut[layer2_N610_wire];

wire [3:0] layer2_N611_wire = {M0[91], M0[32], M0[136], M0[54]};
wire [15:0] layer2_N611_lut = 16'h33BF;
assign M1[611] = layer2_N611_lut[layer2_N611_wire];

wire [3:0] layer2_N612_wire = {M0[7], M0[109], M0[157], M0[123]};
wire [15:0] layer2_N612_lut = 16'hD5FD;
assign M1[612] = layer2_N612_lut[layer2_N612_wire];

wire [3:0] layer2_N613_wire = {M0[112], M0[37], M0[134], M0[84]};
wire [15:0] layer2_N613_lut = 16'hFFCC;
assign M1[613] = layer2_N613_lut[layer2_N613_wire];

wire [3:0] layer2_N614_wire = {M0[126], M0[63], M0[5], M0[104]};
wire [15:0] layer2_N614_lut = 16'hBB09;
assign M1[614] = layer2_N614_lut[layer2_N614_wire];

wire [3:0] layer2_N615_wire = {M0[139], M0[151], M0[33], M0[17]};
wire [15:0] layer2_N615_lut = 16'h8CDD;
assign M1[615] = layer2_N615_lut[layer2_N615_wire];

wire [3:0] layer2_N616_wire = {M0[137], M0[0], M0[136], M0[39]};
wire [15:0] layer2_N616_lut = 16'h22BB;
assign M1[616] = layer2_N616_lut[layer2_N616_wire];

wire [3:0] layer2_N617_wire = {M0[56], M0[8], M0[54], M0[11]};
wire [15:0] layer2_N617_lut = 16'h8A08;
assign M1[617] = layer2_N617_lut[layer2_N617_wire];

wire [3:0] layer2_N618_wire = {M0[132], M0[83], M0[23], M0[7]};
wire [15:0] layer2_N618_lut = 16'h5CDD;
assign M1[618] = layer2_N618_lut[layer2_N618_wire];

wire [3:0] layer2_N619_wire = {M0[84], M0[107], M0[83], M0[154]};
wire [15:0] layer2_N619_lut = 16'hAF2B;
assign M1[619] = layer2_N619_lut[layer2_N619_wire];

wire [3:0] layer2_N620_wire = {M0[123], M0[134], M0[52], M0[147]};
wire [15:0] layer2_N620_lut = 16'h54FF;
assign M1[620] = layer2_N620_lut[layer2_N620_wire];

wire [3:0] layer2_N621_wire = {M0[150], M0[35], M0[38], M0[129]};
wire [15:0] layer2_N621_lut = 16'h0123;
assign M1[621] = layer2_N621_lut[layer2_N621_wire];

wire [3:0] layer2_N622_wire = {M0[21], M0[19], M0[61], M0[110]};
wire [15:0] layer2_N622_lut = 16'hABFF;
assign M1[622] = layer2_N622_lut[layer2_N622_wire];

wire [3:0] layer2_N623_wire = {M0[10], M0[155], M0[117], M0[105]};
wire [15:0] layer2_N623_lut = 16'hA8B8;
assign M1[623] = layer2_N623_lut[layer2_N623_wire];

wire [3:0] layer2_N624_wire = {M0[84], M0[141], M0[16], M0[83]};
wire [15:0] layer2_N624_lut = 16'h0C8C;
assign M1[624] = layer2_N624_lut[layer2_N624_wire];

wire [3:0] layer2_N625_wire = {M0[36], M0[128], M0[138], M0[60]};
wire [15:0] layer2_N625_lut = 16'hA2AF;
assign M1[625] = layer2_N625_lut[layer2_N625_wire];

wire [3:0] layer2_N626_wire = {M0[64], M0[128], M0[1], M0[126]};
wire [15:0] layer2_N626_lut = 16'h238B;
assign M1[626] = layer2_N626_lut[layer2_N626_wire];

wire [3:0] layer2_N627_wire = {M0[63], M0[151], M0[91], M0[58]};
wire [15:0] layer2_N627_lut = 16'h8CAF;
assign M1[627] = layer2_N627_lut[layer2_N627_wire];

wire [3:0] layer2_N628_wire = {M0[13], M0[128], M0[51], M0[0]};
wire [15:0] layer2_N628_lut = 16'hEEAA;
assign M1[628] = layer2_N628_lut[layer2_N628_wire];

wire [3:0] layer2_N629_wire = {M0[13], M0[51], M0[110], M0[48]};
wire [15:0] layer2_N629_lut = 16'hD5F5;
assign M1[629] = layer2_N629_lut[layer2_N629_wire];

wire [3:0] layer2_N630_wire = {M0[72], M0[134], M0[8], M0[112]};
wire [15:0] layer2_N630_lut = 16'hFBEA;
assign M1[630] = layer2_N630_lut[layer2_N630_wire];

wire [3:0] layer2_N631_wire = {M0[13], M0[84], M0[64], M0[12]};
wire [15:0] layer2_N631_lut = 16'h4455;
assign M1[631] = layer2_N631_lut[layer2_N631_wire];

wire [3:0] layer2_N632_wire = {M0[37], M0[140], M0[151], M0[46]};
wire [15:0] layer2_N632_lut = 16'hE0E2;
assign M1[632] = layer2_N632_lut[layer2_N632_wire];

wire [3:0] layer2_N633_wire = {M0[13], M0[46], M0[118], M0[122]};
wire [15:0] layer2_N633_lut = 16'hCCFA;
assign M1[633] = layer2_N633_lut[layer2_N633_wire];

wire [3:0] layer2_N634_wire = {M0[36], M0[37], M0[73], M0[88]};
wire [15:0] layer2_N634_lut = 16'hB8FF;
assign M1[634] = layer2_N634_lut[layer2_N634_wire];

wire [3:0] layer2_N635_wire = {M0[86], M0[94], M0[127], M0[83]};
wire [15:0] layer2_N635_lut = 16'hF5F4;
assign M1[635] = layer2_N635_lut[layer2_N635_wire];

wire [3:0] layer2_N636_wire = {M0[139], M0[22], M0[38], M0[8]};
wire [15:0] layer2_N636_lut = 16'h71B2;
assign M1[636] = layer2_N636_lut[layer2_N636_wire];

wire [3:0] layer2_N637_wire = {M0[109], M0[84], M0[94], M0[139]};
wire [15:0] layer2_N637_lut = 16'h0AAB;
assign M1[637] = layer2_N637_lut[layer2_N637_wire];

wire [3:0] layer2_N638_wire = {M0[18], M0[106], M0[103], M0[141]};
wire [15:0] layer2_N638_lut = 16'hF0F8;
assign M1[638] = layer2_N638_lut[layer2_N638_wire];

wire [3:0] layer2_N639_wire = {M0[46], M0[57], M0[99], M0[114]};
wire [15:0] layer2_N639_lut = 16'hE8E8;
assign M1[639] = layer2_N639_lut[layer2_N639_wire];

endmodule
module layer3 (input [639:0] M0, output [159:0] M1);

wire [3:0] layer3_N0_wire = {M0[0], M0[1], M0[2], M0[3]};
wire [15:0] layer3_N0_lut = 16'h22BA;
assign M1[0] = layer3_N0_lut[layer3_N0_wire];

wire [3:0] layer3_N1_wire = {M0[4], M0[5], M0[6], M0[7]};
wire [15:0] layer3_N1_lut = 16'h08CE;
assign M1[1] = layer3_N1_lut[layer3_N1_wire];

wire [3:0] layer3_N2_wire = {M0[8], M0[9], M0[10], M0[11]};
wire [15:0] layer3_N2_lut = 16'hC8EC;
assign M1[2] = layer3_N2_lut[layer3_N2_wire];

wire [3:0] layer3_N3_wire = {M0[12], M0[13], M0[14], M0[15]};
wire [15:0] layer3_N3_lut = 16'h4504;
assign M1[3] = layer3_N3_lut[layer3_N3_wire];

wire [3:0] layer3_N4_wire = {M0[16], M0[17], M0[18], M0[19]};
wire [15:0] layer3_N4_lut = 16'h00E8;
assign M1[4] = layer3_N4_lut[layer3_N4_wire];

wire [3:0] layer3_N5_wire = {M0[20], M0[21], M0[22], M0[23]};
wire [15:0] layer3_N5_lut = 16'h30FA;
assign M1[5] = layer3_N5_lut[layer3_N5_wire];

wire [3:0] layer3_N6_wire = {M0[24], M0[25], M0[26], M0[27]};
wire [15:0] layer3_N6_lut = 16'h0A2B;
assign M1[6] = layer3_N6_lut[layer3_N6_wire];

wire [3:0] layer3_N7_wire = {M0[28], M0[29], M0[30], M0[31]};
wire [15:0] layer3_N7_lut = 16'hD550;
assign M1[7] = layer3_N7_lut[layer3_N7_wire];

wire [3:0] layer3_N8_wire = {M0[32], M0[33], M0[34], M0[35]};
wire [15:0] layer3_N8_lut = 16'h7713;
assign M1[8] = layer3_N8_lut[layer3_N8_wire];

wire [3:0] layer3_N9_wire = {M0[36], M0[37], M0[38], M0[39]};
wire [15:0] layer3_N9_lut = 16'h2ABB;
assign M1[9] = layer3_N9_lut[layer3_N9_wire];

wire [3:0] layer3_N10_wire = {M0[40], M0[41], M0[42], M0[43]};
wire [15:0] layer3_N10_lut = 16'hBA20;
assign M1[10] = layer3_N10_lut[layer3_N10_wire];

wire [3:0] layer3_N11_wire = {M0[44], M0[45], M0[46], M0[47]};
wire [15:0] layer3_N11_lut = 16'h88FE;
assign M1[11] = layer3_N11_lut[layer3_N11_wire];

wire [3:0] layer3_N12_wire = {M0[48], M0[49], M0[50], M0[51]};
wire [15:0] layer3_N12_lut = 16'hCF08;
assign M1[12] = layer3_N12_lut[layer3_N12_wire];

wire [3:0] layer3_N13_wire = {M0[52], M0[53], M0[54], M0[55]};
wire [15:0] layer3_N13_lut = 16'h8A08;
assign M1[13] = layer3_N13_lut[layer3_N13_wire];

wire [3:0] layer3_N14_wire = {M0[56], M0[57], M0[58], M0[59]};
wire [15:0] layer3_N14_lut = 16'h455F;
assign M1[14] = layer3_N14_lut[layer3_N14_wire];

wire [3:0] layer3_N15_wire = {M0[60], M0[61], M0[62], M0[63]};
wire [15:0] layer3_N15_lut = 16'h80E8;
assign M1[15] = layer3_N15_lut[layer3_N15_wire];

wire [3:0] layer3_N16_wire = {M0[64], M0[65], M0[66], M0[67]};
wire [15:0] layer3_N16_lut = 16'h2B3F;
assign M1[16] = layer3_N16_lut[layer3_N16_wire];

wire [3:0] layer3_N17_wire = {M0[68], M0[69], M0[70], M0[71]};
wire [15:0] layer3_N17_lut = 16'hB3FB;
assign M1[17] = layer3_N17_lut[layer3_N17_wire];

wire [3:0] layer3_N18_wire = {M0[72], M0[73], M0[74], M0[75]};
wire [15:0] layer3_N18_lut = 16'hC0EA;
assign M1[18] = layer3_N18_lut[layer3_N18_wire];

wire [3:0] layer3_N19_wire = {M0[76], M0[77], M0[78], M0[79]};
wire [15:0] layer3_N19_lut = 16'hF4FF;
assign M1[19] = layer3_N19_lut[layer3_N19_wire];

wire [3:0] layer3_N20_wire = {M0[80], M0[81], M0[82], M0[83]};
wire [15:0] layer3_N20_lut = 16'hFEE8;
assign M1[20] = layer3_N20_lut[layer3_N20_wire];

wire [3:0] layer3_N21_wire = {M0[84], M0[85], M0[86], M0[87]};
wire [15:0] layer3_N21_lut = 16'h55F7;
assign M1[21] = layer3_N21_lut[layer3_N21_wire];

wire [3:0] layer3_N22_wire = {M0[88], M0[89], M0[90], M0[91]};
wire [15:0] layer3_N22_lut = 16'h0DFF;
assign M1[22] = layer3_N22_lut[layer3_N22_wire];

wire [3:0] layer3_N23_wire = {M0[92], M0[93], M0[94], M0[95]};
wire [15:0] layer3_N23_lut = 16'hE880;
assign M1[23] = layer3_N23_lut[layer3_N23_wire];

wire [3:0] layer3_N24_wire = {M0[96], M0[97], M0[98], M0[99]};
wire [15:0] layer3_N24_lut = 16'h2302;
assign M1[24] = layer3_N24_lut[layer3_N24_wire];

wire [3:0] layer3_N25_wire = {M0[100], M0[101], M0[102], M0[103]};
wire [15:0] layer3_N25_lut = 16'hD880;
assign M1[25] = layer3_N25_lut[layer3_N25_wire];

wire [3:0] layer3_N26_wire = {M0[104], M0[105], M0[106], M0[107]};
wire [15:0] layer3_N26_lut = 16'h2BBF;
assign M1[26] = layer3_N26_lut[layer3_N26_wire];

wire [3:0] layer3_N27_wire = {M0[108], M0[109], M0[110], M0[111]};
wire [15:0] layer3_N27_lut = 16'hDC40;
assign M1[27] = layer3_N27_lut[layer3_N27_wire];

wire [3:0] layer3_N28_wire = {M0[112], M0[113], M0[114], M0[115]};
wire [15:0] layer3_N28_lut = 16'h54D4;
assign M1[28] = layer3_N28_lut[layer3_N28_wire];

wire [3:0] layer3_N29_wire = {M0[116], M0[117], M0[118], M0[119]};
wire [15:0] layer3_N29_lut = 16'h7303;
assign M1[29] = layer3_N29_lut[layer3_N29_wire];

wire [3:0] layer3_N30_wire = {M0[120], M0[121], M0[122], M0[123]};
wire [15:0] layer3_N30_lut = 16'hAA88;
assign M1[30] = layer3_N30_lut[layer3_N30_wire];

wire [3:0] layer3_N31_wire = {M0[124], M0[125], M0[126], M0[127]};
wire [15:0] layer3_N31_lut = 16'hFCE0;
assign M1[31] = layer3_N31_lut[layer3_N31_wire];

wire [3:0] layer3_N32_wire = {M0[128], M0[129], M0[130], M0[131]};
wire [15:0] layer3_N32_lut = 16'hEF8E;
assign M1[32] = layer3_N32_lut[layer3_N32_wire];

wire [3:0] layer3_N33_wire = {M0[132], M0[133], M0[134], M0[135]};
wire [15:0] layer3_N33_lut = 16'h3077;
assign M1[33] = layer3_N33_lut[layer3_N33_wire];

wire [3:0] layer3_N34_wire = {M0[136], M0[137], M0[138], M0[139]};
wire [15:0] layer3_N34_lut = 16'h1701;
assign M1[34] = layer3_N34_lut[layer3_N34_wire];

wire [3:0] layer3_N35_wire = {M0[140], M0[141], M0[142], M0[143]};
wire [15:0] layer3_N35_lut = 16'h232B;
assign M1[35] = layer3_N35_lut[layer3_N35_wire];

wire [3:0] layer3_N36_wire = {M0[144], M0[145], M0[146], M0[147]};
wire [15:0] layer3_N36_lut = 16'hE8DC;
assign M1[36] = layer3_N36_lut[layer3_N36_wire];

wire [3:0] layer3_N37_wire = {M0[148], M0[149], M0[150], M0[151]};
wire [15:0] layer3_N37_lut = 16'h1501;
assign M1[37] = layer3_N37_lut[layer3_N37_wire];

wire [3:0] layer3_N38_wire = {M0[152], M0[153], M0[154], M0[155]};
wire [15:0] layer3_N38_lut = 16'hFEEE;
assign M1[38] = layer3_N38_lut[layer3_N38_wire];

wire [3:0] layer3_N39_wire = {M0[156], M0[157], M0[158], M0[159]};
wire [15:0] layer3_N39_lut = 16'hFF8F;
assign M1[39] = layer3_N39_lut[layer3_N39_wire];

wire [3:0] layer3_N40_wire = {M0[160], M0[161], M0[162], M0[163]};
wire [15:0] layer3_N40_lut = 16'hF2B0;
assign M1[40] = layer3_N40_lut[layer3_N40_wire];

wire [3:0] layer3_N41_wire = {M0[164], M0[165], M0[166], M0[167]};
wire [15:0] layer3_N41_lut = 16'h71F7;
assign M1[41] = layer3_N41_lut[layer3_N41_wire];

wire [3:0] layer3_N42_wire = {M0[168], M0[169], M0[170], M0[171]};
wire [15:0] layer3_N42_lut = 16'h2B02;
assign M1[42] = layer3_N42_lut[layer3_N42_wire];

wire [3:0] layer3_N43_wire = {M0[172], M0[173], M0[174], M0[175]};
wire [15:0] layer3_N43_lut = 16'hBB33;
assign M1[43] = layer3_N43_lut[layer3_N43_wire];

wire [3:0] layer3_N44_wire = {M0[176], M0[177], M0[178], M0[179]};
wire [15:0] layer3_N44_lut = 16'hBF3B;
assign M1[44] = layer3_N44_lut[layer3_N44_wire];

wire [3:0] layer3_N45_wire = {M0[180], M0[181], M0[182], M0[183]};
wire [15:0] layer3_N45_lut = 16'hB2F3;
assign M1[45] = layer3_N45_lut[layer3_N45_wire];

wire [3:0] layer3_N46_wire = {M0[184], M0[185], M0[186], M0[187]};
wire [15:0] layer3_N46_lut = 16'hF771;
assign M1[46] = layer3_N46_lut[layer3_N46_wire];

wire [3:0] layer3_N47_wire = {M0[188], M0[189], M0[190], M0[191]};
wire [15:0] layer3_N47_lut = 16'h71F7;
assign M1[47] = layer3_N47_lut[layer3_N47_wire];

wire [3:0] layer3_N48_wire = {M0[192], M0[193], M0[194], M0[195]};
wire [15:0] layer3_N48_lut = 16'hA220;
assign M1[48] = layer3_N48_lut[layer3_N48_wire];

wire [3:0] layer3_N49_wire = {M0[196], M0[197], M0[198], M0[199]};
wire [15:0] layer3_N49_lut = 16'h2B02;
assign M1[49] = layer3_N49_lut[layer3_N49_wire];

wire [3:0] layer3_N50_wire = {M0[200], M0[201], M0[202], M0[203]};
wire [15:0] layer3_N50_lut = 16'hF220;
assign M1[50] = layer3_N50_lut[layer3_N50_wire];

wire [3:0] layer3_N51_wire = {M0[204], M0[205], M0[206], M0[207]};
wire [15:0] layer3_N51_lut = 16'hAB2A;
assign M1[51] = layer3_N51_lut[layer3_N51_wire];

wire [3:0] layer3_N52_wire = {M0[208], M0[209], M0[210], M0[211]};
wire [15:0] layer3_N52_lut = 16'h20BB;
assign M1[52] = layer3_N52_lut[layer3_N52_wire];

wire [3:0] layer3_N53_wire = {M0[212], M0[213], M0[214], M0[215]};
wire [15:0] layer3_N53_lut = 16'h80C8;
assign M1[53] = layer3_N53_lut[layer3_N53_wire];

wire [3:0] layer3_N54_wire = {M0[216], M0[217], M0[218], M0[219]};
wire [15:0] layer3_N54_lut = 16'hBA20;
assign M1[54] = layer3_N54_lut[layer3_N54_wire];

wire [3:0] layer3_N55_wire = {M0[220], M0[221], M0[222], M0[223]};
wire [15:0] layer3_N55_lut = 16'h7F17;
assign M1[55] = layer3_N55_lut[layer3_N55_wire];

wire [3:0] layer3_N56_wire = {M0[224], M0[225], M0[226], M0[227]};
wire [15:0] layer3_N56_lut = 16'hAB2A;
assign M1[56] = layer3_N56_lut[layer3_N56_wire];

wire [3:0] layer3_N57_wire = {M0[228], M0[229], M0[230], M0[231]};
wire [15:0] layer3_N57_lut = 16'hA220;
assign M1[57] = layer3_N57_lut[layer3_N57_wire];

wire [3:0] layer3_N58_wire = {M0[232], M0[233], M0[234], M0[235]};
wire [15:0] layer3_N58_lut = 16'hE880;
assign M1[58] = layer3_N58_lut[layer3_N58_wire];

wire [3:0] layer3_N59_wire = {M0[236], M0[237], M0[238], M0[239]};
wire [15:0] layer3_N59_lut = 16'hFEE8;
assign M1[59] = layer3_N59_lut[layer3_N59_wire];

wire [3:0] layer3_N60_wire = {M0[240], M0[241], M0[242], M0[243]};
wire [15:0] layer3_N60_lut = 16'h20B2;
assign M1[60] = layer3_N60_lut[layer3_N60_wire];

wire [3:0] layer3_N61_wire = {M0[244], M0[245], M0[246], M0[247]};
wire [15:0] layer3_N61_lut = 16'hFDD4;
assign M1[61] = layer3_N61_lut[layer3_N61_wire];

wire [3:0] layer3_N62_wire = {M0[248], M0[249], M0[250], M0[251]};
wire [15:0] layer3_N62_lut = 16'h40D5;
assign M1[62] = layer3_N62_lut[layer3_N62_wire];

wire [3:0] layer3_N63_wire = {M0[252], M0[253], M0[254], M0[255]};
wire [15:0] layer3_N63_lut = 16'hBF0B;
assign M1[63] = layer3_N63_lut[layer3_N63_wire];

wire [3:0] layer3_N64_wire = {M0[256], M0[257], M0[258], M0[259]};
wire [15:0] layer3_N64_lut = 16'hA8F8;
assign M1[64] = layer3_N64_lut[layer3_N64_wire];

wire [3:0] layer3_N65_wire = {M0[260], M0[261], M0[262], M0[263]};
wire [15:0] layer3_N65_lut = 16'h137F;
assign M1[65] = layer3_N65_lut[layer3_N65_wire];

wire [3:0] layer3_N66_wire = {M0[264], M0[265], M0[266], M0[267]};
wire [15:0] layer3_N66_lut = 16'h45DF;
assign M1[66] = layer3_N66_lut[layer3_N66_wire];

wire [3:0] layer3_N67_wire = {M0[268], M0[269], M0[270], M0[271]};
wire [15:0] layer3_N67_lut = 16'h054D;
assign M1[67] = layer3_N67_lut[layer3_N67_wire];

wire [3:0] layer3_N68_wire = {M0[272], M0[273], M0[274], M0[275]};
wire [15:0] layer3_N68_lut = 16'hEF00;
assign M1[68] = layer3_N68_lut[layer3_N68_wire];

wire [3:0] layer3_N69_wire = {M0[276], M0[277], M0[278], M0[279]};
wire [15:0] layer3_N69_lut = 16'h40D5;
assign M1[69] = layer3_N69_lut[layer3_N69_wire];

wire [3:0] layer3_N70_wire = {M0[280], M0[281], M0[282], M0[283]};
wire [15:0] layer3_N70_lut = 16'hC8C0;
assign M1[70] = layer3_N70_lut[layer3_N70_wire];

wire [3:0] layer3_N71_wire = {M0[284], M0[285], M0[286], M0[287]};
wire [15:0] layer3_N71_lut = 16'h005F;
assign M1[71] = layer3_N71_lut[layer3_N71_wire];

wire [3:0] layer3_N72_wire = {M0[288], M0[289], M0[290], M0[291]};
wire [15:0] layer3_N72_lut = 16'h7177;
assign M1[72] = layer3_N72_lut[layer3_N72_wire];

wire [3:0] layer3_N73_wire = {M0[292], M0[293], M0[294], M0[295]};
wire [15:0] layer3_N73_lut = 16'h3222;
assign M1[73] = layer3_N73_lut[layer3_N73_wire];

wire [3:0] layer3_N74_wire = {M0[296], M0[297], M0[298], M0[299]};
wire [15:0] layer3_N74_lut = 16'hA2B2;
assign M1[74] = layer3_N74_lut[layer3_N74_wire];

wire [3:0] layer3_N75_wire = {M0[300], M0[301], M0[302], M0[303]};
wire [15:0] layer3_N75_lut = 16'h0A8F;
assign M1[75] = layer3_N75_lut[layer3_N75_wire];

wire [3:0] layer3_N76_wire = {M0[304], M0[305], M0[306], M0[307]};
wire [15:0] layer3_N76_lut = 16'h20FA;
assign M1[76] = layer3_N76_lut[layer3_N76_wire];

wire [3:0] layer3_N77_wire = {M0[308], M0[309], M0[310], M0[311]};
wire [15:0] layer3_N77_lut = 16'hCEEE;
assign M1[77] = layer3_N77_lut[layer3_N77_wire];

wire [3:0] layer3_N78_wire = {M0[312], M0[313], M0[314], M0[315]};
wire [15:0] layer3_N78_lut = 16'h173F;
assign M1[78] = layer3_N78_lut[layer3_N78_wire];

wire [3:0] layer3_N79_wire = {M0[316], M0[317], M0[318], M0[319]};
wire [15:0] layer3_N79_lut = 16'h177F;
assign M1[79] = layer3_N79_lut[layer3_N79_wire];

wire [3:0] layer3_N80_wire = {M0[320], M0[321], M0[322], M0[323]};
wire [15:0] layer3_N80_lut = 16'hF544;
assign M1[80] = layer3_N80_lut[layer3_N80_wire];

wire [3:0] layer3_N81_wire = {M0[324], M0[325], M0[326], M0[327]};
wire [15:0] layer3_N81_lut = 16'h71F7;
assign M1[81] = layer3_N81_lut[layer3_N81_wire];

wire [3:0] layer3_N82_wire = {M0[328], M0[329], M0[330], M0[331]};
wire [15:0] layer3_N82_lut = 16'h3020;
assign M1[82] = layer3_N82_lut[layer3_N82_wire];

wire [3:0] layer3_N83_wire = {M0[332], M0[333], M0[334], M0[335]};
wire [15:0] layer3_N83_lut = 16'hFC40;
assign M1[83] = layer3_N83_lut[layer3_N83_wire];

wire [3:0] layer3_N84_wire = {M0[336], M0[337], M0[338], M0[339]};
wire [15:0] layer3_N84_lut = 16'hF2FB;
assign M1[84] = layer3_N84_lut[layer3_N84_wire];

wire [3:0] layer3_N85_wire = {M0[340], M0[341], M0[342], M0[343]};
wire [15:0] layer3_N85_lut = 16'h0C0F;
assign M1[85] = layer3_N85_lut[layer3_N85_wire];

wire [3:0] layer3_N86_wire = {M0[344], M0[345], M0[346], M0[347]};
wire [15:0] layer3_N86_lut = 16'h3F17;
assign M1[86] = layer3_N86_lut[layer3_N86_wire];

wire [3:0] layer3_N87_wire = {M0[348], M0[349], M0[350], M0[351]};
wire [15:0] layer3_N87_lut = 16'hFBBA;
assign M1[87] = layer3_N87_lut[layer3_N87_wire];

wire [3:0] layer3_N88_wire = {M0[352], M0[353], M0[354], M0[355]};
wire [15:0] layer3_N88_lut = 16'h40C4;
assign M1[88] = layer3_N88_lut[layer3_N88_wire];

wire [3:0] layer3_N89_wire = {M0[356], M0[357], M0[358], M0[359]};
wire [15:0] layer3_N89_lut = 16'h7731;
assign M1[89] = layer3_N89_lut[layer3_N89_wire];

wire [3:0] layer3_N90_wire = {M0[360], M0[361], M0[362], M0[363]};
wire [15:0] layer3_N90_lut = 16'h00CE;
assign M1[90] = layer3_N90_lut[layer3_N90_wire];

wire [3:0] layer3_N91_wire = {M0[364], M0[365], M0[366], M0[367]};
wire [15:0] layer3_N91_lut = 16'h7331;
assign M1[91] = layer3_N91_lut[layer3_N91_wire];

wire [3:0] layer3_N92_wire = {M0[368], M0[369], M0[370], M0[371]};
wire [15:0] layer3_N92_lut = 16'hAF2A;
assign M1[92] = layer3_N92_lut[layer3_N92_wire];

wire [3:0] layer3_N93_wire = {M0[372], M0[373], M0[374], M0[375]};
wire [15:0] layer3_N93_lut = 16'h80EA;
assign M1[93] = layer3_N93_lut[layer3_N93_wire];

wire [3:0] layer3_N94_wire = {M0[376], M0[377], M0[378], M0[379]};
wire [15:0] layer3_N94_lut = 16'hC8FE;
assign M1[94] = layer3_N94_lut[layer3_N94_wire];

wire [3:0] layer3_N95_wire = {M0[380], M0[381], M0[382], M0[383]};
wire [15:0] layer3_N95_lut = 16'h4D00;
assign M1[95] = layer3_N95_lut[layer3_N95_wire];

wire [3:0] layer3_N96_wire = {M0[384], M0[385], M0[386], M0[387]};
wire [15:0] layer3_N96_lut = 16'hAAFA;
assign M1[96] = layer3_N96_lut[layer3_N96_wire];

wire [3:0] layer3_N97_wire = {M0[388], M0[389], M0[390], M0[391]};
wire [15:0] layer3_N97_lut = 16'h5440;
assign M1[97] = layer3_N97_lut[layer3_N97_wire];

wire [3:0] layer3_N98_wire = {M0[392], M0[393], M0[394], M0[395]};
wire [15:0] layer3_N98_lut = 16'h1501;
assign M1[98] = layer3_N98_lut[layer3_N98_wire];

wire [3:0] layer3_N99_wire = {M0[396], M0[397], M0[398], M0[399]};
wire [15:0] layer3_N99_lut = 16'h0B00;
assign M1[99] = layer3_N99_lut[layer3_N99_wire];

wire [3:0] layer3_N100_wire = {M0[400], M0[401], M0[402], M0[403]};
wire [15:0] layer3_N100_lut = 16'h177F;
assign M1[100] = layer3_N100_lut[layer3_N100_wire];

wire [3:0] layer3_N101_wire = {M0[404], M0[405], M0[406], M0[407]};
wire [15:0] layer3_N101_lut = 16'hFBB0;
assign M1[101] = layer3_N101_lut[layer3_N101_wire];

wire [3:0] layer3_N102_wire = {M0[408], M0[409], M0[410], M0[411]};
wire [15:0] layer3_N102_lut = 16'h173F;
assign M1[102] = layer3_N102_lut[layer3_N102_wire];

wire [3:0] layer3_N103_wire = {M0[412], M0[413], M0[414], M0[415]};
wire [15:0] layer3_N103_lut = 16'h10F1;
assign M1[103] = layer3_N103_lut[layer3_N103_wire];

wire [3:0] layer3_N104_wire = {M0[416], M0[417], M0[418], M0[419]};
wire [15:0] layer3_N104_lut = 16'h0C00;
assign M1[104] = layer3_N104_lut[layer3_N104_wire];

wire [3:0] layer3_N105_wire = {M0[420], M0[421], M0[422], M0[423]};
wire [15:0] layer3_N105_lut = 16'h0C4D;
assign M1[105] = layer3_N105_lut[layer3_N105_wire];

wire [3:0] layer3_N106_wire = {M0[424], M0[425], M0[426], M0[427]};
wire [15:0] layer3_N106_lut = 16'h017F;
assign M1[106] = layer3_N106_lut[layer3_N106_wire];

wire [3:0] layer3_N107_wire = {M0[428], M0[429], M0[430], M0[431]};
wire [15:0] layer3_N107_lut = 16'hFEE8;
assign M1[107] = layer3_N107_lut[layer3_N107_wire];

wire [3:0] layer3_N108_wire = {M0[432], M0[433], M0[434], M0[435]};
wire [15:0] layer3_N108_lut = 16'h0A3B;
assign M1[108] = layer3_N108_lut[layer3_N108_wire];

wire [3:0] layer3_N109_wire = {M0[436], M0[437], M0[438], M0[439]};
wire [15:0] layer3_N109_lut = 16'h1515;
assign M1[109] = layer3_N109_lut[layer3_N109_wire];

wire [3:0] layer3_N110_wire = {M0[440], M0[441], M0[442], M0[443]};
wire [15:0] layer3_N110_lut = 16'h80FC;
assign M1[110] = layer3_N110_lut[layer3_N110_wire];

wire [3:0] layer3_N111_wire = {M0[444], M0[445], M0[446], M0[447]};
wire [15:0] layer3_N111_lut = 16'h88E8;
assign M1[111] = layer3_N111_lut[layer3_N111_wire];

wire [3:0] layer3_N112_wire = {M0[448], M0[449], M0[450], M0[451]};
wire [15:0] layer3_N112_lut = 16'hE8FE;
assign M1[112] = layer3_N112_lut[layer3_N112_wire];

wire [3:0] layer3_N113_wire = {M0[452], M0[453], M0[454], M0[455]};
wire [15:0] layer3_N113_lut = 16'h4504;
assign M1[113] = layer3_N113_lut[layer3_N113_wire];

wire [3:0] layer3_N114_wire = {M0[456], M0[457], M0[458], M0[459]};
wire [15:0] layer3_N114_lut = 16'h3F07;
assign M1[114] = layer3_N114_lut[layer3_N114_wire];

wire [3:0] layer3_N115_wire = {M0[460], M0[461], M0[462], M0[463]};
wire [15:0] layer3_N115_lut = 16'hCA88;
assign M1[115] = layer3_N115_lut[layer3_N115_wire];

wire [3:0] layer3_N116_wire = {M0[464], M0[465], M0[466], M0[467]};
wire [15:0] layer3_N116_lut = 16'h2222;
assign M1[116] = layer3_N116_lut[layer3_N116_wire];

wire [3:0] layer3_N117_wire = {M0[468], M0[469], M0[470], M0[471]};
wire [15:0] layer3_N117_lut = 16'h032B;
assign M1[117] = layer3_N117_lut[layer3_N117_wire];

wire [3:0] layer3_N118_wire = {M0[472], M0[473], M0[474], M0[475]};
wire [15:0] layer3_N118_lut = 16'hC4DC;
assign M1[118] = layer3_N118_lut[layer3_N118_wire];

wire [3:0] layer3_N119_wire = {M0[476], M0[477], M0[478], M0[479]};
wire [15:0] layer3_N119_lut = 16'hDDCD;
assign M1[119] = layer3_N119_lut[layer3_N119_wire];

wire [3:0] layer3_N120_wire = {M0[480], M0[481], M0[482], M0[483]};
wire [15:0] layer3_N120_lut = 16'h0C8E;
assign M1[120] = layer3_N120_lut[layer3_N120_wire];

wire [3:0] layer3_N121_wire = {M0[484], M0[485], M0[486], M0[487]};
wire [15:0] layer3_N121_lut = 16'hDD44;
assign M1[121] = layer3_N121_lut[layer3_N121_wire];

wire [3:0] layer3_N122_wire = {M0[488], M0[489], M0[490], M0[491]};
wire [15:0] layer3_N122_lut = 16'hE880;
assign M1[122] = layer3_N122_lut[layer3_N122_wire];

wire [3:0] layer3_N123_wire = {M0[492], M0[493], M0[494], M0[495]};
wire [15:0] layer3_N123_lut = 16'hF2B3;
assign M1[123] = layer3_N123_lut[layer3_N123_wire];

wire [3:0] layer3_N124_wire = {M0[496], M0[497], M0[498], M0[499]};
wire [15:0] layer3_N124_lut = 16'h40D0;
assign M1[124] = layer3_N124_lut[layer3_N124_wire];

wire [3:0] layer3_N125_wire = {M0[500], M0[501], M0[502], M0[503]};
wire [15:0] layer3_N125_lut = 16'h0445;
assign M1[125] = layer3_N125_lut[layer3_N125_wire];

wire [3:0] layer3_N126_wire = {M0[504], M0[505], M0[506], M0[507]};
wire [15:0] layer3_N126_lut = 16'hCE08;
assign M1[126] = layer3_N126_lut[layer3_N126_wire];

wire [3:0] layer3_N127_wire = {M0[508], M0[509], M0[510], M0[511]};
wire [15:0] layer3_N127_lut = 16'h13FF;
assign M1[127] = layer3_N127_lut[layer3_N127_wire];

wire [3:0] layer3_N128_wire = {M0[512], M0[513], M0[514], M0[515]};
wire [15:0] layer3_N128_lut = 16'h4505;
assign M1[128] = layer3_N128_lut[layer3_N128_wire];

wire [3:0] layer3_N129_wire = {M0[516], M0[517], M0[518], M0[519]};
wire [15:0] layer3_N129_lut = 16'h1301;
assign M1[129] = layer3_N129_lut[layer3_N129_wire];

wire [3:0] layer3_N130_wire = {M0[520], M0[521], M0[522], M0[523]};
wire [15:0] layer3_N130_lut = 16'h050D;
assign M1[130] = layer3_N130_lut[layer3_N130_wire];

wire [3:0] layer3_N131_wire = {M0[524], M0[525], M0[526], M0[527]};
wire [15:0] layer3_N131_lut = 16'hFF15;
assign M1[131] = layer3_N131_lut[layer3_N131_wire];

wire [3:0] layer3_N132_wire = {M0[528], M0[529], M0[530], M0[531]};
wire [15:0] layer3_N132_lut = 16'h1703;
assign M1[132] = layer3_N132_lut[layer3_N132_wire];

wire [3:0] layer3_N133_wire = {M0[532], M0[533], M0[534], M0[535]};
wire [15:0] layer3_N133_lut = 16'hCF0C;
assign M1[133] = layer3_N133_lut[layer3_N133_wire];

wire [3:0] layer3_N134_wire = {M0[536], M0[537], M0[538], M0[539]};
wire [15:0] layer3_N134_lut = 16'h70F7;
assign M1[134] = layer3_N134_lut[layer3_N134_wire];

wire [3:0] layer3_N135_wire = {M0[540], M0[541], M0[542], M0[543]};
wire [15:0] layer3_N135_lut = 16'h7551;
assign M1[135] = layer3_N135_lut[layer3_N135_wire];

wire [3:0] layer3_N136_wire = {M0[544], M0[545], M0[546], M0[547]};
wire [15:0] layer3_N136_lut = 16'h22AF;
assign M1[136] = layer3_N136_lut[layer3_N136_wire];

wire [3:0] layer3_N137_wire = {M0[548], M0[549], M0[550], M0[551]};
wire [15:0] layer3_N137_lut = 16'hE888;
assign M1[137] = layer3_N137_lut[layer3_N137_wire];

wire [3:0] layer3_N138_wire = {M0[552], M0[553], M0[554], M0[555]};
wire [15:0] layer3_N138_lut = 16'hE8FC;
assign M1[138] = layer3_N138_lut[layer3_N138_wire];

wire [3:0] layer3_N139_wire = {M0[556], M0[557], M0[558], M0[559]};
wire [15:0] layer3_N139_lut = 16'h5D4D;
assign M1[139] = layer3_N139_lut[layer3_N139_wire];

wire [3:0] layer3_N140_wire = {M0[560], M0[561], M0[562], M0[563]};
wire [15:0] layer3_N140_lut = 16'h1557;
assign M1[140] = layer3_N140_lut[layer3_N140_wire];

wire [3:0] layer3_N141_wire = {M0[564], M0[565], M0[566], M0[567]};
wire [15:0] layer3_N141_lut = 16'h80D8;
assign M1[141] = layer3_N141_lut[layer3_N141_wire];

wire [3:0] layer3_N142_wire = {M0[568], M0[569], M0[570], M0[571]};
wire [15:0] layer3_N142_lut = 16'hB2FB;
assign M1[142] = layer3_N142_lut[layer3_N142_wire];

wire [3:0] layer3_N143_wire = {M0[572], M0[573], M0[574], M0[575]};
wire [15:0] layer3_N143_lut = 16'hBB30;
assign M1[143] = layer3_N143_lut[layer3_N143_wire];

wire [3:0] layer3_N144_wire = {M0[576], M0[577], M0[578], M0[579]};
wire [15:0] layer3_N144_lut = 16'hDCFC;
assign M1[144] = layer3_N144_lut[layer3_N144_wire];

wire [3:0] layer3_N145_wire = {M0[580], M0[581], M0[582], M0[583]};
wire [15:0] layer3_N145_lut = 16'hEF8E;
assign M1[145] = layer3_N145_lut[layer3_N145_wire];

wire [3:0] layer3_N146_wire = {M0[584], M0[585], M0[586], M0[587]};
wire [15:0] layer3_N146_lut = 16'h2BBF;
assign M1[146] = layer3_N146_lut[layer3_N146_wire];

wire [3:0] layer3_N147_wire = {M0[588], M0[589], M0[590], M0[591]};
wire [15:0] layer3_N147_lut = 16'h2302;
assign M1[147] = layer3_N147_lut[layer3_N147_wire];

wire [3:0] layer3_N148_wire = {M0[592], M0[593], M0[594], M0[595]};
wire [15:0] layer3_N148_lut = 16'hF4C0;
assign M1[148] = layer3_N148_lut[layer3_N148_wire];

wire [3:0] layer3_N149_wire = {M0[596], M0[597], M0[598], M0[599]};
wire [15:0] layer3_N149_lut = 16'h44F4;
assign M1[149] = layer3_N149_lut[layer3_N149_wire];

wire [3:0] layer3_N150_wire = {M0[600], M0[601], M0[602], M0[603]};
wire [15:0] layer3_N150_lut = 16'hAF08;
assign M1[150] = layer3_N150_lut[layer3_N150_wire];

wire [3:0] layer3_N151_wire = {M0[604], M0[605], M0[606], M0[607]};
wire [15:0] layer3_N151_lut = 16'h8EEF;
assign M1[151] = layer3_N151_lut[layer3_N151_wire];

wire [3:0] layer3_N152_wire = {M0[608], M0[609], M0[610], M0[611]};
wire [15:0] layer3_N152_lut = 16'h45DF;
assign M1[152] = layer3_N152_lut[layer3_N152_wire];

wire [3:0] layer3_N153_wire = {M0[612], M0[613], M0[614], M0[615]};
wire [15:0] layer3_N153_lut = 16'hFEA8;
assign M1[153] = layer3_N153_lut[layer3_N153_wire];

wire [3:0] layer3_N154_wire = {M0[616], M0[617], M0[618], M0[619]};
wire [15:0] layer3_N154_lut = 16'h8EEF;
assign M1[154] = layer3_N154_lut[layer3_N154_wire];

wire [3:0] layer3_N155_wire = {M0[620], M0[621], M0[622], M0[623]};
wire [15:0] layer3_N155_lut = 16'h30FB;
assign M1[155] = layer3_N155_lut[layer3_N155_wire];

wire [3:0] layer3_N156_wire = {M0[624], M0[625], M0[626], M0[627]};
wire [15:0] layer3_N156_lut = 16'hA0F8;
assign M1[156] = layer3_N156_lut[layer3_N156_wire];

wire [3:0] layer3_N157_wire = {M0[628], M0[629], M0[630], M0[631]};
wire [15:0] layer3_N157_lut = 16'h0317;
assign M1[157] = layer3_N157_lut[layer3_N157_wire];

wire [3:0] layer3_N158_wire = {M0[632], M0[633], M0[634], M0[635]};
wire [15:0] layer3_N158_lut = 16'hF8C0;
assign M1[158] = layer3_N158_lut[layer3_N158_wire];

wire [3:0] layer3_N159_wire = {M0[636], M0[637], M0[638], M0[639]};
wire [15:0] layer3_N159_lut = 16'h8AEE;
assign M1[159] = layer3_N159_lut[layer3_N159_wire];

endmodule
module layer4 (input [159:0] M0, output [39:0] M1);

wire [3:0] layer4_N0_wire = {M0[0], M0[1], M0[2], M0[3]};
wire [15:0] layer4_N0_lut = 16'h1777;
assign M1[0] = layer4_N0_lut[layer4_N0_wire];

wire [3:0] layer4_N1_wire = {M0[4], M0[5], M0[6], M0[7]};
wire [15:0] layer4_N1_lut = 16'h0177;
assign M1[1] = layer4_N1_lut[layer4_N1_wire];

wire [3:0] layer4_N2_wire = {M0[8], M0[9], M0[10], M0[11]};
wire [15:0] layer4_N2_lut = 16'h004D;
assign M1[2] = layer4_N2_lut[layer4_N2_wire];

wire [3:0] layer4_N3_wire = {M0[12], M0[13], M0[14], M0[15]};
wire [15:0] layer4_N3_lut = 16'hDF4D;
assign M1[3] = layer4_N3_lut[layer4_N3_wire];

wire [3:0] layer4_N4_wire = {M0[16], M0[17], M0[18], M0[19]};
wire [15:0] layer4_N4_lut = 16'hFBB2;
assign M1[4] = layer4_N4_lut[layer4_N4_wire];

wire [3:0] layer4_N5_wire = {M0[20], M0[21], M0[22], M0[23]};
wire [15:0] layer4_N5_lut = 16'hF5D4;
assign M1[5] = layer4_N5_lut[layer4_N5_wire];

wire [3:0] layer4_N6_wire = {M0[24], M0[25], M0[26], M0[27]};
wire [15:0] layer4_N6_lut = 16'hD4FD;
assign M1[6] = layer4_N6_lut[layer4_N6_wire];

wire [3:0] layer4_N7_wire = {M0[28], M0[29], M0[30], M0[31]};
wire [15:0] layer4_N7_lut = 16'hD440;
assign M1[7] = layer4_N7_lut[layer4_N7_wire];

wire [3:0] layer4_N8_wire = {M0[32], M0[33], M0[34], M0[35]};
wire [15:0] layer4_N8_lut = 16'h7110;
assign M1[8] = layer4_N8_lut[layer4_N8_wire];

wire [3:0] layer4_N9_wire = {M0[36], M0[37], M0[38], M0[39]};
wire [15:0] layer4_N9_lut = 16'h1071;
assign M1[9] = layer4_N9_lut[layer4_N9_wire];

wire [3:0] layer4_N10_wire = {M0[40], M0[41], M0[42], M0[43]};
wire [15:0] layer4_N10_lut = 16'h0C4D;
assign M1[10] = layer4_N10_lut[layer4_N10_wire];

wire [3:0] layer4_N11_wire = {M0[44], M0[45], M0[46], M0[47]};
wire [15:0] layer4_N11_lut = 16'h10F1;
assign M1[11] = layer4_N11_lut[layer4_N11_wire];

wire [3:0] layer4_N12_wire = {M0[48], M0[49], M0[50], M0[51]};
wire [15:0] layer4_N12_lut = 16'h8EAF;
assign M1[12] = layer4_N12_lut[layer4_N12_wire];

wire [3:0] layer4_N13_wire = {M0[52], M0[53], M0[54], M0[55]};
wire [15:0] layer4_N13_lut = 16'hDCC4;
assign M1[13] = layer4_N13_lut[layer4_N13_wire];

wire [3:0] layer4_N14_wire = {M0[56], M0[57], M0[58], M0[59]};
wire [15:0] layer4_N14_lut = 16'hBB2B;
assign M1[14] = layer4_N14_lut[layer4_N14_wire];

wire [3:0] layer4_N15_wire = {M0[60], M0[61], M0[62], M0[63]};
wire [15:0] layer4_N15_lut = 16'h4D04;
assign M1[15] = layer4_N15_lut[layer4_N15_wire];

wire [3:0] layer4_N16_wire = {M0[64], M0[65], M0[66], M0[67]};
wire [15:0] layer4_N16_lut = 16'hD4FD;
assign M1[16] = layer4_N16_lut[layer4_N16_wire];

wire [3:0] layer4_N17_wire = {M0[68], M0[69], M0[70], M0[71]};
wire [15:0] layer4_N17_lut = 16'hE800;
assign M1[17] = layer4_N17_lut[layer4_N17_wire];

wire [3:0] layer4_N18_wire = {M0[72], M0[73], M0[74], M0[75]};
wire [15:0] layer4_N18_lut = 16'h7F17;
assign M1[18] = layer4_N18_lut[layer4_N18_wire];

wire [3:0] layer4_N19_wire = {M0[76], M0[77], M0[78], M0[79]};
wire [15:0] layer4_N19_lut = 16'h3711;
assign M1[19] = layer4_N19_lut[layer4_N19_wire];

wire [3:0] layer4_N20_wire = {M0[80], M0[81], M0[82], M0[83]};
wire [15:0] layer4_N20_lut = 16'h8E00;
assign M1[20] = layer4_N20_lut[layer4_N20_wire];

wire [3:0] layer4_N21_wire = {M0[84], M0[85], M0[86], M0[87]};
wire [15:0] layer4_N21_lut = 16'h1071;
assign M1[21] = layer4_N21_lut[layer4_N21_wire];

wire [3:0] layer4_N22_wire = {M0[88], M0[89], M0[90], M0[91]};
wire [15:0] layer4_N22_lut = 16'hD440;
assign M1[22] = layer4_N22_lut[layer4_N22_wire];

wire [3:0] layer4_N23_wire = {M0[92], M0[93], M0[94], M0[95]};
wire [15:0] layer4_N23_lut = 16'hCE8E;
assign M1[23] = layer4_N23_lut[layer4_N23_wire];

wire [3:0] layer4_N24_wire = {M0[96], M0[97], M0[98], M0[99]};
wire [15:0] layer4_N24_lut = 16'hC8FE;
assign M1[24] = layer4_N24_lut[layer4_N24_wire];

wire [3:0] layer4_N25_wire = {M0[100], M0[101], M0[102], M0[103]};
wire [15:0] layer4_N25_lut = 16'h022B;
assign M1[25] = layer4_N25_lut[layer4_N25_wire];

wire [3:0] layer4_N26_wire = {M0[104], M0[105], M0[106], M0[107]};
wire [15:0] layer4_N26_lut = 16'h2A2B;
assign M1[26] = layer4_N26_lut[layer4_N26_wire];

wire [3:0] layer4_N27_wire = {M0[108], M0[109], M0[110], M0[111]};
wire [15:0] layer4_N27_lut = 16'h30B2;
assign M1[27] = layer4_N27_lut[layer4_N27_wire];

wire [3:0] layer4_N28_wire = {M0[112], M0[113], M0[114], M0[115]};
wire [15:0] layer4_N28_lut = 16'h20B3;
assign M1[28] = layer4_N28_lut[layer4_N28_wire];

wire [3:0] layer4_N29_wire = {M0[116], M0[117], M0[118], M0[119]};
wire [15:0] layer4_N29_lut = 16'h137F;
assign M1[29] = layer4_N29_lut[layer4_N29_wire];

wire [3:0] layer4_N30_wire = {M0[120], M0[121], M0[122], M0[123]};
wire [15:0] layer4_N30_lut = 16'h033F;
assign M1[30] = layer4_N30_lut[layer4_N30_wire];

wire [3:0] layer4_N31_wire = {M0[124], M0[125], M0[126], M0[127]};
wire [15:0] layer4_N31_lut = 16'hDDD4;
assign M1[31] = layer4_N31_lut[layer4_N31_wire];

wire [3:0] layer4_N32_wire = {M0[128], M0[129], M0[130], M0[131]};
wire [15:0] layer4_N32_lut = 16'h2BAF;
assign M1[32] = layer4_N32_lut[layer4_N32_wire];

wire [3:0] layer4_N33_wire = {M0[132], M0[133], M0[134], M0[135]};
wire [15:0] layer4_N33_lut = 16'h5705;
assign M1[33] = layer4_N33_lut[layer4_N33_wire];

wire [3:0] layer4_N34_wire = {M0[136], M0[137], M0[138], M0[139]};
wire [15:0] layer4_N34_lut = 16'h50D4;
assign M1[34] = layer4_N34_lut[layer4_N34_wire];

wire [3:0] layer4_N35_wire = {M0[140], M0[141], M0[142], M0[143]};
wire [15:0] layer4_N35_lut = 16'hCD04;
assign M1[35] = layer4_N35_lut[layer4_N35_wire];

wire [3:0] layer4_N36_wire = {M0[144], M0[145], M0[146], M0[147]};
wire [15:0] layer4_N36_lut = 16'h2BAF;
assign M1[36] = layer4_N36_lut[layer4_N36_wire];

wire [3:0] layer4_N37_wire = {M0[148], M0[149], M0[150], M0[151]};
wire [15:0] layer4_N37_lut = 16'h071F;
assign M1[37] = layer4_N37_lut[layer4_N37_wire];

wire [3:0] layer4_N38_wire = {M0[152], M0[153], M0[154], M0[155]};
wire [15:0] layer4_N38_lut = 16'hD440;
assign M1[38] = layer4_N38_lut[layer4_N38_wire];

wire [3:0] layer4_N39_wire = {M0[156], M0[157], M0[158], M0[159]};
wire [15:0] layer4_N39_lut = 16'hEF8E;
assign M1[39] = layer4_N39_lut[layer4_N39_wire];

endmodule
module layer5 (input [39:0] M0, output [59:0] M1);

wire [3:0] layer5_N0_wire = {M0[0], M0[1], M0[2], M0[3]};
wire [15:0] layer5_N0_lut_0 = 16'hCDE5;
wire [15:0] layer5_N0_lut_1 = 16'h6DC9;
wire [15:0] layer5_N0_lut_2 = 16'h6DC9;
wire [15:0] layer5_N0_lut_3 = 16'h245F;
wire [15:0] layer5_N0_lut_4 = 16'h0004;
wire [15:0] layer5_N0_lut_5 = 16'hDFFF;
assign M1[0] = layer5_N0_lut_0[layer5_N0_wire];
assign M1[1] = layer5_N0_lut_1[layer5_N0_wire];
assign M1[2] = layer5_N0_lut_2[layer5_N0_wire];
assign M1[3] = layer5_N0_lut_3[layer5_N0_wire];
assign M1[4] = layer5_N0_lut_4[layer5_N0_wire];
assign M1[5] = layer5_N0_lut_5[layer5_N0_wire];

wire [3:0] layer5_N1_wire = {M0[4], M0[5], M0[6], M0[7]};
wire [15:0] layer5_N1_lut_0 = 16'h452F;
wire [15:0] layer5_N1_lut_1 = 16'h9C6B;
wire [15:0] layer5_N1_lut_2 = 16'h002B;
wire [15:0] layer5_N1_lut_3 = 16'h69BD;
wire [15:0] layer5_N1_lut_4 = 16'h4202;
wire [15:0] layer5_N1_lut_5 = 16'hBFFF;
assign M1[6] = layer5_N1_lut_0[layer5_N1_wire];
assign M1[7] = layer5_N1_lut_1[layer5_N1_wire];
assign M1[8] = layer5_N1_lut_2[layer5_N1_wire];
assign M1[9] = layer5_N1_lut_3[layer5_N1_wire];
assign M1[10] = layer5_N1_lut_4[layer5_N1_wire];
assign M1[11] = layer5_N1_lut_5[layer5_N1_wire];

wire [3:0] layer5_N2_wire = {M0[8], M0[9], M0[10], M0[11]};
wire [15:0] layer5_N2_lut_0 = 16'hFFA7;
wire [15:0] layer5_N2_lut_1 = 16'h694E;
wire [15:0] layer5_N2_lut_2 = 16'hE9EE;
wire [15:0] layer5_N2_lut_3 = 16'h8078;
wire [15:0] layer5_N2_lut_4 = 16'h0180;
wire [15:0] layer5_N2_lut_5 = 16'hFEFF;
assign M1[12] = layer5_N2_lut_0[layer5_N2_wire];
assign M1[13] = layer5_N2_lut_1[layer5_N2_wire];
assign M1[14] = layer5_N2_lut_2[layer5_N2_wire];
assign M1[15] = layer5_N2_lut_3[layer5_N2_wire];
assign M1[16] = layer5_N2_lut_4[layer5_N2_wire];
assign M1[17] = layer5_N2_lut_5[layer5_N2_wire];

wire [3:0] layer5_N3_wire = {M0[12], M0[13], M0[14], M0[15]};
wire [15:0] layer5_N3_lut_0 = 16'h10F0;
wire [15:0] layer5_N3_lut_1 = 16'h69B6;
wire [15:0] layer5_N3_lut_2 = 16'h20B2;
wire [15:0] layer5_N3_lut_3 = 16'hB6DB;
wire [15:0] layer5_N3_lut_4 = 16'h0420;
wire [15:0] layer5_N3_lut_5 = 16'hFBFF;
assign M1[18] = layer5_N3_lut_0[layer5_N3_wire];
assign M1[19] = layer5_N3_lut_1[layer5_N3_wire];
assign M1[20] = layer5_N3_lut_2[layer5_N3_wire];
assign M1[21] = layer5_N3_lut_3[layer5_N3_wire];
assign M1[22] = layer5_N3_lut_4[layer5_N3_wire];
assign M1[23] = layer5_N3_lut_5[layer5_N3_wire];

wire [3:0] layer5_N4_wire = {M0[16], M0[17], M0[18], M0[19]};
wire [15:0] layer5_N4_lut_0 = 16'h8FBF;
wire [15:0] layer5_N4_lut_1 = 16'h70F2;
wire [15:0] layer5_N4_lut_2 = 16'h0420;
wire [15:0] layer5_N4_lut_3 = 16'h9669;
wire [15:0] layer5_N4_lut_4 = 16'h20B2;
wire [15:0] layer5_N4_lut_5 = 16'hFBFF;
assign M1[24] = layer5_N4_lut_0[layer5_N4_wire];
assign M1[25] = layer5_N4_lut_1[layer5_N4_wire];
assign M1[26] = layer5_N4_lut_2[layer5_N4_wire];
assign M1[27] = layer5_N4_lut_3[layer5_N4_wire];
assign M1[28] = layer5_N4_lut_4[layer5_N4_wire];
assign M1[29] = layer5_N4_lut_5[layer5_N4_wire];

wire [3:0] layer5_N5_wire = {M0[20], M0[21], M0[22], M0[23]};
wire [15:0] layer5_N5_lut_0 = 16'h9645;
wire [15:0] layer5_N5_lut_1 = 16'hFBC4;
wire [15:0] layer5_N5_lut_2 = 16'h40C4;
wire [15:0] layer5_N5_lut_3 = 16'h6950;
wire [15:0] layer5_N5_lut_4 = 16'hD402;
wire [15:0] layer5_N5_lut_5 = 16'hFFFD;
assign M1[30] = layer5_N5_lut_0[layer5_N5_wire];
assign M1[31] = layer5_N5_lut_1[layer5_N5_wire];
assign M1[32] = layer5_N5_lut_2[layer5_N5_wire];
assign M1[33] = layer5_N5_lut_3[layer5_N5_wire];
assign M1[34] = layer5_N5_lut_4[layer5_N5_wire];
assign M1[35] = layer5_N5_lut_5[layer5_N5_wire];

wire [3:0] layer5_N6_wire = {M0[24], M0[25], M0[26], M0[27]};
wire [15:0] layer5_N6_lut_0 = 16'hD4A3;
wire [15:0] layer5_N6_lut_1 = 16'h906C;
wire [15:0] layer5_N6_lut_2 = 16'h9024;
wire [15:0] layer5_N6_lut_3 = 16'hF9B2;
wire [15:0] layer5_N6_lut_4 = 16'h2204;
wire [15:0] layer5_N6_lut_5 = 16'hFFFB;
assign M1[36] = layer5_N6_lut_0[layer5_N6_wire];
assign M1[37] = layer5_N6_lut_1[layer5_N6_wire];
assign M1[38] = layer5_N6_lut_2[layer5_N6_wire];
assign M1[39] = layer5_N6_lut_3[layer5_N6_wire];
assign M1[40] = layer5_N6_lut_4[layer5_N6_wire];
assign M1[41] = layer5_N6_lut_5[layer5_N6_wire];

wire [3:0] layer5_N7_wire = {M0[28], M0[29], M0[30], M0[31]};
wire [15:0] layer5_N7_lut_0 = 16'h0589;
wire [15:0] layer5_N7_lut_1 = 16'hCE44;
wire [15:0] layer5_N7_lut_2 = 16'h0000;
wire [15:0] layer5_N7_lut_3 = 16'h9629;
wire [15:0] layer5_N7_lut_4 = 16'h2B42;
wire [15:0] layer5_N7_lut_5 = 16'hFFBF;
assign M1[42] = layer5_N7_lut_0[layer5_N7_wire];
assign M1[43] = layer5_N7_lut_1[layer5_N7_wire];
assign M1[44] = layer5_N7_lut_2[layer5_N7_wire];
assign M1[45] = layer5_N7_lut_3[layer5_N7_wire];
assign M1[46] = layer5_N7_lut_4[layer5_N7_wire];
assign M1[47] = layer5_N7_lut_5[layer5_N7_wire];

wire [3:0] layer5_N8_wire = {M0[32], M0[33], M0[34], M0[35]};
wire [15:0] layer5_N8_lut_0 = 16'hCDE0;
wire [15:0] layer5_N8_lut_1 = 16'h96F6;
wire [15:0] layer5_N8_lut_2 = 16'hD6F4;
wire [15:0] layer5_N8_lut_3 = 16'h409D;
wire [15:0] layer5_N8_lut_4 = 16'h0240;
wire [15:0] layer5_N8_lut_5 = 16'hFDFF;
assign M1[48] = layer5_N8_lut_0[layer5_N8_wire];
assign M1[49] = layer5_N8_lut_1[layer5_N8_wire];
assign M1[50] = layer5_N8_lut_2[layer5_N8_wire];
assign M1[51] = layer5_N8_lut_3[layer5_N8_wire];
assign M1[52] = layer5_N8_lut_4[layer5_N8_wire];
assign M1[53] = layer5_N8_lut_5[layer5_N8_wire];

wire [3:0] layer5_N9_wire = {M0[36], M0[37], M0[38], M0[39]};
wire [15:0] layer5_N9_lut_0 = 16'hEA9E;
wire [15:0] layer5_N9_lut_1 = 16'h0060;
wire [15:0] layer5_N9_lut_2 = 16'h0080;
wire [15:0] layer5_N9_lut_3 = 16'h6916;
wire [15:0] layer5_N9_lut_4 = 16'h1781;
wire [15:0] layer5_N9_lut_5 = 16'hFF7F;
assign M1[54] = layer5_N9_lut_0[layer5_N9_wire];
assign M1[55] = layer5_N9_lut_1[layer5_N9_wire];
assign M1[56] = layer5_N9_lut_2[layer5_N9_wire];
assign M1[57] = layer5_N9_lut_3[layer5_N9_wire];
assign M1[58] = layer5_N9_lut_4[layer5_N9_wire];
assign M1[59] = layer5_N9_lut_5[layer5_N9_wire];

endmodule
module myreg #(parameter DataWidth=16) (
    input [DataWidth-1:0] data_in,
    input wire clk,
    input wire rst,
    output reg [DataWidth-1:0] data_out
    );
    always@(posedge clk) begin
    if(!rst)
        data_out<=data_in;
    else
        data_out<=0;
    end
endmodule


module neuralut (input [783:0] M0, input clk, input rst, output[59:0] M6);
wire [783:0] M0w;
myreg #(.DataWidth(784)) layer0_reg (.data_in(M0), .clk(clk), .rst(rst), .data_out(M0w));
wire [639:0] M1;
layer0 layer0_inst (.M0(M0w), .M1(M1));
wire [639:0] M1w;
myreg #(.DataWidth(640)) layer1_reg (.data_in(M1), .clk(clk), .rst(rst), .data_out(M1w));
wire [159:0] M2;
layer1 layer1_inst (.M0(M1w), .M1(M2));
wire [159:0] M2w;
myreg #(.DataWidth(160)) layer2_reg (.data_in(M2), .clk(clk), .rst(rst), .data_out(M2w));
wire [639:0] M3;
layer2 layer2_inst (.M0(M2w), .M1(M3));
wire [639:0] M3w;
myreg #(.DataWidth(640)) layer3_reg (.data_in(M3), .clk(clk), .rst(rst), .data_out(M3w));
wire [159:0] M4;
layer3 layer3_inst (.M0(M3w), .M1(M4));
wire [159:0] M4w;
myreg #(.DataWidth(160)) layer4_reg (.data_in(M4), .clk(clk), .rst(rst), .data_out(M4w));
wire [39:0] M5;
layer4 layer4_inst (.M0(M4w), .M1(M5));
wire [39:0] M5w;
myreg #(.DataWidth(40)) layer5_reg (.data_in(M5), .clk(clk), .rst(rst), .data_out(M5w));
layer5 layer5_inst (.M0(M5w), .M1(M6));

endmodule

