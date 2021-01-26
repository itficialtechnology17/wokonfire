import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wokonfire/constant/constant_value.dart';
import 'package:wokonfire/controller/add_to_cart_controller.dart';
import 'package:wokonfire/model/model_food.dart';
import 'package:wokonfire/network/request.dart';
import 'package:wokonfire/page/customization_page.dart';
import 'package:wokonfire/utils/show_snackbar.dart';
import 'package:wokonfire/utils/url.dart';

class SearchController extends GetxController {
  var arrOfFood = List<ModelFood>().obs;
  AddToCartController _addToCartController = Get.find();

  @override
  void onInit() {
    super.onInit();
    _apiGetAllFood();
  }

  void _apiGetAllFood() async {
    Request request = Request(url: urlGetAllFood, body: {
      'type': "API",
      'c_id': userId,
      'restaurant_id': restaurantId,
    });

    request.post().then((value) {
      final responseData = json.decode(value.body);

      arrOfFood.value = (responseData['food'] as List)
          .map((data) => ModelFood.fromJson(data))
          .toList();

      print("Successful");
    }).catchError((onError) {
      print(onError);
    });
  }

  void handleAddToCart(int index, BuildContext context) async {
    if (arrOfFood[index].customization.isNotEmpty) {
      // openCustomization(index, nIndex);
      var result = await Navigator.of(context).push(
        PageRouteBuilder(
          opaque: false, // set to false
          pageBuilder: (_, __, ___) =>
              CustomizationPage.value(arrOfFood[index]),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var begin = Offset(0.0, 1.0);
            var end = Offset.zero;
            var curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        ),
      );

      if (result != null) {
        if (result['result'] == "1") {
          ModelFood modelFood = arrOfFood[index];

          modelFood.fdQty = modelFood.fdQty + 1;

          arrOfFood[index] = modelFood;
        }
      }
    } else {
      var result = await _addToCartController.apiAddToCart(
          arrOfFood[index].foodId.toString(), "");

      if (result != null) {
        if (result == 1) {
          ModelFood modelFood = arrOfFood[index];
          modelFood.fdQty = modelFood.fdQty + 1;
          arrOfFood[index] = modelFood;
        }
      }
    }
  }

  void handleRemoveToCart(int index) async {
    arrOfFood[index].isLoading = true;

    Map<String, dynamic> response = await _addToCartController
        .apiRemoveFromCart(arrOfFood[index].foodId.toString());

    arrOfFood[index].isLoading = false;
    if (response != null) {
      if (response['status_code'] == 1) {
        ModelFood modelFood = arrOfFood[index];

        modelFood.fdQty = modelFood.fdQty - 1;

        arrOfFood[index] = modelFood;
        showSnackBar("Message", response['message'], Colors.green);
      } else if (response['status_code'] == "2") {
        showSnackBar("Notify", response['message'], Colors.yellow);
      } else {
        showSnackBar("Error", response['message'], Colors.red);
      }
    }
  }
}
