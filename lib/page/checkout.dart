import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wokonfire/controller/cart_controller.dart';
import 'package:wokonfire/controller/order_controller.dart';
import 'package:wokonfire/controller/user_controller.dart';
import 'package:wokonfire/model/model_address.dart';
import 'package:wokonfire/page/paytm_payment.dart';
import 'package:wokonfire/page/profile/my_account.dart';
import 'package:wokonfire/page/select_address.dart';
import 'package:wokonfire/utils/show_snackbar.dart';
import 'package:wokonfire/utils/ui_helper.dart';
import 'package:wokonfire/utils/utils.dart';

import 'order_details.dart';

class Checkout extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StateCheckOut();
  }
}

class _StateCheckOut extends State<Checkout> {
  UserController _userController = Get.find();
  CartController _cartController = Get.find();

  int selectedWallet = -1;
  int selectedMethod = 0;
  OrderController _orderController = Get.find();
  ModelAddress modelAddress;
  var isAddressEmpty = false;
  @override
  void initState() {
    super.initState();
    if (_userController.arrOfAddress.isEmpty) {
      isAddressEmpty = true;
      modelAddress = ModelAddress();
    } else {
      isAddressEmpty = false;
      modelAddress = _userController.arrOfAddress[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    final textStyle =
        Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 16.0);

    final textStyleGreen = Theme.of(context)
        .textTheme
        .bodyText1
        .copyWith(fontSize: 16.0, color: Colors.green);

    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: Material(
          color: Colors.transparent,
          type: MaterialType.circle,
          clipBehavior: Clip.hardEdge,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Platform.isAndroid
                  ? Icons.keyboard_backspace
                  : Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          "Checkout",
          style: Theme.of(context).textTheme.headline6.merge(
                TextStyle(letterSpacing: 1.3, color: Colors.black),
              ),
        ),
      ),
      body: Obx(() => ListView(
            shrinkWrap: true,
            children: [
              verticalSpaceMedium(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: !isAddressEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(horizontal: 4),
                            title: Row(
                              children: [
                                Text(modelAddress.caTypeChoice.toUpperCase(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .copyWith(
                                            fontSize: 14,
                                            letterSpacing: 1,
                                            color: Colors.black)),
                              ],
                            ),
                            subtitle: Padding(
                              padding: EdgeInsets.only(top: 8),
                              child: Text(
                                modelAddress.caMapAddress,
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          InkWell(
                            onTap: () async {
                              ModelAddress resultModelAddress =
                                  await Navigator.of(context).push(
                                PageRouteBuilder(
                                  opaque: false, // set to false
                                  pageBuilder: (_, __, ___) => SelectAddress(),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    var begin = Offset(0.0, 1.0);
                                    var end = Offset.zero;
                                    var curve = Curves.ease;

                                    var tween = Tween(begin: begin, end: end)
                                        .chain(CurveTween(curve: curve));

                                    return SlideTransition(
                                      position: animation.drive(tween),
                                      child: child,
                                    );
                                  },
                                ),
                              );
                              setState(() {
                                modelAddress = resultModelAddress;
                              });
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 4),
                              child: Text("Change Address",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .copyWith(
                                          fontSize: 14,
                                          letterSpacing: 1,
                                          color: Colors.green)),
                            ),
                          )
                        ],
                      )
                    : InkWell(
                        onTap: () async {
                          ModelAddress resultModelAddress =
                              await Navigator.of(context).push(
                            PageRouteBuilder(
                              opaque: false, // set to false
                              pageBuilder: (_, __, ___) => SelectAddress(),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                var begin = Offset(0.0, 1.0);
                                var end = Offset.zero;
                                var curve = Curves.ease;

                                var tween = Tween(begin: begin, end: end)
                                    .chain(CurveTween(curve: curve));

                                return SlideTransition(
                                  position: animation.drive(tween),
                                  child: child,
                                );
                              },
                            ),
                          );

                          setState(() {
                            modelAddress = resultModelAddress;
                          });
                        },
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                          child: Row(
                            children: [
                              Text(
                                  _userController.arrOfAddress.isEmpty
                                      ? "Please Select Address".toUpperCase()
                                      : "Change Address".toUpperCase(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .copyWith(
                                          fontSize: 16,
                                          letterSpacing: 1,
                                          color: Colors.green)),
                              Spacer(),
                              Icon(
                                Icons.navigate_next,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                      ),
              ),
              /*Visibility(
                visible: _userController.arrOfAddress.isEmpty ? false : true,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 4),
                    title: Row(
                      children: [
                        Text(
                            _userController.arrOfAddress[0].caTypeChoice
                                .toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(
                                    fontSize: 14,
                                    letterSpacing: 1,
                                    color: Colors.black)),
                      ],
                    ),
                    subtitle: Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Text(
                        _userController.arrOfAddress[0].caMapAddress,
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: ,
              ),*/
              verticalSpaceMedium(),
              Container(
                height: Get.height * 0.05,
                width: Get.width,
                padding: EdgeInsets.symmetric(horizontal: 16),
                color: Colors.grey[200],
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Payment Method",
                      style: Theme.of(context).textTheme.headline6.copyWith(
                            fontSize: 14,
                            letterSpacing: 1,
                          )),
                ),
              ),
              RadioListTile(
                value: 1,
                groupValue: selectedMethod,
                title: Text("Debit,Credit Card Or UPI"),
                onChanged: (val) {
                  setSelectedRadioTile(val);
                },
                secondary: Image.asset(
                  "assets/icons/google_pay.webp",
                  width: Get.width * 0.10,
                  height: Get.width * 0.10,
                ),
                selected: false,
              ),
              RadioListTile(
                value: 2,
                groupValue: selectedMethod,
                title: Text("Paytm"),
                subtitle: Text("Pay easily using your saved paytm methods"),
                onChanged: (val) {
                  print("Radio Tile pressed $val");
                  setSelectedRadioTile(val);
                },
                secondary: Image.asset(
                  "assets/icons/paytm.webp",
                  width: Get.width * 0.10,
                  height: Get.width * 0.10,
                ),
                selected: false,
              ),
              Container(
                height: Get.height * 0.05,
                width: Get.width,
                padding: EdgeInsets.symmetric(horizontal: 16),
                color: Colors.grey[200],
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Wallet",
                      style: Theme.of(context).textTheme.headline6.copyWith(
                            fontSize: 14,
                            letterSpacing: 1,
                          )),
                ),
              ),
              CheckboxListTile(
                value: selectedWallet == 0 ? true : false,
                onChanged: (value) {
                  setState(() {
                    selectedWallet = 0;
                  });
                },
                title: Text("Wallet Balance"),
              ),
              CheckboxListTile(
                value: selectedWallet == 1 ? true : false,
                onChanged: (value) {
                  setState(() {
                    selectedWallet = 1;
                  });
                },
                title: Text("Points"),
              ),
              Container(
                height: Get.height * 0.05,
                width: Get.width,
                padding: EdgeInsets.symmetric(horizontal: 16),
                color: Colors.grey[200],
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Bill Details",
                      style: Theme.of(context).textTheme.headline6.copyWith(
                            fontSize: 14,
                            letterSpacing: 1,
                          )),
                ),
              ),
              verticalSpaceSmall(),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Item total', style: textStyle),
                      Text('Rs ' + _cartController.itemTotal.toString(),
                          style: textStyle),
                    ],
                  )),
              verticalSpaceMedium(),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Taxes and Charges', style: textStyle),
                      Text('Rs ' + _cartController.taxesAndCharges.toString(),
                          style: textStyle),
                    ],
                  )),
              verticalSpaceMedium(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Delivery Fee', style: textStyle),
                    Text('Rs ' + _cartController.deliveryFees.toString(),
                        style: textStyle),
                  ],
                ),
              ),
              verticalSpaceMedium(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Discount', style: textStyle),
                    Text(
                        _cartController.couponCode.value == null
                            ? '- Rs 0'
                            : '- Rs ' + _cartController.discount.toString(),
                        style: textStyleGreen),
                  ],
                ),
              ),
              verticalSpaceMedium(),
              Container(
                color: Colors.grey[50],
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('To Pay', style: textStyle),
                    Text('Rs ' + _cartController.amountToPay.toString(),
                        style: textStyle),
                  ],
                ),
              )
            ],
          )),
      bottomNavigationBar: Container(
        child: InkWell(
          splashColor: Colors.white,
          onTap: () async {
            Map<String, dynamic> checkResponse = checkPaymentProcess();
            if (checkResponse['code'] == 1) {
              Map<String, dynamic> responseJSON = await Get.to(PaytmPayment());
              if (responseJSON["STATUS"] == "TXN_SUCCESS") {
                var placeOrderResponse = await _orderController.placeOrder(
                    modelAddress.caId.toString(),
                    "1",
                    responseJSON["RESPCODE"]);

                if (placeOrderResponse['status_code'] == 1) {
                  showSnackBar(
                      "Success", placeOrderResponse['message'], Colors.green);
                  Get.off(OrderDetails());
                } else {
                  showSnackBar(
                      "Failed", placeOrderResponse['message'], Colors.red);
                }
              } else {
                showSnackBar("Failed", "Payment Failed", Colors.red);
              }
            } else {
              Get.to(MyAccount(checkResponse['message']));
            }
          },
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(6.0),
            color: Colors.green,
            height: Get.height * 0.07,
            child: Center(
              child: Text(
                "MAKE PAYMENT",
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    .copyWith(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }

  setSelectedRadioTile(int val) {
    setState(() {
      selectedMethod = val;
    });
  }
}
