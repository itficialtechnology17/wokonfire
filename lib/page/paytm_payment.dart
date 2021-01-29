import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:wokonfire/constant/constant_value.dart';
import 'package:wokonfire/controller/cart_controller.dart';
import 'package:wokonfire/controller/user_controller.dart';
import 'package:wokonfire/utils/url.dart';

class PaytmPayment extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StatePaytmPayment();
  }
}

class _StatePaytmPayment extends State<PaytmPayment> {
  var webUrl;
  UserController _userController = Get.find();
  CartController _cartController = Get.find();

  bool _loadingPayment = true;
  String _responseStatus = STATUS_LOADING;

  WebViewController _webController;

  @override
  void initState() {
    super.initState();
  }

  void getData() {
    _webController.evaluateJavascript("document.body.innerText").then((data) {
      var decodedJSON = jsonDecode(data);
      Map<String, dynamic> responseJSON = jsonDecode(decodedJSON);
      if (responseJSON["STATUS"] == "TXN_SUCCESS") {
        Navigator.pop(context, responseJSON);
      } else if (responseJSON["STATUS"] == "TXN_FAILURE") {
        Navigator.pop(context, responseJSON);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text("Pay Using Paytm"),
        ),
        body: Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: WebView(
                debuggingEnabled: false,
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (controller) {
                  _webController = controller;
                  /*_webController.loadUrl(urlBase +
                      "PaytmKit/TxnTest.php?amount=10000&customer_id=" +
                      userId.toString() +
                      "&email=" +
                      _userController.modelUser.value.email.toString() +
                      "");*/
                  _webController.loadUrl(urlBase +
                      "PaytmKit/TxnTest.php?amount=" +
                      _cartController.amountToPay.toString() +
                      "&customer_id=" +
                      userId.toString() +
                      "&email=" +
                      _userController.modelUser.value.email.toString() +
                      "");
                },
                onPageFinished: (page) {
                  if (page.contains("/processTransaction")) {
                    if (_loadingPayment) {
                      this.setState(() {
                        _loadingPayment = false;
                      });
                    }
                  }
                  if (page.contains("pgResponse.php")) {
                    getData();
                  }
                },
              ),
            ),
            (_loadingPayment)
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Center(),
          ],
        ));
  }
}
