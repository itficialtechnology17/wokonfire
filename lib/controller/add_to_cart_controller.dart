import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:wokonfire/constant/constant_value.dart';
import 'package:wokonfire/utils/url.dart';

class AddToCartController extends GetxController {
  // CustomizationController _customizationController = Get.find();
  // HomeController _homeController = Get.find();
  var isAddToCartLoading = false.obs;

  void removeFromCart(int index, [int nIndex]) {}

/*  var controllerType = 0.obs;
  void addToCart(int paramControllerType, int index, [int nIndex]) {
    controllerType.value = paramControllerType;
    if (controllerType.value == 0) {
      //Check Customization Available
      if (_homeController.arrOfDashboardTitle[index].foodItems[nIndex]
          .customization.isNotEmpty) {
        _customizationController.openCustomization(
            controllerType.value, index, nIndex);
      } else {
        ModelDashboardTitle modelDashboardTitle =
            _homeController.arrOfDashboardTitle[index];

        modelDashboardTitle.foodItems[nIndex].fdQty =
            modelDashboardTitle.foodItems[nIndex].fdQty + 1;

        _homeController.arrOfDashboardTitle[index] = modelDashboardTitle;

        print("Item Count After Add=" +
            _homeController.arrOfDashboardTitle[index].foodItems[nIndex].fdQty
                .toString());
      }
    }
  }*/

/*  void removeFromCart(int paramControllerType, int index, [int nIndex]) {
    controllerType.value = paramControllerType;

    if (controllerType.value == 0) {
      ModelDashboardTitle modelDashboardTitle =
          _homeController.arrOfDashboardTitle[index];

      modelDashboardTitle.foodItems[nIndex].fdQty =
          modelDashboardTitle.foodItems[nIndex].fdQty - 1;

      _homeController.arrOfDashboardTitle[index] = modelDashboardTitle;

      print("Item Count After Remove =" +
          _homeController.arrOfDashboardTitle[index].foodItems[nIndex].fdQty
              .toString());
    }
  }*/
/*
  Future<int> addItemToCart() async {
    var url =
        "$baseUrl$urlGetBookmark?type=API&standard_id=$standardId&student_id=$studentId";
    final res = await http.get(url);

    if (res.statusCode == 200) {
      final response = json.decode(res.body);

      var arr = response['data'] as List;
      return arr.map((e) => ModelBookmark.fromJson(e)).toList();
    }

    return List<ModelBookmark>();
  }*/

/*  void apiAddToCart(foodId, customizationId) async {
    isAddToCartLoading.value = true;

    Request request = Request(url: urlAddToCart, body: {
      'type': "API",
      'c_id': userId,
      'r_id': restaurantId,
      'f_id': foodId,
      'customization_id': customizationId,
    });

    request.post().then((value) {
      isAddToCartLoading.value = false;

      final responseData = json.decode(value.body);
      if (responseData["status_code"] == 1) {
      } else {
        Get.snackbar("Failed", responseData["message"],
            backgroundColor: Colors.red,
            borderRadius: 3,
            colorText: Colors.white);
      }
    }).catchError((onError) {
      print(onError);
    });
  }*/

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
      return responseData;
    } else {
      Map<String, dynamic> map = Map<String, String>();
      map['status_code'] = 1;
      map['message'] = "Opps! Something went wrong.";
      return map;
    }
  }
}
