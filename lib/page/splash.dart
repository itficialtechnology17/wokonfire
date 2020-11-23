import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wokonfire/constant/constant_value.dart';
import 'package:wokonfire/constant/constants_key.dart';
import 'package:wokonfire/controller/user_controller.dart';
import 'package:wokonfire/page/locationlogin.dart';
import 'package:wokonfire/utils/shared_preference.dart';

class Splash extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StateSplash();
  }
}

class _StateSplash extends State<Splash> {
  UserController _userController = Get.put(UserController());

  @override
  void initState() {
    super.initState();
    var _duration = new Duration(seconds: 2);
    Timer(_duration, loadPrefs);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Container(
                color: Colors.red[800],
                height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(
                    child: CircleAvatar(
                      radius: 150,
                      backgroundImage: AssetImage("assets/images/ic_logo.png"),
                    ),
                  ),
                )),
          )
        ],
      ),
    );
  }

  loadPrefs() async {
    isLogin = await getBoolValuesSF(KEY_IS_LOGIN) ?? false;

    if (isLogin) {
      userId = await getStringValuesSF(KEY_IS_USER_ID) ?? "26";
      latitude = await getStringValuesSF(KEY_LATITUDE) ?? "21.143740";
      longitude = await getStringValuesSF(KEY_LONGITUDE) ?? "72.780731";
      currentArea = await getStringValuesSF(KEY_AREA) ?? "Unknown";
      currentAddress = await getStringValuesSF(KEY_ADDRESS) ?? "Unknown";
      _userController.getMyAccount(1);
    } else {
      Get.off(LocationLogin());
    }
  }
}
