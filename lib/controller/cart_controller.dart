import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:wokonfire/constant/constant_value.dart';
import 'package:wokonfire/model/model_cart.dart';
import 'package:wokonfire/network/request.dart';
import 'package:wokonfire/utils/show_snackbar.dart';
import 'package:wokonfire/utils/url.dart';

class CartController extends GetxController {
  var arrOfCart = List<ModelCart>().obs;
  var itemTotal = 0.obs;
  var deliveryFees = 0.obs;
  var taxesAndCharges = 0.obs;
  var amountToPay = 0.obs;
  var couponCode = "".obs;
  var discount = 0.obs;
  var isApplyingOffer = false.obs;
  var totalItemCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    apiGetCartItem();
  }

  void apiGetCartItem() async {
    Request request = Request(url: urlGetCartItem, body: {
      'type': "API",
      'c_id': userId,
      'restaurant_id': restaurantId,
    });
    request.post().then((value) {
      final responseData = json.decode(value.body);

      arrOfCart.value = (responseData['view_cart'] as List)
          .map((data) => ModelCart.fromJson(data))
          .toList();

      itemTotal.value = responseData['total_amount'];
      deliveryFees.value = responseData['delivery_charge'];
      taxesAndCharges.value = responseData['tax'];
      amountToPay.value = responseData['total_pay'];
      couponCode.value = responseData['coupon_code'];
      discount.value = responseData['discount'];

      // countPayAmount();
      countItemTotal();
      print("Successful");
    }).catchError((onError) {
      print(onError);
    });
  }

  Future<Map<String, dynamic>> apiApplyCoupon(code, offerId) async {
    isApplyingOffer.value = true;

    final http.Response response = await http.post(
      urlBase + urlApplyCoupon,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'type': "API",
        'c_id': userId,
        'restaurant_id': restaurantId,
        'code': code.toString(),
        'offer_id': offerId.toString(),
      }),
    );

    if (response.statusCode == 200) {
      isApplyingOffer.value = false;
      var responseData = jsonDecode(response.body);
      return responseData;
    } else {
      isApplyingOffer.value = false;
      Map<String, dynamic> map = Map<String, String>();
      map['status_code'] = 1;
      map['message'] = "Opps! Something went wrong.";
      return map;
    }
  }

  void apiRemoveCoupon() async {
    isApplyingOffer.value = true;

    final http.Response response = await http.post(
      urlBase + urlRemoveCoupon,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'type': "API",
        'c_id': userId,
      }),
    );

    if (response.statusCode == 200) {
      isApplyingOffer.value = false;
      var responseData = jsonDecode(response.body);
      if (responseData['status_code'] == 1) {
        apiGetCartItem();
      }
    } else {
      isApplyingOffer.value = false;
      showSnackBar("Error", "Opps! Something went wrong.", Colors.red);
    }
  }

  void removeFromCart(index) {
    if (arrOfCart[index].quantity > 0) {
      arrOfCart[index].quantity -= 1;
    }
  }

  void addAddMore(index) {
    arrOfCart[index].quantity += 1;
  }

  void countItemTotal() {
    int count = 0;
    for (int i = 0; i < arrOfCart.length; i++) {
      count = count + arrOfCart[i].quantity;
    }
    totalItemCount.value = count;
  }

/*  void countPayAmount() {
    for (int i = 0; i < arrOfCart.length; i++) {
      itemTotal.value = itemTotal.value + int.parse(arrOfCart[i].finalPrice);
      amountToPay.value =
          amountToPay.value + int.parse(arrOfCart[i].finalPrice);
    }
    amountToPay.value =
        amountToPay.value + deliveryFees.value + taxesAndCharges.value;
  }*/
}
