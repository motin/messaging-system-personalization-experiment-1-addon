SERVER=https://kinto.dev.mozaws.net/v1

# create user
curl -X PUT ${SERVER}/accounts/devuser \
     -d '{"data": {"password": "devpass"}}' \
     -H 'Content-Type:application/json'

BASIC_AUTH=devuser:devpass

# control test data
CID=cfr-ml-control
curl -X PUT ${SERVER}/buckets/main/collections/${CID} \
     -H 'Content-Type:application/json' \
     -u ${BASIC_AUTH}
curl -X POST ${SERVER}/buckets/main/collections/${CID}/records \
     -d '{"data":{"id":"PERSONALIZED_CFR_MESSAGE","template":"cfr_doorhanger","content":{"layout":"icon_and_message","category":"cfrFeatures","notification_text":"Personalized CFR Recommendation","heading_text":{"string_id":"cfr-doorhanger-firefox-send-header"},"info_icon":{"label":{"string_id":"cfr-doorhanger-extension-sumo-link"},"sumo_path":"https://example.com"},"text":{"string_id":"cfr-doorhanger-firefox-send-body"},"icon":"chrome://branding/content/icon64.png","buttons":{"primary":{"label":{"string_id":"cfr-doorhanger-firefox-send-ok-button"},"action":{"type":"OPEN_URL","data":{"args":"https://send.firefox.com/login/?utm_source=activity-stream&entrypoint=activity-stream-cfr-pdf","where":"tabshifted"}}},"secondary":[{"label":{"string_id":"cfr-doorhanger-extension-cancel-button"},"action":{"type":"CANCEL"}},{"label":{"string_id":"cfr-doorhanger-extension-never-show-recommendation"}},{"label":{"string_id":"cfr-doorhanger-extension-manage-settings-button"},"action":{"type":"OPEN_PREFERENCES_PAGE","data":{"category":"general-cfrfeatures"}}}]}},"targeting":"","trigger":{"id":"openURL","patterns":["*://*/*.pdf"]}}}' \
     -H 'Content-Type:application/json' \
     -u ${BASIC_AUTH}

# treatment test data
CID=cfr-ml-experiments
curl -X PUT ${SERVER}/buckets/main/collections/${CID} \
     -H 'Content-Type:application/json' \
     -u ${BASIC_AUTH}
curl -X POST ${SERVER}/buckets/main/collections/${CID}/records \
     -d '{"data":{"id":"PERSONALIZED_CFR_MESSAGE","template":"cfr_doorhanger","content":{"layout":"icon_and_message","category":"cfrFeatures","notification_text":"Personalized CFR Recommendation","heading_text":{"string_id":"cfr-doorhanger-firefox-send-header"},"info_icon":{"label":{"string_id":"cfr-doorhanger-extension-sumo-link"},"sumo_path":"https://example.com"},"text":{"string_id":"cfr-doorhanger-firefox-send-body"},"icon":"chrome://branding/content/icon64.png","buttons":{"primary":{"label":{"string_id":"cfr-doorhanger-firefox-send-ok-button"},"action":{"type":"OPEN_URL","data":{"args":"https://send.firefox.com/login/?utm_source=activity-stream&entrypoint=activity-stream-cfr-pdf","where":"tabshifted"}}},"secondary":[{"label":{"string_id":"cfr-doorhanger-extension-cancel-button"},"action":{"type":"CANCEL"}},{"label":{"string_id":"cfr-doorhanger-extension-never-show-recommendation"}},{"label":{"string_id":"cfr-doorhanger-extension-manage-settings-button"},"action":{"type":"OPEN_PREFERENCES_PAGE","data":{"category":"general-cfrfeatures"}}}]}},"targeting":"personalizedCfrScores.PERSONALIZED_CFR_MESSAGE > personalizedCfrThreshold","trigger":{"id":"openURL","patterns":["*://*/*.pdf"]}}}' \
     -H 'Content-Type:application/json' \
     -u ${BASIC_AUTH}
CID=cfr-ml-model
curl -X PUT ${SERVER}/buckets/main/collections/${CID} \
     -H 'Content-Type:application/json' \
     -u ${BASIC_AUTH}
curl -X POST ${SERVER}/buckets/main/collections/${CID}/records \
     -d '{"data":{"version":20191219041219,"models_by_cfr_id":{"PIN_TAB":{"priors":[0.2736140789,0.7263859211],"delProbs":[[2231,2863],[5784,447],[1556,1420],[3203,1558],[1598,3946],[5533,8006],[5071,8700],[9178,5518],[1966,7076],[6966,4059],[6221,3052],[7571,6919],[2945,5325],[3757,6007],[5119,9550]],"negProbs":[[2231,5784,1556,3203,1598,5533,5071,9178,1966,6966,6221,7571,2945,3757,5119],[2863,447,1420,1558,3946,8006,8700,5518,7076,4059,3052,6919,5325,6007,9550]]},"PIN_TAB_72":{"priors":[0.3291766889,0.6708233111],"delProbs":[[3940,8932],[6968,114],[224,1895],[9059,9787],[1538,5838],[1937,7613],[5103,1006],[8963,6013],[5312,448],[2667,5411],[4280,6907],[1068,434],[3913,773],[99,4764],[4700,8455]],"negProbs":[[3940,6968,224,9059,1538,1937,5103,8963,5312,2667,4280,1068,3913,99,4700],[8932,114,1895,9787,5838,7613,1006,6013,448,5411,6907,434,773,4764,8455]]},"SAVE_LOGIN":{"priors":[0.1002682088,0.8997317912],"delProbs":[[7310,4813],[3181,1487],[5386,910],[5527,9089],[308,9114],[6082,2373],[3369,9588],[9879,8118],[418,4407],[6638,9767],[4495,4695],[6814,9505],[3361,9406],[5056,7301],[2272,2005]],"negProbs":[[7310,3181,5386,5527,308,6082,3369,9879,418,6638,4495,6814,3361,5056,2272],[4813,1487,910,9089,9114,2373,9588,8118,4407,9767,4695,9505,9406,7301,2005]]},"SEND_TAB_CFR":{"priors":[0.4316323174,0.5683676826],"delProbs":[[5971,4367],[8206,2699],[9325,1973],[9251,1807],[866,9072],[8736,7647],[8934,7618],[3190,6027],[9458,9028],[1404,4667],[8077,5932],[3788,9674],[2701,684],[8713,7085],[5072,7653]],"negProbs":[[5971,8206,9325,9251,866,8736,8934,3190,9458,1404,8077,3788,2701,8713,5072],[4367,2699,1973,1807,9072,7647,7618,6027,9028,4667,5932,9674,684,7085,7653]]},"SAVE_LOGIN_72":{"priors":[0.8257164974,0.1742835026],"delProbs":[[8098,4077],[2951,4758],[7157,4807],[8450,3123],[8578,9085],[7028,6478],[6992,6773],[6065,5701],[4225,4707],[598,5129],[2923,1980],[271,3518],[8643,4850],[1301,3194],[762,5215]],"negProbs":[[8098,2951,7157,8450,8578,7028,6992,6065,4225,598,2923,271,8643,1301,762],[4077,4758,4807,3123,9085,6478,6773,5701,4707,5129,1980,3518,4850,3194,5215]]},"WNP_MOMENTS_1":{"priors":[0.3471677231,0.6528322769],"delProbs":[[5721,3437],[6212,602],[5967,2098],[4396,4703],[693,8243],[7517,495],[8923,908],[2081,695],[5396,3138],[5168,77],[8846,2821],[1215,2340],[4511,2176],[9010,4699],[4604,2213]],"negProbs":[[5721,6212,5967,4396,693,7517,8923,2081,5396,5168,8846,1215,4511,9010,4604],[3437,602,2098,4703,8243,495,908,695,3138,77,2821,2340,2176,4699,2213]]},"WNP_MOMENTS_2":{"priors":[0.1444903979,0.8555096021],"delProbs":[[6910,1622],[6850,1535],[7880,3049],[7941,987],[2157,2695],[8628,4380],[499,5580],[9578,2390],[7347,7202],[4250,6883],[5711,1225],[2254,2954],[9298,1276],[9056,6261],[8546,4801]],"negProbs":[[6910,6850,7880,7941,2157,8628,499,9578,7347,4250,5711,2254,9298,9056,8546],[1622,1535,3049,987,2695,4380,5580,2390,7202,6883,1225,2954,1276,6261,4801]]},"PDF_URL_FFX_SEND":{"priors":[0.152219802,0.847780198],"delProbs":[[6381,8996],[4901,6913],[9295,2767],[4208,738],[8679,2244],[7835,4767],[5864,2183],[5168,7051],[3910,1661],[7799,9350],[5480,9717],[2969,4100],[1982,8475],[8202,3728],[6556,243]],"negProbs":[[6381,4901,9295,4208,8679,7835,5864,5168,3910,7799,5480,2969,1982,8202,6556],[8996,6913,2767,738,2244,4767,2183,7051,1661,9350,9717,4100,8475,3728,243]]},"BOOKMARK_SYNC_CFR":{"priors":[0.5708076498,0.4291923502],"delProbs":[[7329,5150],[9822,2780],[8596,4591],[3010,6193],[8322,6674],[482,2642],[4708,1377],[4160,3968],[6951,1914],[3301,3660],[7760,6846],[9050,8022],[1265,5117],[3749,6805],[6593,8438]],"negProbs":[[7329,9822,8596,3010,8322,482,4708,4160,6951,3301,7760,9050,1265,3749,6593],[5150,2780,4591,6193,6674,2642,1377,3968,1914,3660,6846,8022,5117,6805,8438]]},"MILESTONE_MESSAGE":{"priors":[0.6110060452,0.3889939548],"delProbs":[[2830,1541],[1507,3697],[7720,8000],[9501,4157],[5591,7516],[4174,2792],[3279,7017],[6254,9253],[8916,2297],[1928,863],[397,6978],[1144,2034],[9497,8949],[1514,4768],[5562,9134]],"negProbs":[[2830,1507,7720,9501,5591,4174,3279,6254,8916,1928,397,1144,9497,1514,5562],[1541,3697,8000,4157,7516,2792,7017,9253,2297,863,6978,2034,8949,4768,9134]]},"YOUTUBE_ENHANCE_3":{"priors":[0.7355211622,0.2644788378],"delProbs":[[423,5702],[6587,8539],[2566,9307],[439,8150],[358,9504],[8551,2409],[5460,6993],[4296,2785],[892,6349],[6689,2751],[7025,790],[7246,6540],[2724,5933],[1154,1404],[1798,4592]],"negProbs":[[423,6587,2566,439,358,8551,5460,4296,892,6689,7025,7246,2724,1154,1798],[5702,8539,9307,8150,9504,2409,6993,2785,6349,2751,790,6540,5933,1404,4592]]},"GOOGLE_TRANSLATE_3":{"priors":[0.3470402818,0.6529597182],"delProbs":[[1542,3933],[2854,7353],[3614,8000],[7141,7178],[8666,5437],[49,8726],[7001,1494],[1003,4211],[7928,7915],[9730,5000],[2272,5620],[6514,5991],[2141,8704],[4215,885],[41,7131]],"negProbs":[[1542,2854,3614,7141,8666,49,7001,1003,7928,9730,2272,6514,2141,4215,41],[3933,7353,8000,7178,5437,8726,1494,4211,7915,5000,5620,5991,8704,885,7131]]},"WNP_MOMENTS_MOBILE":{"priors":[0.2854345957,0.7145654043],"delProbs":[[8237,4885],[7130,4741],[7605,9741],[8397,7935],[7391,9412],[7743,7246],[9917,6472],[61,962],[3289,9008],[2650,4203],[2628,3781],[9480,2687],[7602,6164],[46,6621],[2258,6154]],"negProbs":[[8237,7130,7605,8397,7391,7743,9917,61,3289,2650,2628,9480,7602,46,2258],[4885,4741,9741,7935,9412,7246,6472,962,9008,4203,3781,2687,6164,6621,6154]]},"SEND_RECIPE_TAB_CFR":{"priors":[0.6027104369,0.3972895631],"delProbs":[[3306,4418],[3496,2234],[3007,9708],[4078,4411],[2901,8306],[4733,5481],[3538,5023],[4864,7268],[1811,7542],[5779,9477],[4496,3384],[6465,8618],[7465,3194],[3242,6904],[1187,8504]],"negProbs":[[3306,3496,3007,4078,2901,4733,3538,4864,1811,5779,4496,6465,7465,3242,1187],[4418,2234,9708,4411,8306,5481,5023,7268,7542,9477,3384,8618,3194,6904,8504]]},"FACEBOOK_CONTAINER_3":{"priors":[0.4952359685,0.5047640315],"delProbs":[[9568,7105],[8063,9233],[7236,4376],[1456,6433],[7743,1328],[8153,5602],[4346,6252],[7502,2226],[152,8705],[7192,2519],[156,4365],[1499,3064],[1679,3677],[9613,3174],[1233,513]],"negProbs":[[9568,8063,7236,1456,7743,8153,4346,7502,152,7192,156,1499,1679,9613,1233],[7105,9233,4376,6433,1328,5602,6252,2226,8705,2519,4365,3064,3677,3174,513]]},"YOUTUBE_ENHANCE_3_72":{"priors":[0.8801086241,0.1198913759],"delProbs":[[3247,7310],[7317,2399],[3499,3470],[7779,5178],[7706,7585],[5073,8457],[7114,5369],[5576,464],[9440,9501],[5552,5802],[4960,849],[641,9980],[1032,2324],[7356,1822],[8050,291]],"negProbs":[[3247,7317,3499,7779,7706,5073,7114,5576,9440,5552,4960,641,1032,7356,8050],[7310,2399,3470,5178,7585,8457,5369,464,9501,5802,849,9980,2324,1822,291]]},"GOOGLE_TRANSLATE_3_72":{"priors":[0.1558915699,0.8441084301],"delProbs":[[425,9498],[2420,3524],[745,2965],[354,7413],[3668,4686],[9670,2990],[7610,3793],[2261,824],[7039,7105],[2383,9056],[9682,312],[9752,3674],[2934,7914],[385,8812],[559,8018]],"negProbs":[[425,2420,745,354,3668,9670,7610,2261,7039,2383,9682,9752,2934,385,559],[9498,3524,2965,7413,4686,2990,3793,824,7105,9056,312,3674,7914,8812,8018]]},"FACEBOOK_CONTAINER_3_72":{"priors":[0.2709811128,0.7290188872],"delProbs":[[723,1605],[1115,1959],[7530,3658],[3226,5864],[3184,6837],[2126,8326],[1055,8319],[8315,9635],[782,8411],[3779,5300],[952,9758],[2693,1446],[793,6667],[7773,6472],[4220,1652]],"negProbs":[[723,1115,7530,3226,3184,2126,1055,8315,782,3779,952,2693,793,7773,4220],[1605,1959,3658,5864,6837,8326,8319,9635,8411,5300,9758,1446,6667,6472,1652]]}},"id":"vng1141-cfr-ml-model","last_modified":1576730484114}}' \
     -H 'Content-Type:application/json' \
     -u ${BASIC_AUTH}