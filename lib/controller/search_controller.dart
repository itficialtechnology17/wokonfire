import 'dart:convert';

import 'package:get/get.dart';
import 'package:wokonfire/constant/constant_value.dart';
import 'package:wokonfire/model/model_food.dart';
import 'package:wokonfire/network/request.dart';
import 'package:wokonfire/utils/url.dart';

class SearchController extends GetxController {
  var arrOfFood = List<ModelFood>().obs;

  @override
  void onInit() {
    super.onInit();
    _apiGetAllFood();
  }

  void _apiGetAllFood() async {
    Request request = Request(url: urlGetAllFood, body: {
      'type': "API",
      'c_id': "26",
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
}
