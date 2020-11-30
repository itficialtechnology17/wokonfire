import 'dart:convert';

import 'model_customization.dart';

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
  int fdQty;
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
        fdQty: json["fd_qty"],
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
        "fd_qty": fdQty,
        "customization":
            List<dynamic>.from(customization.map((x) => x.toJson())),
      };
}
