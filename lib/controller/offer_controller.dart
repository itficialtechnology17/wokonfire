import 'dart:convert';

import 'package:get/get.dart';
import 'package:wokonfire/constant/constant_value.dart';
import 'package:wokonfire/model/model_offer.dart';
import 'package:wokonfire/network/request.dart';
import 'package:wokonfire/utils/url.dart';

class OfferController extends GetxController {
  var arrOfOffer = List<ModelOffer>().obs;

  @override
  void onInit() {
    apiGetOffer();
    super.onInit();
  }

/*
  void apiGetOffer() async {
    Request request = Request(url: urlGetOffer, body: {
      'type': "API",
      'c_id': userId,
      'restaurant_id': restaurantId,
    });

    request.post().then((value) {
      final responseData = json.decode(value.body);

      arrOfOffer.value = (responseData['offers'] as List)
          .map((data) => ModelOffer.fromJson(data))
          .toList();
    }).catchError((onError) {
      print(onError);
    });
  }
*/

  void apiGetOffer() async {
    Request request = Request(url: urlGetOffer + "?type=API&c_id=$userId");

    request.get().then((value) {
      final responseData = json.decode(value.body);

      arrOfOffer.value = (responseData['offers'] as List)
          .map((data) => ModelOffer.fromJson(data))
          .toList();
    }).catchError((onError) {
      print(onError);
    });
  }
}
