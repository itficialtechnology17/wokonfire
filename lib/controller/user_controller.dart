import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wokonfire/constant/constant_value.dart';
import 'package:wokonfire/constant/constants_key.dart';
import 'package:wokonfire/model/model_address.dart';
import 'package:wokonfire/model/model_user.dart';
import 'package:wokonfire/network/request.dart';
import 'package:wokonfire/page/get_current_location.dart';
import 'package:wokonfire/page/location_picker.dart';
import 'package:wokonfire/utils/show_snackbar.dart';
import 'package:wokonfire/utils/url.dart';

class UserController extends GetxController {
  var modelUser = ModelUser().obs;
  var isLoading = false.obs;
  var receivedOTP = "".obs;

  var arrOfAddress = List<ModelAddress>().obs;

/*  void setModelUser(paramModelUser) {
    modelUser.value = paramModelUser;
  }*/

  void getMyAccount(int i) async {
    Request request = Request(url: urlMyAccount + "?type=API&c_id=$userId");

    request.get().then((value) {
      final responseData = json.decode(value.body);

      modelUser.value = ModelUser.fromJson(responseData['data']);

      arrOfAddress.value = (responseData['address'] as List)
          .map((data) => ModelAddress.fromJson(data))
          .toList();

      if (i == 1) {
        // Get.off(Home());
        Get.off(GetCurrentLocation());
      }

      print("Successful");
    }).catchError((onError) {
      print(onError);
    });
  }

  void updateProfile() async {
    Request request = Request(url: urlUpdateProfile, body: {
      'type': "API",
      'c_id': "26",
      'name': modelUser.value.userName.toString(),
      'email': modelUser.value.email.toString(),
    });
    request.post().then((value) {
      final responseData = json.decode(value.body);

      print("Successful");
    }).catchError((onError) {
      print(onError);
    });
  }

  addUpdateAddress(
      String latitude, String longitude, String address, String actionType,
      [String addressId]) async {
    isLoading.value = true;

    Request request = Request(url: urlManageAddress, body: {
      'type': "API",
      'c_id': userId,
      'ca_type': "1",
      'action_type': actionType,
      'ca_lat': latitude,
      'ca_long': longitude,
      'ca_landmark': "",
      'ca_map_address': address,
      'ca_block_no': "",
      'ca_id': addressId,
    });
    request.post().then((value) {
      isLoading.value = false;

      final responseData = json.decode(value.body);
      if (responseData['status_code'] == 1) {
        print("Success: Address Add/Update");
        showSnackBar("Success", responseData['message'], Colors.green);
        getMyAccount(0);
      } else {
        print("Failed : Address Add/Update");
        showSnackBar("Failed", responseData['message'], Colors.red);
      }
    }).catchError((onError) {
      print("API Failed : Address Add/Update/Delete");
      print(onError);
    });
  }

  void getOTP(String mobileNo) async {
    Request request = Request(url: urlSendOTP, body: {
      'type': "API",
      'mobile_number': mobileNo,
    });
    request.post().then((value) {
      final responseData = json.decode(value.body);
      if (responseData['status_code'] == 1) {
        receivedOTP.value = responseData['otp'].toString();
        modelUser.value = ModelUser.fromJson(responseData['data']);
        userId = modelUser.value.cId.toString();
      } else {
        showSnackBar("Failed", responseData['message'], Colors.red);
      }
    }).catchError((onError) {
      print("API Failed : Address Add/Update/Delete");
      print(onError);
    });
  }

  void onClickManageAddress(
      BuildContext context, String actionType, String addressId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LocationPicker(
          apiKey: GOOGLE_API_KEY, // Put YOUR OWN KEY here.
          onPlacePicked: (result) async {
            var latitude = result.geometry.location.lat.toString();
            var longitude = result.geometry.location.lng.toString();

            var address = result.formattedAddress.toString();

            Navigator.of(context).pop();

            addUpdateAddress(
                latitude, longitude, address, actionType, addressId);
          },
          initialPosition: kInitialPosition,
          useCurrentLocation: true,
        ),
      ),
    );
  }

  void confirmDelete(BuildContext context, int index) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: new Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Wrap(
                    children: <Widget>[
                      Text(
                        "Confirm Delete ?",
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  )
                ],
              ),
              actions: <Widget>[
                new FlatButton(
                  onPressed: () async {
                    Get.back();
                    addUpdateAddress("", "", "", "DELETE",
                        arrOfAddress[index].caId.toString());
                  },
                  textColor: Colors.black,
                  child: const Text('YES'),
                ),
                new FlatButton(
                  onPressed: () {
                    Get.back();
                    // Navigator.of(context, rootNavigator: true).pop('dialog');
                  },
                  textColor: Colors.red,
                  child: const Text('CANCEL'),
                ),
              ],
            ));
  }
}
