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

bool isStaging = true;

String stagingCallback =
    "https://securegw-stage.paytm.in/theia/paytmCallback?ORDER_ID=";
String liveCallback = "https://securegw.paytm.in/theia/paytmCallback?ORDER_ID";

const STATUS_LOADING = "PAYMENT_LOADING";
const STATUS_SUCCESSFUL = "PAYMENT_SUCCESSFUL";
const STATUS_PENDING = "PAYMENT_PENDING";
const STATUS_FAILED = "PAYMENT_FAILED";
const STATUS_CHECKSUM_FAILED = "PAYMENT_CHECKSUM_FAILED";
