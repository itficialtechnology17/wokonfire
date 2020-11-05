import 'dart:convert';

import 'package:get/get.dart';
import 'package:wokonfire/model/model_cart.dart';
import 'package:wokonfire/network/request.dart';
import 'package:wokonfire/utils/url.dart';

class CartController extends GetxController {
  var arrOfCart = List<ModelCart>().obs;

  @override
  void onInit() {
    super.onInit();
    _apiGetCartItem();
  }

  void _apiGetCartItem() async {
    Request request = Request(url: urlGetCartItem, body: {
      'type': "API",
      'c_id': "26",
      'restaurant_id': "1",
    });
    request.post().then((value) {
      final responseData = json.decode(value.body);

      arrOfCart.value = (responseData['view_cart'] as List)
          .map((data) => ModelCart.fromJson(data))
          .toList();

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
}
