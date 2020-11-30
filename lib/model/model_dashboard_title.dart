import 'dart:convert';

import 'model_customization.dart';

List<ModelDashboardTitle> modelDashboardTitleFromJson(String str) =>
    List<ModelDashboardTitle>.from(
        json.decode(str).map((x) => ModelDashboardTitle.fromJson(x)));

String modelDashboardTitleToJson(List<ModelDashboardTitle> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelDashboardTitle {
  ModelDashboardTitle({
    this.dtId,
    this.dtName,
    this.dtRank,
    this.rlId,
    this.foodItems,
  });

  int dtId;
  String dtName;
  int dtRank;
  int rlId;
  List<FoodItem> foodItems;

  factory ModelDashboardTitle.fromJson(Map<String, dynamic> json) =>
      ModelDashboardTitle(
        dtId: json["dt_id"],
        dtName: json["dt_name"],
        dtRank: json["dt_rank"],
        rlId: json["rl_id"],
        foodItems: List<FoodItem>.from(
            json["food_items"].map((x) => FoodItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "dt_id": dtId,
        "dt_name": dtName,
        "dt_rank": dtRank,
        "rl_id": rlId,
        "food_items": List<dynamic>.from(foodItems.map((x) => x.toJson())),
      };
}

class FoodItem {
  FoodItem({
    this.foodId,
    this.foodName,
    this.foodCategoryId,
    this.foodDesc,
    this.foodImage,
    this.price,
    this.foodTypeId,
    this.foodSpiceType,
    this.jainAvailable,
    this.dtId,
    this.finalPrice,
    this.ftName,
    this.fdQty,
    this.isFavorite,
    this.customization,
  });

  int foodId;
  String foodName;
  int foodCategoryId;
  String foodDesc;
  String foodImage;
  String price;
  int foodTypeId;
  int foodSpiceType;
  int jainAvailable;
  int dtId;
  String finalPrice;
  String ftName;
  int fdQty;
  int isFavorite;
  List<Customization> customization;

  factory FoodItem.fromJson(Map<String, dynamic> json) => FoodItem(
        foodId: json["food_id"],
        foodName: json["food_name"],
        foodCategoryId: json["food_category_id"],
        foodDesc: json["food_desc"],
        foodImage: json["food_image"],
        price: json["price"],
        foodTypeId: json["food_type_id"],
        foodSpiceType: json["food_spice_type"],
        jainAvailable: json["jain_available"],
        dtId: json["dt_id"],
        finalPrice: json["final_price"],
        ftName: json["ft_name"],
        fdQty: json["fd_qty"],
        isFavorite: json["is_favorite"],
        customization: List<Customization>.from(
            json["customization"].map((x) => Customization.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "food_id": foodId,
        "food_name": foodName,
        "food_category_id": foodCategoryId,
        "food_desc": foodDesc,
        "food_image": foodImage,
        "price": price,
        "food_type_id": foodTypeId,
        "food_spice_type": foodSpiceType,
        "jain_available": jainAvailable,
        "dt_id": dtId,
        "final_price": finalPrice,
        "ft_name": ftName,
        "fd_qty": fdQty,
        "is_favorite": isFavorite,
        "customization":
            List<dynamic>.from(customization.map((x) => x.toJson())),
      };
}
/*
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
  bool isSelected = false;

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
}*/
