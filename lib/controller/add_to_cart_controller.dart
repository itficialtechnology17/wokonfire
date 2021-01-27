import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:wokonfire/constant/constant_value.dart';
import 'package:wokonfire/controller/cart_controller.dart';
import 'package:wokonfire/utils/url.dart';

class AddToCartController extends GetxController {
  var isAddToCartLoading = false.obs;

  CartController _cartController = Get.find();

  Future<int> apiAddToCart(foodId, customizationId) async {
    final http.Response response = await http.post(
      urlBase + urlAddToCart,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'type': "API",
        'user_id': userId,
        'restaurant_id': restaurantId,
        'food_id': foodId,
        'Add_On': customizationId,
      }),
    );

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      if (responseData['status_code'] == 1) {
        _cartController.apiGetCartItem();
        return 1;
      } else {
        return 0;
      }
    } else {
      return 0;
    }
  }

  Future<Map<String, dynamic>> apiRemoveFromCart(foodId) async {
    final http.Response response = await http.post(
      urlBase + urlRemoveFromCart,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'type': "API",
        'c_id': userId,
        'restaurant_id': restaurantId,
        'food_id': foodId
      }),
    );

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      _cartController.apiGetCartItem();
      return responseData;
    } else {
      Map<String, dynamic> map = Map<String, String>();
      map['status_code'] = 1;
      map['message'] = "Opps! Something went wrong.";
      return map;
    }
  }
}
