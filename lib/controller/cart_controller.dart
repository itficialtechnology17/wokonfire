import 'dart:convert';

import 'package:get/get.dart';
import 'package:wokonfire/constant/constant_value.dart';
import 'package:wokonfire/model/model_cart.dart';
import 'package:wokonfire/network/request.dart';
import 'package:wokonfire/utils/url.dart';

class CartController extends GetxController {
  var arrOfCart = List<ModelCart>().obs;
  var itemTotal = 0.obs;
  var deliveryFees = 10.obs;
  var taxesAndCharges = 15.obs;
  var amountToPay = 0.obs;

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

      amountToPay.value = 0;
      countPayAmount();
      print("Successful");
    }).catchError((onError) {
      print(onError);
    });
  }

  void removeFromCart(index) {
    if (arrOfCart[index].quantity > 0) {
      arrOfCart[index].quantity -= 1;
    }
  }

  void addAddMore(index) {
    arrOfCart[index].quantity += 1;
  }

  void countPayAmount() {
    for (int i = 0; i < arrOfCart.length; i++) {
      itemTotal.value = itemTotal.value + int.parse(arrOfCart[i].finalPrice);
      amountToPay.value =
          amountToPay.value + int.parse(arrOfCart[i].finalPrice);
    }
    amountToPay.value =
        amountToPay.value + deliveryFees.value + taxesAndCharges.value;
  }
}
