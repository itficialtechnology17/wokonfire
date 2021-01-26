import 'dart:convert';

List<ModelOffer> modelOfferFromJson(String str) =>
    List<ModelOffer>.from(json.decode(str).map((x) => ModelOffer.fromJson(x)));

String modelOfferToJson(List<ModelOffer> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelOffer {
  ModelOffer({
    this.offId,
    this.offPhoto,
    this.offCode,
    this.offTitle,
    this.offNestedTitle,
    this.offTermCondition,
    this.offerUrl,
    this.offerRestaurantId,
    this.offerProductId,
    this.offType,
    this.offPrice,
    this.offerStartDate,
    this.offerExpiryDate,
    this.offerDays,
    this.offerStartTime,
    this.offerEndTime,
    this.minOrderValue,
    this.maxCashBack,
    this.maxUsageByOneUser,
    this.totalMaxUser,
    this.offerRank,
    this.offerOn,
    this.offerStatus,
    this.isWalletCashback,
    this.isSuperCash,
  });

  int offId;
  String offPhoto;
  String offCode;
  String offTitle;
  String offNestedTitle;
  String offTermCondition;
  String offerUrl;
  int offerRestaurantId;
  int offerProductId;
  int offType;
  int offPrice;
  DateTime offerStartDate;
  DateTime offerExpiryDate;
  dynamic offerDays;
  String offerStartTime;
  String offerEndTime;
  int minOrderValue;
  int maxCashBack;
  int maxUsageByOneUser;
  int totalMaxUser;
  int offerRank;
  int offerOn;
  String offerStatus;
  int isWalletCashback;
  String isSuperCash;
  bool isMore = false;

  factory ModelOffer.fromJson(Map<String, dynamic> json) => ModelOffer(
        offId: json["off_id"],
        offPhoto: json["off_photo"],
        offCode: json["off_code"],
        offTitle: json["off_title"],
        offNestedTitle: json["off_nested_title"],
        offTermCondition: json["off_term_condition"],
        offerUrl: json["offer_url"] == null ? null : json["offer_url"],
        offerRestaurantId: json["offer_restaurant_id"] == null
            ? null
            : json["offer_restaurant_id"],
        offerProductId:
            json["offer_product_id"] == null ? null : json["offer_product_id"],
        offType: json["off_type"],
        offPrice: json["off_price"],
        offerStartDate: DateTime.parse(json["offer_start_date"]),
        offerExpiryDate: DateTime.parse(json["offer_expiry_date"]),
        offerDays: json["offer_days"],
        offerStartTime: json["offer_start_time"],
        offerEndTime: json["offer_end_time"],
        minOrderValue: json["min_order_value"],
        maxCashBack: json["max_cash_back"],
        maxUsageByOneUser: json["max_usage_by_one_user"],
        totalMaxUser: json["total_max_user"],
        offerRank: json["offer_rank"],
        offerOn: json["offer_on"],
        offerStatus: json["offer_status"],
        isWalletCashback: json["is_wallet_cashback"],
        isSuperCash: json["is_super_cash"],
      );

  Map<String, dynamic> toJson() => {
        "off_id": offId,
        "off_photo": offPhoto,
        "off_code": offCode,
        "off_title": offTitle,
        "off_nested_title": offNestedTitle,
        "off_term_condition": offTermCondition,
        "offer_url": offerUrl == null ? null : offerUrl,
        "offer_restaurant_id":
            offerRestaurantId == null ? null : offerRestaurantId,
        "offer_product_id": offerProductId == null ? null : offerProductId,
        "off_type": offType,
        "off_price": offPrice,
        "offer_start_date":
            "${offerStartDate.year.toString().padLeft(4, '0')}-${offerStartDate.month.toString().padLeft(2, '0')}-${offerStartDate.day.toString().padLeft(2, '0')}",
        "offer_expiry_date":
            "${offerExpiryDate.year.toString().padLeft(4, '0')}-${offerExpiryDate.month.toString().padLeft(2, '0')}-${offerExpiryDate.day.toString().padLeft(2, '0')}",
        "offer_days": offerDays,
        "offer_start_time": offerStartTime,
        "offer_end_time": offerEndTime,
        "min_order_value": minOrderValue,
        "max_cash_back": maxCashBack,
        "max_usage_by_one_user": maxUsageByOneUser,
        "total_max_user": totalMaxUser,
        "offer_rank": offerRank,
        "offer_on": offerOn,
        "offer_status": offerStatus,
        "is_wallet_cashback": isWalletCashback,
        "is_super_cash": isSuperCash,
      };
}
