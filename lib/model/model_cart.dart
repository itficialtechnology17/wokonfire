import 'dart:convert';

List<ModelCart> modelCartFromJson(String str) =>
    List<ModelCart>.from(json.decode(str).map((x) => ModelCart.fromJson(x)));

String modelCartToJson(List<ModelCart> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelCart {
  ModelCart({
    this.cartId,
    this.cIdFk,
    this.fIdFk,
    this.rlIdFk,
    this.oId,
    this.quantity,
    this.customIdFk,
    this.discountAmount,
    this.cOrderStatus,
    this.timestamp,
    this.addedOn,
    this.editedOn,
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
    this.finalPrice,
    this.customization,
  });

  int cartId;
  int cIdFk;
  int fIdFk;
  int rlIdFk;
  dynamic oId;
  int quantity;
  String customIdFk;
  dynamic discountAmount;
  String cOrderStatus;
  DateTime timestamp;
  dynamic addedOn;
  dynamic editedOn;
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
  String finalPrice;
  String customization;

  factory ModelCart.fromJson(Map<String, dynamic> json) => ModelCart(
        cartId: json["cart_id"],
        cIdFk: json["c_id_fk"],
        fIdFk: json["f_id_fk"],
        rlIdFk: json["rl_id_fk"],
        oId: json["o_id"],
        quantity: json["quantity"],
        customIdFk: json["custom_id_fk"],
        discountAmount: json["discount_amount"],
        cOrderStatus: json["c_order_status"],
        timestamp: DateTime.parse(json["timestamp"]),
        addedOn: json["added_on"],
        editedOn: json["edited_on"],
        foodId: json["food_id"],
        foodName: json["food_name"],
        foodCategoryId: json["food_category_id"],
        foodDesc: json["food_desc"],
        foodImage: json["food_image"],
        price: json["price"],
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
        finalPrice: json["final_price"],
        customization: json["customization"],
      );

  Map<String, dynamic> toJson() => {
        "cart_id": cartId,
        "c_id_fk": cIdFk,
        "f_id_fk": fIdFk,
        "rl_id_fk": rlIdFk,
        "o_id": oId,
        "quantity": quantity,
        "custom_id_fk": customIdFk,
        "discount_amount": discountAmount,
        "c_order_status": cOrderStatus,
        "timestamp": timestamp.toIso8601String(),
        "added_on": addedOn,
        "edited_on": editedOn,
        "food_id": foodId,
        "food_name": foodName,
        "food_category_id": foodCategoryId,
        "food_desc": foodDesc,
        "food_image": foodImage,
        "price": price,
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
        "final_price": finalPrice,
        "customization": customization,
      };
}
