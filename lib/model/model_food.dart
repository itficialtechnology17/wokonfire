// To parse this JSON data, do
//
//     final modelFood = modelFoodFromJson(jsonString);

import 'dart:convert';

import 'package:wokonfire/model/model_customization.dart';

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
    this.foodPosistId,
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
  dynamic foodSpiceType;
  int jainAvailable;
  String foodPosistId;
  int dtId;
  String finalPrice;
  String ftName;
  int fdQty;
  int isFavorite;
  bool isLoading = false;
  List<Customization> customization;

  factory ModelFood.fromJson(Map<String, dynamic> json) => ModelFood(
        foodId: json["food_id"],
        foodName: json["food_name"],
        foodCategoryId: json["food_category_id"],
        foodDesc: json["food_desc"],
        foodImage: json["food_image"] == null ? null : json["food_image"],
        price: json["price"],
        foodTypeId: json["food_type_id"],
        foodSpiceType: json["food_spice_type"],
        jainAvailable: json["jain_available"],
        foodPosistId: json["food_posist_id"],
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
        "food_image": foodImage == null ? null : foodImage,
        "price": price,
        "food_type_id": foodTypeId,
        "food_spice_type": foodSpiceType,
        "jain_available": jainAvailable,
        "food_posist_id": foodPosistId,
        "dt_id": dtId,
        "final_price": finalPrice,
        "ft_name": ftName,
        "fd_qty": fdQty,
        "is_favorite": isFavorite,
        "customization":
            List<dynamic>.from(customization.map((x) => x.toJson())),
      };
}
