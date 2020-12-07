import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geocoder/geocoder.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:lottie/lottie.dart';
import 'package:wokonfire/constant/constant_value.dart';
import 'package:wokonfire/constant/constants_key.dart';
import 'package:wokonfire/page/home.dart';
import 'package:wokonfire/utils/shared_preference.dart';

class GetCurrentLocation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StateGetCurrentLocation();
  }
}

class _StateGetCurrentLocation extends State<GetCurrentLocation> {
  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/images/ic_map_bg.png",
            width: Get.width,
            height: Get.height,
            fit: BoxFit.cover,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: Get.width * 0.50,
                  width: Get.width * 0.50,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.black12),
                  child: Center(
                    child: Lottie.asset('assets/json/ic_current_location.json',
                        height: Get.width * 0.30, width: Get.width * 0.30),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  "Now",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(fontSize: 20.0),
                ),
                SizedBox(
                  height: 4,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(currentAddressByLatLong,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          .copyWith(fontSize: 12.0)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<Map<String, double>> getCurrentLocation() async {
    var location = new Location();
    var currentLocation = <String, double>{};
    try {
      currentLocation = await location.getLocation();
      latitude = currentLocation["latitude"].toString();
      longitude = currentLocation["longitude"].toString();
      getAddressFromLatLng(
          currentLocation["latitude"], currentLocation["longitude"]);
    } catch (e) {
      currentLocation = null;
    }
    return currentLocation;
  }

  String currentAddressByLatLong = "";
  void getAddressFromLatLng(double paramLatitude, double paramLongitude) async {
    final coordinates = new Coordinates(paramLatitude, paramLongitude);

    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);

    var first = addresses.first;

    latitude = paramLatitude.toString();
    longitude = paramLongitude.toString();
    currentArea = first.subLocality.toString();
    currentAddress = first.addressLine.toString();
    setState(() {
      currentAddressByLatLong = currentAddress;
    });

    await addStringToSF(KEY_LATITUDE, latitude.toString());
    await addStringToSF(KEY_LONGITUDE, longitude.toString());
    await addStringToSF(KEY_AREA, currentArea.toString());
    await addStringToSF(KEY_ADDRESS, currentAddress.toString());

    Future.delayed(const Duration(seconds: 2), () {
      Get.off(Home());
    });
  }
}
