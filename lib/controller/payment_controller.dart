import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wokonfire/constant/constant_value.dart';
import 'package:wokonfire/network/request.dart';
import 'package:wokonfire/utils/url.dart';

class PaymentController extends GetxController {
  static const platform = const MethodChannel('flutter.native/helper');

  var isTokenGenerating = false.obs;

  Future<void> doPaytmPayment(token, amount, orderId) async {
    var arguments = <String, dynamic>{
      "mid": merchantId,
      "orderId": orderId,
      "amount": amount,
      "txnToken": token,
      "isStaging": isStaging
    };
    try {
      var result = await platform.invokeMethod("startTransaction", arguments);
      print(result.toString());
    } catch (err) {
      print(err.message);
    }
  }

  void apiGetToken() async {
    Request request = Request(url: urlGetToken, body: {
      'type': "API",
      'amount': "1",
      'c_id': userId.toString(),
      'payment_source': "TEST",
    });
    request.post().then((value) {
      final responseData = json.decode(value.body);

      if (responseData['status_code'] == 1) {
        doPaytmPayment(
            responseData['paytmChecksum'], "1", responseData['order_id']);
      }

      print("Successful");
    }).catchError((onError) {
      print(onError);
    });
  }
}
