import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wokonfire/constant/constant_value.dart';
import 'package:wokonfire/constant/constants_key.dart';
import 'package:wokonfire/controller/user_controller.dart';
import 'package:wokonfire/page/home.dart';
import 'package:wokonfire/page/location_picker.dart';
import 'package:wokonfire/page/login.dart';
import 'package:wokonfire/utils/custom_color.dart';
import 'package:wokonfire/utils/shared_preference.dart';

class LocationLogin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StateLocationLogin();
  }
}

class _StateLocationLogin extends State<LocationLogin> {
  var isLoginDone = false;
  var isLocationAdded = false;
  var address = "";
  var city = "";
  var area = "";
  UserController _userController = Get.find();
  static final kInitialPosition = LatLng(-33.8567844, 151.213108);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.fromLTRB(32, 100, 32, 32),
                child: Image(
                  image: AssetImage("assets/images/ic_logo.png"),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Visibility(
                    visible: isLocationAdded ? false : true,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LocationPicker(
                                apiKey:
                                    GOOGLE_API_KEY, // Put YOUR OWN KEY here.
                                onPlacePicked: (result) async {
                                  latitude =
                                      result.geometry.location.lat.toString();
                                  longitude =
                                      result.geometry.location.lng.toString();
                                  currentArea =
                                      result.addressComponents[0].shortName;
                                  currentAddress =
                                      result.formattedAddress.toString();

                                  await addStringToSF(
                                      KEY_LATITUDE, latitude.toString());
                                  await addStringToSF(
                                      KEY_LONGITUDE, longitude.toString());
                                  await addStringToSF(
                                      KEY_AREA, currentArea.toString());
                                  await addStringToSF(
                                      KEY_ADDRESS, currentAddress.toString());
                                  Navigator.of(context).pop();

                                  setState(() {
                                    isLocationAdded = true;
                                  });
                                  onLocationAdded();
                                },
                                initialPosition: kInitialPosition,
                                useCurrentLocation: true,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: MediaQuery.of(context).size.height * 0.07,
                          decoration: BoxDecoration(
                              color: colorTheme,
                              borderRadius: BorderRadius.circular(4)),
                          child: Center(
                            child: Text(
                              "Set Delivery Location".toUpperCase(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Visibility(
                    visible: isLoginDone ? false : true,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: MediaQuery.of(context).size.height * 0.07,
                      child: Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Have an account?".toUpperCase(),
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () async {
                                  var result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Login()));

                                  if (result == "YES") {
                                    setState(() {
                                      isLoginDone = true;
                                    });
                                    onLoginSuccess();
                                  }
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(4),
                                  child: Text(
                                    "Login".toUpperCase(),
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> onLocationAdded() async {
    if (isLoginDone) {
      await addBoolToSF(KEY_IS_LOGIN, true);
      isLogin = true;
      _userController.addUpdateAddress(
          latitude, longitude, currentAddress, "ADD", "");
      Get.offAll(Home());
    }
  }

  Future<void> onLoginSuccess() async {
    userId = _userController.modelUser.value.cId.toString();
    await addStringToSF(KEY_IS_USER_ID, userId);

    if (isLocationAdded) {
      await addBoolToSF(KEY_IS_LOGIN, true);
      isLogin = true;
      Get.offAll(Home());
    }
  }
}
