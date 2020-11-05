import 'dart:convert';

List<ModelFood> modelFoodFromJson(String str) =>
    List<ModelFood>.from(json.decode(str).map((x) => ModelFood.fromJson(x)));

String modelFoodToJson(List<ModelFood> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelFood {
  ModelFood({
    this.foodId,
    this.foodName,
    this.foodCategoryId,
    this.foodDesc,
    this.foodImage,
    this.price,
    this.foodTypeId,
    this.foodSpiceType,
    this.jainAvailable,
    this.frId,
    this.fid,
    this.rid,
    this.commonPrice,
    this.foodAvailable,
    this.containerPrice,
    this.containerId,
    this.ftId,
    this.ftName,
    this.ftIcon,
    this.finalPrice,
    this.fdQty,
    this.customization,
  });

  int foodId;
  String foodName;
  int foodCategoryId;
  String foodDesc;
  String foodImage;
  int price;
  int foodTypeId;
  int foodSpiceType;
  int jainAvailable;
  int frId;
  int fid;
  int rid;
  dynamic commonPrice;
  int foodAvailable;
  dynamic containerPrice;
  dynamic containerId;
  int ftId;
  String ftName;
  dynamic ftIcon;
  String finalPrice;
  String fdQty;
  List<Customization> customization;

  factory ModelFood.fromJson(Map<String, dynamic> json) => ModelFood(
        foodId: json["food_id"],
        foodName: json["food_name"],
        foodCategoryId: json["food_category_id"],
        foodDesc: json["food_desc"],
        foodImage: json["food_image"],
        price: json["price"] == null ? null : json["price"],
        foodTypeId: json["food_type_id"],
        foodSpiceType: json["food_spice_type"],
        jainAvailable: json["jain_available"],
        frId: json["fr_id"],
        fid: json["fid"],
        rid: json["rid"],
        commonPrice: json["common_price"],
        foodAvailable: json["food_available"],
        containerPrice: json["container_price"],
        containerId: json["container_id"],
        ftId: json["ft_id"],
        ftName: json["ft_name"],
        ftIcon: json["ft_icon"],
        finalPrice: json["final_price"],
        fdQty: json["fd_qty"] == null ? null : json["fd_qty"],
        customization: List<Customization>.from(
            json["customization"].map((x) => Customization.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "food_id": foodId,
        "food_name": foodName,
        "food_category_id": foodCategoryId,
        "food_desc": foodDesc,
        "food_image": foodImage,
        "price": price == null ? null : price,
        "food_type_id": foodTypeId,
        "food_spice_type": foodSpiceType,
        "jain_available": jainAvailable,
        "fr_id": frId,
        "fid": fid,
        "rid": rid,
        "common_price": commonPrice,
        "food_available": foodAvailable,
        "container_price": containerPrice,
        "container_id": containerId,
        "ft_id": ftId,
        "ft_name": ftName,
        "ft_icon": ftIcon,
        "final_price": finalPrice,
        "fd_qty": fdQty == null ? null : fdQty,
        "customization":
            List<dynamic>.from(customization.map((x) => x.toJson())),
      };
}

class Customization {
  Customization({
    this.fcmId,
    this.fcmTitle,
    this.fcmPrice,
    this.fcmRank,
    this.fcmMinSelection,
    this.fcmMaxSelection,
    this.fcmType,
    this.isTypeSize,
    this.isCompulsory,
    this.fcvId,
    this.rlIdFk,
    this.fIdFk,
    this.fcmIdFk,
    this.fcvName,
    this.fcvExtraPrice,
    this.fcvRank,
    this.fcvIsDefault,
    this.fcvStatus,
    this.customizationValues,
  });

  int fcmId;
  String fcmTitle;
  int fcmPrice;
  int fcmRank;
  int fcmMinSelection;
  int fcmMaxSelection;
  int fcmType;
  String isTypeSize;
  int isCompulsory;
  int fcvId;
  int rlIdFk;
  int fIdFk;
  int fcmIdFk;
  String fcvName;
  String fcvExtraPrice;
  int fcvRank;
  int fcvIsDefault;
  String fcvStatus;
  List<CustomizationValue> customizationValues;

  factory Customization.fromJson(Map<String, dynamic> json) => Customization(
        fcmId: json["fcm_id"],
        fcmTitle: json["fcm_title"],
        fcmPrice: json["fcm_price"],
        fcmRank: json["fcm_rank"],
        fcmMinSelection: json["fcm_min_selection"],
        fcmMaxSelection: json["fcm_max_selection"],
        fcmType: json["fcm_type"],
        isTypeSize: json["is_type_size"],
        isCompulsory: json["is_compulsory"],
        fcvId: json["fcv_id"],
        rlIdFk: json["rl_id_fk"],
        fIdFk: json["f_id_fk"],
        fcmIdFk: json["fcm_id_fk"],
        fcvName: json["fcv_name"],
        fcvExtraPrice: json["fcv_extra_price"],
        fcvRank: json["fcv_rank"],
        fcvIsDefault: json["fcv_is_default"],
        fcvStatus: json["fcv_status"],
        customizationValues: List<CustomizationValue>.from(
            json["customization_values"]
                .map((x) => CustomizationValue.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "fcm_id": fcmId,
        "fcm_title": fcmTitle,
        "fcm_price": fcmPrice,
        "fcm_rank": fcmRank,
        "fcm_min_selection": fcmMinSelection,
        "fcm_max_selection": fcmMaxSelection,
        "fcm_type": fcmType,
        "is_type_size": isTypeSize,
        "is_compulsory": isCompulsory,
        "fcv_id": fcvId,
        "rl_id_fk": rlIdFk,
        "f_id_fk": fIdFk,
        "fcm_id_fk": fcmIdFk,
        "fcv_name": fcvName,
        "fcv_extra_price": fcvExtraPrice,
        "fcv_rank": fcvRank,
        "fcv_is_default": fcvIsDefault,
        "fcv_status": fcvStatus,
        "customization_values":
            List<dynamic>.from(customizationValues.map((x) => x.toJson())),
      };
}

class CustomizationValue {
  CustomizationValue({
    this.fcvId,
    this.rlIdFk,
    this.fIdFk,
    this.fcmIdFk,
    this.fcvName,
    this.fcvExtraPrice,
    this.fcvRank,
    this.fcvIsDefault,
    this.fcvStatus,
  });

  int fcvId;
  int rlIdFk;
  int fIdFk;
  int fcmIdFk;
  String fcvName;
  String fcvExtraPrice;
  int fcvRank;
  int fcvIsDefault;
  String fcvStatus;

  factory CustomizationValue.fromJson(Map<String, dynamic> json) =>
      CustomizationValue(
        fcvId: json["fcv_id"],
        rlIdFk: json["rl_id_fk"],
        fIdFk: json["f_id_fk"],
        fcmIdFk: json["fcm_id_fk"],
        fcvName: json["fcv_name"],
        fcvExtraPrice: json["fcv_extra_price"],
        fcvRank: json["fcv_rank"],
        fcvIsDefault: json["fcv_is_default"],
        fcvStatus: json["fcv_status"],
      );

  Map<String, dynamic> toJson() => {
        "fcv_id": fcvId,
        "rl_id_fk": rlIdFk,
        "f_id_fk": fIdFk,
        "fcm_id_fk": fcmIdFk,
        "fcv_name": fcvName,
        "fcv_extra_price": fcvExtraPrice,
        "fcv_rank": fcvRank,
        "fcv_is_default": fcvIsDefault,
        "fcv_status": fcvStatus,
      };
}
