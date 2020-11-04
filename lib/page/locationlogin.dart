import 'package:flutter/material.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wokonfire/constant/constantskey.dart';
import 'package:wokonfire/constant/customcolor.dart';
import 'package:wokonfire/page/customplacepicker.dart';
import 'package:wokonfire/page/home.dart';
import 'package:wokonfire/page/login.dart';

class LocationLogin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StateLocationLogin();
  }
}

class _StateLocationLogin extends State<LocationLogin> {
  var isLoginDone = false;
  var isLocationAdded = false;
  var latitude = "";
  var logitude = "";
  var address = "";
  var city = "";
  var area = "";
  static final kInitialPosition = LatLng(-33.8567844, 151.213108);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                              builder: (context) => CustomPlacePicker(
                                apiKey: ConstantsKey
                                    .GOOGLE_API_KEY, // Put YOUR OWN KEY here.
                                onPlacePicked: (result) {
                                  latitude =
                                      result.geometry.location.lat.toString();
                                  logitude =
                                      result.geometry.location.lng.toString();
                                  Navigator.of(context).pop();
                                  setState(() {
                                    isLocationAdded = true;
                                    if (isLoginDone) {
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Home()),
                                          (route) => false);
                                    }
                                  });
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
                              color: CustomColor.colorTheme,
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
                                      if (isLocationAdded) {
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Home()),
                                            (route) => false);
                                      }
                                    });
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
}
