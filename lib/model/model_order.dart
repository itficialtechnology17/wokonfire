// To parse this JSON data, do
//
//     final modelOrder = modelOrderFromJson(jsonString);

import 'dart:convert';

List<ModelOrder> modelOrderFromJson(String str) =>
    List<ModelOrder>.from(json.decode(str).map((x) => ModelOrder.fromJson(x)));

String modelOrderToJson(List<ModelOrder> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelOrder {
  ModelOrder({
    this.oId,
    this.orderNo,
    this.cIdFk,
    this.orderDeliveryType,
    this.totalAmount,
    this.discountAmount,
    this.discountType,
    this.couponCodeId,
    this.addressId,
    this.orderStatus,
    this.orderSource,
    this.paymentStatus,
    this.paymentType,
    this.gatewayId,
    this.paymentResponseCode,
    this.addedOn,
    this.cartIds,
    this.orderStatusText,
    this.date,
    this.time,
    this.deliveryCharge,
    this.caLat,
    this.caLong,
    this.caMapAddress,
    this.data,
    this.taxCharges,
  });

  int oId;
  String orderNo;
  int cIdFk;
  String orderDeliveryType;
  int totalAmount;
  int discountAmount;
  int discountType;
  int couponCodeId;
  int addressId;
  String orderStatus;
  int orderSource;
  int paymentStatus;
  String paymentType;
  int gatewayId;
  String paymentResponseCode;
  DateTime addedOn;
  String cartIds;
  String orderStatusText;
  String date;
  String time;
  int deliveryCharge;
  double caLat;
  double caLong;
  String caMapAddress;
  List<Datum> data;
  int taxCharges;

  factory ModelOrder.fromJson(Map<String, dynamic> json) => ModelOrder(
        oId: json["o_id"],
        orderNo: json["order_no"],
        cIdFk: json["c_id_fk"],
        orderDeliveryType: json["order_delivery_type"],
        totalAmount: json["total_amount"],
        discountAmount: json["discount_amount"],
        discountType: json["discount_type"],
        couponCodeId: json["coupon_code_id"],
        addressId: json["address_id"],
        orderStatus: json["order_status"],
        orderSource: json["order_source"],
        paymentStatus: json["payment_status"],
        paymentType: json["payment_type"],
        gatewayId: json["gateway_id"],
        paymentResponseCode: json["payment_response_code"],
        addedOn: DateTime.parse(json["added_on"]),
        cartIds: json["cart_ids"],
        orderStatusText: json["order_status_text"],
        date: json["date"],
        time: json["time"],
        deliveryCharge: json["delivery_charge"],
        caLat: json["ca_lat"].toDouble(),
        caLong: json["ca_long"].toDouble(),
        caMapAddress: json["ca_map_address"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        taxCharges: json["tax_charges"],
      );

  Map<String, dynamic> toJson() => {
        "o_id": oId,
        "order_no": orderNo,
        "c_id_fk": cIdFk,
        "order_delivery_type": orderDeliveryType,
        "total_amount": totalAmount,
        "discount_amount": discountAmount,
        "discount_type": discountType,
        "coupon_code_id": couponCodeId,
        "address_id": addressId,
        "order_status": orderStatus,
        "order_source": orderSource,
        "payment_status": paymentStatus,
        "payment_type": paymentType,
        "gateway_id": gatewayId,
        "payment_response_code": paymentResponseCode,
        "added_on": addedOn.toIso8601String(),
        "cart_ids": cartIds,
        "order_status_text": orderStatusText,
        "date": date,
        "time": time,
        "delivery_charge": deliveryCharge,
        "ca_lat": caLat,
        "ca_long": caLong,
        "ca_map_address": caMapAddress,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "tax_charges": taxCharges,
      };
}

class Datum {
  Datum({
    this.cOrderStatus,
    this.foodName,
    this.foodDesc,
    this.foodImage,
    this.price,
    this.offCode,
    this.offTitle,
    this.offPhoto,
    this.quantity,
    this.fcvName,
    this.rlName,
    this.rlAddress,
    this.rlLat,
    this.rlLon,
  });

  String cOrderStatus;
  String foodName;
  String foodDesc;
  dynamic foodImage;
  String price;
  String offCode;
  String offTitle;
  String offPhoto;
  int quantity;
  String fcvName;
  String rlName;
  String rlAddress;
  String rlLat;
  String rlLon;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        cOrderStatus: json["c_order_status"],
        foodName: json["food_name"],
        foodDesc: json["food_desc"],
        foodImage: json["food_image"],
        price: json["price"],
        offCode: json["off_code"],
        offTitle: json["off_title"],
        offPhoto: json["off_photo"],
        quantity: json["quantity"],
        fcvName: json["fcv_name"] == null ? null : json["fcv_name"],
        rlName: json["rl_name"],
        rlAddress: json["rl_address"],
        rlLat: json["rl_lat"],
        rlLon: json["rl_lon"],
      );

  Map<String, dynamic> toJson() => {
        "c_order_status": cOrderStatus,
        "food_name": foodName,
        "food_desc": foodDesc,
        "food_image": foodImage,
        "price": price,
        "off_code": offCode,
        "off_title": offTitle,
        "off_photo": offPhoto,
        "quantity": quantity,
        "fcv_name": fcvName == null ? null : fcvName,
        "rl_name": rlName,
        "rl_address": rlAddress,
        "rl_lat": rlLat,
        "rl_lon": rlLon,
      };
}
