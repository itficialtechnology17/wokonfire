import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:wokonfire/constant/constant_value.dart';
import 'package:wokonfire/controller/cart_controller.dart';
import 'package:wokonfire/model/model_order.dart';
import 'package:wokonfire/network/request.dart';
import 'package:wokonfire/utils/url.dart';

class OrderController extends GetxController {
  var isPlacingOrder = false.obs;
  CartController _cartController = Get.find();
  var arrOfOrder = List<ModelOrder>().obs;

  var isGettingOrder = false.obs;

  @override
  void onInit() {
    super.onInit();
    apiGetOrder();
  }

  void apiGetOrder() async {
    isGettingOrder.value = true;
    Request request = Request(url: urlGetOrder, body: {
      'type': "API",
      'c_id': userId,
      'restaurant_id': restaurantId,
    });
    request.post().then((value) {
      isGettingOrder.value = false;
      final responseData = json.decode(value.body);

      arrOfOrder.value = (responseData['orders'] as List)
          .map((data) => ModelOrder.fromJson(data))
          .toList();
    }).catchError((onError) {
      isGettingOrder.value = false;
      print(onError);
    });
  }

  Future<Map<String, dynamic>> placeOrder(
      addressId, paymentStatus, paymentStatusCode) async {
    Map<String, dynamic> map = Map<String, dynamic>();

    isPlacingOrder.value = true;
    final http.Response response = await http.post(
      urlBase + urlPlaceOrder,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'type': "API",
        'c_id': userId.toString(),
        'address_id': addressId.toString(),
        'payment_status': paymentStatus.toString(),
        'payment_response_code': paymentStatusCode.toString(),
        'restaurant_id': restaurantId.toString(),
      }),
    );

    if (response.statusCode == 200) {
      isPlacingOrder.value = false;
      var responseData = jsonDecode(response.body);
      if (responseData['status_code'] == 1) {
        _cartController.apiGetCartItem();
        map['status_code'] = 1;
        map['message'] = responseData['message'];
        // showSnackBar("Success", responseData['message'], Colors.green);
      } else {
        map['status_code'] = 0;
        map['message'] = responseData['message'];
        // showSnackBar("Failed", responseData['message'], Colors.green);
      }
      return responseData;
    } else {
      isPlacingOrder.value = false;
      map['status_code'] = 0;
      map['message'] = "Opps! Something went wrong.";
      return map;
    }
  }
}
