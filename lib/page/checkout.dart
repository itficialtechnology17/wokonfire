import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wokonfire/controller/cart_controller.dart';
import 'package:wokonfire/controller/user_controller.dart';
import 'package:wokonfire/page/order_details.dart';
import 'package:wokonfire/page/paytm_payemt.dart';
import 'package:wokonfire/page/profile/my_account.dart';
import 'package:wokonfire/utils/show_snackbar.dart';
import 'package:wokonfire/utils/ui_helper.dart';
import 'package:wokonfire/utils/utils.dart';

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
      body: ListView(
        shrinkWrap: true,
        children: [
          verticalSpaceMedium(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 4),
              title: Row(
                children: [
                  Text(
                      _userController.arrOfAddress[0].caTypeChoice
                          .toUpperCase(),
                      style: Theme.of(context).textTheme.headline6.copyWith(
                          fontSize: 14, letterSpacing: 1, color: Colors.black)),
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: InkWell(
              onTap: () {},
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 0),
                child: Text("Change Address",
                    style: Theme.of(context).textTheme.headline6.copyWith(
                        fontSize: 16, letterSpacing: 1, color: Colors.green)),
              ),
            ),
          ),
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
                Text('Discount', style: textStyle),
                Text(
                    '- Rs ' + _cartController.couponCode.value == null
                        ? '0'
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
                Text('Rs ' + _cartController.itemTotal.toString(),
                    style: textStyle),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        child: InkWell(
          splashColor: Colors.white,
          onTap: () async {
            Map<String, dynamic> checkResponse = checkPaymentProcess();
            if (checkResponse['code'] == 1) {
              var result = await Get.to(PaytmPayment());
              if (result == "YES") {
                Get.off(OrderDetails());
              } else {
                showSnackBar("Failed", "Payment Failed", Colors.red);
              }
            } else {
              Get.to(MyAccount(checkResponse['message']));
            }

            // Get.off(OrderDetails());
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
