bool isLogin = false;
String userId;
final String baseUrl = 'itficial.app';
String token = '';
String paymentStage = 'TEST';
String currency = "Rs. ";
bool isSubscribe = false;
var currentAddress = "";
var currentArea = "";
var latitude = "";
var longitude = "";
var restaurantId = "1";
String avatarProfile =
    "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7e/Circle-icons-profile.svg/1024px-Circle-icons-profile.svg.png";

String defaultImage =
    "https://pro2-bar-s3-cdn-cf6.myportfolio.com/555ca57bd31f10ad547d2beee300405e/007294ca-69b9-43be-b61e-19b2b46fd6bb_rw_1920.jpg?h=f908d3c2d92e7a0af88976ccfd72cc25";

bool isStaging = true;

String stagingCallback =
    "https://securegw-stage.paytm.in/theia/paytmCallback?ORDER_ID=";
String liveCallback = "https://securegw.paytm.in/theia/paytmCallback?ORDER_ID";

const STATUS_LOADING = "PAYMENT_LOADING";
const STATUS_SUCCESSFUL = "PAYMENT_SUCCESSFUL";
const STATUS_PENDING = "PAYMENT_PENDING";
const STATUS_FAILED = "PAYMENT_FAILED";
const STATUS_CHECKSUM_FAILED = "PAYMENT_CHECKSUM_FAILED";
