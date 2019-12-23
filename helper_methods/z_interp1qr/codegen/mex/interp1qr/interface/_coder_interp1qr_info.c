/*
 * _coder_interp1qr_info.c
 *
 * Code generation for function '_coder_interp1qr_info'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "interp1qr.h"
#include "_coder_interp1qr_info.h"

/* Function Definitions */
mxArray *emlrtMexFcnProperties(void)
{
  mxArray *xResult;
  mxArray *xEntryPoints;
  const char * fldNames[4] = { "Name", "NumberOfInputs", "NumberOfOutputs",
    "ConstantInputs" };

  mxArray *xInputs;
  const char * b_fldNames[4] = { "Version", "ResolvedFunctions", "EntryPoints",
    "CoverageInfo" };

  xEntryPoints = emlrtCreateStructMatrix(1, 1, 4, fldNames);
  xInputs = emlrtCreateLogicalMatrix(1, 3);
  emlrtSetField(xEntryPoints, 0, "Name", emlrtMxCreateString("interp1qr"));
  emlrtSetField(xEntryPoints, 0, "NumberOfInputs", emlrtMxCreateDoubleScalar(3.0));
  emlrtSetField(xEntryPoints, 0, "NumberOfOutputs", emlrtMxCreateDoubleScalar
                (1.0));
  emlrtSetField(xEntryPoints, 0, "ConstantInputs", xInputs);
  xResult = emlrtCreateStructMatrix(1, 1, 4, b_fldNames);
  emlrtSetField(xResult, 0, "Version", emlrtMxCreateString(
    "9.3.0.713579 (R2017b)"));
  emlrtSetField(xResult, 0, "ResolvedFunctions", (mxArray *)
                emlrtMexFcnResolvedFunctionsInfo());
  emlrtSetField(xResult, 0, "EntryPoints", xEntryPoints);
  return xResult;
}

const mxArray *emlrtMexFcnResolvedFunctionsInfo(void)
{
  const mxArray *nameCaptureInfo;
  const char * data[36] = {
    "789ced5d496c2b4919ee37cc1b660e034f20d6114cde8046c30c7a1d2f891316112f9dc459ecf6963879cc38ed76dbeeb8f76e3b764eb980387241088903dc38"
    "72e4184ec309cd81454248204ecc951b37baddaec46e5c2f3d71b99c6e57496f3a557fbbbeea7ffefaffaaffaf857a943d7c4451d467ec7fcef35707ce7f29ea",
    "75ca4d4f46cf97a8c9e4a53f1a3d139e3c488fa997277e07e8bf1c3d7955b184bee566245111725db92e187646e164e1a69a862a8b0aa758e58126508660aa52"
    "4f680c294d5112caa22c1ca863995dd1cec8db63a49b8c4372fe4eb705be53eaca94d1366f9b2b8d67a831fefc1bf2fd2ffbe4cf8f20fc79322a03f4e7ccfbe9",
    "efd01553304c3ad9e0643a63a85a5dedd31995efca826299745b95850bd5e8d0acfd92aa70d20a6ba8e7026f93f64bec4ad9e09c8c6a0c56f29a25cae2256789"
    "aab2525655896e0b9226183559b0da6ac3a42f6ba2cd7e438be8067df3d73379ecbbcf20dff58acfeff63e417a8d7af536b3c56edd85e797cf8f21784f6c8a53",
    "d6164d8ba7eefe3ebf78af78f2b778af0ccb1a6ab72e09b778bf9d116f1f8ae79601faf3ec4175284ab66cb40c4e5e7164dea40f93e583648a2e465723893a6d"
    "d922e1c896204bb424d66999b324ae4e37388b6b76157ac8aba134609587effdf76f7f4e62953f0ab3bc2f10af0fa9cfaffc7d118207e40fd093993536b37392",
    "ceae5db25db363a6a401bfb67ddb0ef60e9cbbda4141f2b8ea0f7a3fd620edf32b772f79f220bde679df4def6eb9cfd51b3d7f05a9df2fffde84e003fe013aaf"
    "3604e3d9d0b6d996f29968a6baa26465157b98211822bf303bf0bb19f1aa503cb70cd03fb1fc38ffde1b728d7e0fb08df6b2ed998c4f7f5d7d97d883e0db837c",
    "4f4f279bbbbd8d72213ee01959896e9f4abbc41e3c147b7006691f5ab95bbbd1ff3f81d4e7975fdf80e0017e01ba47ffdbd34dd3caa94a49545a9260a94a46f4"
    "c78779d981eb19f17e08c573cb001d8d1d98c63e579030cad1bf3efcfc5f883d98131e2e7b904e54643e26449578a1586474cd58e79bb19df0d8836bc8effdf2",
    "b106a91ff011d011da83a742a325983545551a026f089c697772bc72b8c2219b1f7c1d8207f807e8364b1c1f58ada91a92aa6a35b527184d49bda8f18e7f7076"
    "bbe04db0f680844a7ece3c792f1ea0cf223f2333f102fe619d276c7dfc98d885a0db05739fe93399cb4b76af1f8d1f4657d385646495098f5d98358ef06348fd",
    "808f803eef7efdf4c52fd4dc40036e79dd41164778d993a76ede7b7958269a4d27c684ac7f7c098ae79601bad79f65dbea7e56b16edaf19b19dbb17d473b00fd"
    "5ef2d514fb424353edd6d30eff9c9903892b84030f977d280d34515ed38bc711b1de88674f0bec61a497098f7d20fd77324dcadb6dfc0016bff0cba7d73d796a",
    "ecbd476374d1545c97b7e5ac3c40e727bacbbef06dce590481ccbf9887e2b965803ebb5c8cf1cb16108cf21179fe15a2df83aedf77629d41496f8952ba9cee14"
    "f554abdca93021d2ef64fc3ff95d68e5358b6cfc7f971fdffe7499eb07d71eec41f1dc32409f498e24fb0fdae5d428dc84511eaebef7c66bc41f14747b60e8ab",
    "dab968c693f23a9b50d87a35b67f64a6883d20f660fa774fc8eb155e7b202ac41ef8b307a2b2007bf003620f826f0f5adc49221f3bcee9897ad24aaf71f9b810"
    "2f84286e3c6b3f5ef43a22985f663eeb4af35bc3c7557e0b951c7e0e820ff807e81e3fbcc2296ef9a2e2c50f566ea6ae23b2d9857ffdd91bbfff07f10f055dff",
    "9f1e49eb8d52fda4cd240eced98a503d8f768a645fc172eaff6b766bf8dc2a22d3fff78cc36a86da30c54b21b0fbca584f9e1a7b6f5ceed1e87fc02eb28f202c"
    "78b8f47f472fe5925ab69e17b35aaed2ee553656752b44fea0a0ebff3348fbd0ca5d05d93ad1af40f000bf007ddaba1b673b39d82e1ed47d6445289e5b06e888",
    "f691ddb00dbfff87fadb17ac3f11fd3f273c5cfa5f3ee10f62eb6c69e740db4b3432877a4f3d6e93f1ff83d1ffb07d5d7ee50e767e0318ffbf33515ad91a3eb6"
    "46cfab93d17394a7aa0fc24e1c8a4ad76b271eca7ad100da8f213b89fd08171e2efb712eafa598d4a0702ac83dc98a0bb9edd86697cc1f1e8cfdc0ea3fbab11b",
    "1564fea32f43f001ff007d9a5e66a5ae19d47944018ae796013a423be0b00b98016207428287cb0eec9676abd5522c7f6ced70f9ce7976ffb0b57611a238f2ac"
    "fdb904a91ff011d051ee3f6edaddba2e2a13df71066927daf3e73e40b64ee8aef3e744d30d1507354e9085e2b965808e609d90791b25c6bb6e94c4091eae7eff",
    "02040fc81fa0ebc96e5e8e0faaf1d5a211eda623c2664fce51e1d1efa41f4f6fffa4dc7d1399ff879c3707c373cbc87973f7c573d3b2e091f3e6d0d44fc6f7d3"
    "9f204dca5f0d997fc7affc79ec40dd1438836f0777dc3fb7fdc353f5ff885d78f70f9373e5e688876dff30bbbe9aa9acb7d745feb2cd1cc71289d3a21ea2fdc3",
    "a41f4f6fffa4dcad2fda9faf70464b54f8766751fb01aeef8907ea9acbb9a2669b338406ed4ac94856fe7f6bc08873b8cf15bdfaf9f78bc4af1f74fd3fe85f64"
    "37b9ed666b6d95cf336ae97cbb9bb808d1f971d790df07b55fc3e4c2af1c7e0af23d20defbe589d2b7b6dce7dba3e7b7b1f9fd9b92aa3a1b76833afec7e32f74",
    "668b434e2dc25fc89cbc4dfc3e41d7ff1b7a225fd6a5cc5a27d52e17764a969ec9f0647de832f5633bad10bfffe81de2f79ffe0489f8fdf1e011bf3f9afa89fe"
    "9fdefe79c57ddf80e0017e01ba47ff9b3c2771c63330ea5fdcb910b3eaffca1d78808e46ffbfe7f26d4c7630eaff67e4fcd0e0ebff7a7b9dad2a92d528a932d3",
    "5576637526b517a2759d44ff4f6f3f4cffff14529f5f7e7d0b8207f805e81efdcf699a34280d95d97657e19d0b98b30a2b713cb8d2faaefd0e7edbf7d93bda07"
    "e8cd512b6a6d4e6948b7e754fc6146fcfa1df8808ec63ec0d9ba80fd601ffe648dc48b836e2f0ef6f6f9139ddd4c9e1cc60d33aa89d15e622f44f162d2bfa77f",
    "973f797c16ba7904c0c7ed4722f38879e1b96959f0c83c024dfdb3ce2316bd4ff80cd23ea472777dfc20ce8f9876ce10393f829c3f7407de302d0b1e397f084d"
    "fd41b70b58cf1fba3ade72ff189d3b740dce1f3a1de54f17bd0ef5ffce95088bdd20e74dcc0d6f9896058f9c3781a6fe59efb1f911a47ec047407f3eeccc1553",
    "304c3ad9e0643a63a89ad377332adf9505c532e9b62a0b17aad1a159fb25d5eebe2b76df3f17789bb45f6257ca06e7645463b092d72c51162f39c7cfb452b695"
    "00ed5e53539305abad364cfab23654015a4437e89bbf30fb13ec74c5225ba70a5b2ffbc4a63865c34bcd28b24ed5cff863ec5a339cf260bdce13ff52d0ed01d3",
    "8de78ce626abc869a6cc6f0ed2b1fef92139876e99fab19d56163d3f20fbd4c83eb53bf0dcb42c78649f1a9afa89fe9fdefe49b97b1799febfa75f461695bc71"
    "688ff9518df771df5bc97af2d4d87be3728ec60f04d885735f02f5e4abe4decac0eb7b3397ab5c3017ba76a017b2db07cd5c6a4fee117dbf4cfd981adf6f4cc6",
    "fb9f0c8f8cf797431fe3c623e37d34f55f437eef978fef43ea077c0474d4fa7f786fbdd0b70c41ee62f7eb539bc41edc138fd883e5d0cfb8f1883d4053ffacfb"
    "0e3848fd808f803e177b501795719b30fe5d6790762395c73365d17e2177fd3cd30a6c1c18ef7c12b00beb79154f7ffd7712070eba1d58cd5d24e4b2289fee8b",
    "c506b39fe14bcde680c48197a81fdbe9eaf046df6b90fafcf2eb754f9e1a7befd1185d3415f7881d6ba0397b9283aae7e7769ead13276a8a7da1a1a9b678d013"
    "fcc27b9e6d84ec270bbe9edf89750625bd254ae972ba53d453ad72a7c284689f31d1f3d3db0fd3f3303cbffc7ad593a76ede7b7558269a4d51e6ac7650f5fa1e",
    "14cf2d03f4d9f5bacba705ec07237a7d8e78b8ee19ebe902a3f57873b37a115355d62c456227a75478f47ab0ce8fbcd5eb4f9ba2615a4d11ef7ee13364fb85bf"
    "0ec1037c0374c75d657f7eada91a92aa6a35b527184d49bda8f16d81ef2ceedcb9eb7be281bace3c792f1ea0cf744e952b462fe01f567fced6c78fc93a9f876a",
    "0f7caff3d967fa4ce6f292ddeb47e387d1d5742119590d915f9fd883e94f9026e4ef9f67c8c6fb77adab74c6b14e7e51e3fddfcc88b70dc573cb001dc578df19"
    "eb639403729ff01cf170e9f5d24013e535bd781c11eb8d78f6b4c01e467a21f2df9078edf4eff2258f63f1da2b487d18ce8913fa5a5292547e485f941d98757c",
    "5086e2b965808e6e7c00d8867d1d0fb96f608e78b8ec42b69ecc46d6b54e8f39d28f573ba9d57841dc0b51fc96f4e7e94f9026e56ff5c60ec0ce21f2cbb7b720"
    "78806f80fe023b9053d3ae0fc8498bb207d733e23d87e2b965808e5e7e46ecc37eee20b10bf3c4c36517ace8fea0aab7aa47ed562751dcb13a7b6c9f09d13d34",
    "d790dffbe5e30790fa011f017d1e76e1a9a07739c9142f05dc72f85d121fa0d0c8cf9927efc50374121fb82f9e9b96058fc407d0d44ffc48d3bfcb973c5ea9c8"
    "ecc3d72078808f80ee993f744d81e50c5bd9a555c5b42874f3864f7a2ec4acf3ce23289e5b06e868e468926d78e30b577ffd609dd885a0db85812e6b9bd5cd3d",
    "297e24b60b426ab7dfeb9d8428be40faf3f4274893f2b7b1e878829d1595d6b66aecb0eecd2c8b9a2704cbff38ce36ecf18404b103c1b703ed58a2b5d9ba602c"
    "a174d465e5b516cba6f269620796af3f3be9f6fe31bcfb805b5af7594bb076b42ea37075496804d64f747a071ea03fcf22391ec2661c3dc1b805ec2bf8cfcf12",
    "c40e04dd0ee4730573af588dc6bb6be57e52d134fd229f0fd13d33643e30fd09122c6eb0a073826e1810d47900defb626ed8b5807365af6abf20f380c0ebfff5"
    "6395cb46a5a3fdf876e5b07160c62f35a61da27545244e30fdbb7cc9e3471a89235368e607679ebc170fd0491cf9be786e5a163c12474653ffacf6a10da91ff0",
    "11d0e7621fdc6d67136602efbe337d417e23727e5c70ce2321e7c7cd138f9c1f87a67e6207a67f97bf7982816c9ef026040ff011d0bdf7fe9aa9ae28595925e7"
    "9e9e16d87d6978f7ad7bd986d52e90fd0773c4c3163fe8e9e96473b7b7512ec4073c232bd1ed532944fb0fc87dc393df85f61c238cf70d8bca301fd47902d67b",
    "ea4485dc371c323c5cf660737f90ad5a6a6633727e111dac1d6e1ced975a215a5f4afaf1f4f693fb86dd842a5e40ee9b99379e9b96058fdc3783a67ea2ffa7b7"
    "9fdc374cee1b1e6faf0f3921f70dcf118fdc378ca67ee2ff99fc2eb4f25a44e6fff93404ef894d71ca8c86d8131b02f1ffbc60dca06a263de2d322d693d26f16",
    "88ffe7a1da03bff7146c5c149a956a7c3db1db938a9b998d8d03b5c253e1b10741efc71aa47d7ee5ee2548fb5ff3bcefa6b7b6dce7db243e3c7a87c487a73f41"
    "22f1613c78243e8ca6fea0db833348fbe6e50fba82d4e7975f2b103cc02f409f7e5e695a95357b56646be445e9ffeb19f14ea0786e19a0233dcff0966d8b909f",
    "7f7df879e2270aba1d683734e3b47ac9f0ad44e620318875b964612344eb47af21bf27fd7a324dcae1b7b1f97f447378186b60fd3ffb503cb70cd067da3f26d9"
    "7fd0234ee13f8f9adc5f33473c6cf7d754f4ae95cb1e1d558aa5c2baa12777d7042e447a9ef4e3e9ed87adff81f99bfcf20bf6ff07f00bd087fb5edd2faef1aa",
    "11d8f1fdfb503cb70cd01df960671310cd107b9c25d05ed6618e035d3dfee33b647c1f74bdcfacd73773e7dbece078bb596a1e33f944e4a413223fcf35e4f7a4"
    "5f4fa649397c87ac03bd271ea88bac039d379e9b96058fac034553ff4790dffbe5a304a91ff011d0e76a0f9e82acbb8178fcfbce20ed472a975be8ee2d7e0cc1",
    "7b62539c32d1543867075850fd3f38e24460de68736a11eb7f88ff678e78b8d6ffe8c96e5e8e0faaf1d5a211eda623c2664fce51e1d1fb41e8c78b8ff77e07d9"
    "b8ff73103cc02f40f78cfbedaf77cb83aaefe7e6279c1a0fb2d985df4f48e2ba73c4c335ce6fa552834622c630a7fd686f77bf2c664e8c6208fc3eff0336d62d",
    "e5", "" };

  nameCaptureInfo = NULL;
  emlrtNameCaptureMxArrayR2016a(data, 85176U, &nameCaptureInfo);
  return nameCaptureInfo;
}

/* End of code generation (_coder_interp1qr_info.c) */
