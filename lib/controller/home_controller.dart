import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wokonfire/constant/constant_value.dart';
import 'package:wokonfire/controller/add_to_cart_controller.dart';
import 'package:wokonfire/controller/offer_controller.dart';
import 'package:wokonfire/model/model_dashboard_title.dart';
import 'package:wokonfire/model/model_slider.dart';
import 'package:wokonfire/network/request.dart';
import 'package:wokonfire/page/customization_page.dart';
import 'package:wokonfire/utils/show_snackbar.dart';
import 'package:wokonfire/utils/ui_helper.dart';
import 'package:wokonfire/utils/url.dart';

class HomeController extends GetxController {
  var arrOfSlider = List<ModelSlider>().obs;
  var selectedIndex = 0.obs;
  var arrOfDashboardTitle = List<ModelDashboardTitle>().obs;
  // CustomizationController _customizationController =
  //     Get.put(CustomizationController());
  AddToCartController _addToCartController = Get.put(AddToCartController());
  OfferController _offerController = Get.put(OfferController());
  var currentPosition = 0.0.obs;
  final pageController = PageController();
  var finalPrice = "";

  var isAddToCartLoading = false.obs;
  int parentIndex = 0;
  int childIndex = 0;

  @override
  void onInit() {
    super.onInit();
    _apiGetDashboard();
  }

  void _apiGetDashboard() async {
    Request request = Request(url: urlDashboard, body: {
      'type': "API",
      'c_id': userId.toString(),
      'lat': latitude,
      'long': longitude,
    });
    request.post().then((value) {
      final responseData = json.decode(value.body);

      arrOfSlider.value = (responseData['slider'] as List)
          .map((data) => ModelSlider.fromJson(data))
          .toList();

      arrOfDashboardTitle.value = (responseData['dashboard_titles'] as List)
          .map((data) => ModelDashboardTitle.fromJson(data))
          .toList();

      updateSelectionState();
      startBannerTimer();

      print("Successful");
    }).catchError((onError) {
      print(onError);
    });
  }

  void startBannerTimer() {
    Timer.periodic(
        Duration(seconds: 5),
        (timer) => {
              if (currentPosition < arrOfSlider.length - 1)
                {
                  if (pageController.positions.length > 0)
                    {
                      currentPosition.value = currentPosition.value + 1.0,
                      pageController.animateToPage(currentPosition.toInt(),
                          duration: Duration(seconds: 1), curve: Curves.easeIn)
                    }
                }
              else
                {
                  if (pageController.positions.length > 0)
                    {
                      currentPosition.value = 0,
                      pageController.animateToPage(currentPosition.toInt(),
                          duration: Duration(seconds: 1), curve: Curves.easeIn)
                    }
                }
            });
  }
/*
  void addToCart(int index, [int nIndex]) {
    finalPrice = arrOfDashboardTitle[index].foodItems[nIndex].finalPrice;
    if (arrOfDashboardTitle[index].foodItems[nIndex].fdQty > 0) {
      ModelDashboardTitle modelDashboardTitle = arrOfDashboardTitle[index];

      modelDashboardTitle.foodItems[nIndex].fdQty =
          modelDashboardTitle.foodItems[nIndex].fdQty + 1;

      arrOfDashboardTitle[index] = modelDashboardTitle;

      print("Item Count After Add=" +
          arrOfDashboardTitle[index].foodItems[nIndex].fdQty.toString());
    } else if (arrOfDashboardTitle[index]
        .foodItems[nIndex]
        .customization
        .isNotEmpty) {
      openCustomization(index, nIndex);
    } else {
      _apiAddToCart();
    }
  }*/

  void openCustomization(int mIndex, int mnIndex) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: Get.context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, state) {
            return Container(
              color: Colors.white,
              padding: EdgeInsets.all(16),
              child: ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: <Widget>[
                  Center(
                    child: Container(
                      width: 50,
                      height: 5,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Center(
                    child: Text(
                      arrOfDashboardTitle[mIndex]
                          .foodItems[mnIndex]
                          .foodName
                          .toUpperCase(),
                      style: Theme.of(context).textTheme.subtitle2.copyWith(
                            fontSize: 18,
                          ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    itemCount: arrOfDashboardTitle[mIndex]
                        .foodItems[mnIndex]
                        .customization
                        .length,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 8,
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: arrOfDashboardTitle[mIndex]
                                        .foodItems[mnIndex]
                                        .customization[index]
                                        .fcmTitle,
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                  TextSpan(text: "  "),
                                  TextSpan(
                                      text: arrOfDashboardTitle[mIndex]
                                                  .foodItems[mnIndex]
                                                  .customization[index]
                                                  .fcmTitle ==
                                              "Size"
                                          ? ""
                                          : arrOfDashboardTitle[mIndex]
                                                      .foodItems[mnIndex]
                                                      .customization[index]
                                                      .fcvExtraPrice !=
                                                  "0"
                                              ? "(Extra " +
                                                  arrOfDashboardTitle[mIndex]
                                                      .foodItems[mnIndex]
                                                      .customization[index]
                                                      .fcvExtraPrice +
                                                  " )"
                                              : "",
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1
                                          .copyWith(fontSize: 12))
                                ],
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            verticalSpaceSmall(),
                            //Max Selection==1 Radio Button
                            //else
                            //Max Selection>1 CheckBox Button
                            SizedBox(
                              height: 8,
                            ),
                            arrOfDashboardTitle[mIndex]
                                        .foodItems[mnIndex]
                                        .customization[index]
                                        .fcmMaxSelection ==
                                    0
                                ? ListView.separated(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: arrOfDashboardTitle[mIndex]
                                        .foodItems[mnIndex]
                                        .customization[index]
                                        .customizationValues
                                        .length,
                                    itemBuilder: (context, nIndex) {
                                      return InkWell(
                                        onTap: () {
                                          updatedRadioButtonCustomization(
                                              state, index, nIndex);
                                        },
                                        child: Row(
                                          children: [
                                            arrOfDashboardTitle[mIndex]
                                                    .foodItems[mnIndex]
                                                    .customization[index]
                                                    .customizationValues[nIndex]
                                                    .isSelected
                                                ? Icon(
                                                    Icons.radio_button_checked,
                                                    size: 25,
                                                  )
                                                : Icon(
                                                    Icons
                                                        .radio_button_unchecked,
                                                    size: 25,
                                                  ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            RichText(
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: arrOfDashboardTitle[
                                                            mIndex]
                                                        .foodItems[mnIndex]
                                                        .customization[index]
                                                        .customizationValues[
                                                            nIndex]
                                                        .fcvName,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle1,
                                                  ),
                                                  TextSpan(text: "  "),
                                                  TextSpan(
                                                      text: arrOfDashboardTitle[
                                                                      mIndex]
                                                                  .foodItems[
                                                                      mnIndex]
                                                                  .customization[
                                                                      index]
                                                                  .customizationValues[
                                                                      nIndex]
                                                                  .fcvExtraPrice !=
                                                              "0"
                                                          ? "(Extra " +
                                                              arrOfDashboardTitle[
                                                                      mIndex]
                                                                  .foodItems[
                                                                      mnIndex]
                                                                  .customization[
                                                                      index]
                                                                  .customizationValues[
                                                                      nIndex]
                                                                  .fcvExtraPrice +
                                                              " )"
                                                          : "",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .subtitle1
                                                          .copyWith(
                                                              fontSize: 12))
                                                ],
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, nIndex) {
                                      return SizedBox(
                                        height: 4,
                                      );
                                    },
                                  )
                                : ListView.separated(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: arrOfDashboardTitle[mIndex]
                                        .foodItems[mnIndex]
                                        .customization[index]
                                        .customizationValues
                                        .length,
                                    itemBuilder: (context, nIndex) {
                                      return InkWell(
                                        onTap: () {
                                          updatedCheckBoxCustomization(
                                              state, index, nIndex);
                                        },
                                        child: Row(
                                          children: [
                                            /*arrOfDashboardTitle[mIndex]
                                                        .foodItems[mnIndex]
                                                        .customization[index]
                                                        .customizationValues[
                                                            nIndex]
                                                        .fcvIsDefault ==
                                                    1
                                                ? Icon(
                                                    Icons.check_box,
                                                    size: 25,
                                                  )
                                                : */
                                            arrOfDashboardTitle[mIndex]
                                                    .foodItems[mnIndex]
                                                    .customization[index]
                                                    .customizationValues[nIndex]
                                                    .isSelected
                                                ? Icon(
                                                    Icons.check_box,
                                                    size: 25,
                                                  )
                                                : Icon(
                                                    Icons.crop_square,
                                                    size: 25,
                                                  ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            RichText(
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: arrOfDashboardTitle[
                                                            mIndex]
                                                        .foodItems[mnIndex]
                                                        .customization[index]
                                                        .customizationValues[
                                                            nIndex]
                                                        .fcvName,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle1,
                                                  ),
                                                  TextSpan(text: "  "),
                                                  TextSpan(
                                                      text: arrOfDashboardTitle[
                                                                      mIndex]
                                                                  .foodItems[
                                                                      mnIndex]
                                                                  .customization[
                                                                      index]
                                                                  .customizationValues[
                                                                      nIndex]
                                                                  .fcvExtraPrice !=
                                                              "0"
                                                          ? "(Extra " +
                                                              arrOfDashboardTitle[
                                                                      mIndex]
                                                                  .foodItems[
                                                                      mnIndex]
                                                                  .customization[
                                                                      index]
                                                                  .customizationValues[
                                                                      nIndex]
                                                                  .fcvExtraPrice +
                                                              " )"
                                                          : "",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .subtitle1
                                                          .copyWith(
                                                              fontSize: 12))
                                                ],
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, nIndex) {
                                      return SizedBox(
                                        height: 4,
                                      );
                                    },
                                  )
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Container(
                        height: 1,
                        margin: EdgeInsets.only(top: 24),
                        color: Colors.grey[200],
                      );
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  InkWell(
                      onTap: () {
                        // _apiAddToCart();
                      },
                      child: Obx(
                        () => Container(
                          width: Get.width,
                          height: Get.height * 0.06,
                          color: Colors.red,
                          child: !isAddToCartLoading.value
                              ? Center(
                                  child: Text(
                                    "Add To CARt"
                                        .toUpperCase() /* +
                                        " ( Rs. " +
                                        finalPrice.toString() +
                                        " )"*/
                                    ,
                                    style: Theme.of(context).textTheme.button,
                                  ),
                                )
                              : Center(
                                  child: SizedBox(
                                    height: Get.width * 0.08,
                                    width: Get.width * 0.08,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 3,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.white),
                                    ),
                                  ),
                                ),
                        ),
                      )),
                  SizedBox(
                    height: 16,
                  ),
                ],
              ),
            );
          });
        });
  }

  Future<Null> updatedRadioButtonCustomization(
      StateSetter updateState, int index, int nIndex) async {
    updateState(() {
      for (int i = 0;
          i <
              arrOfDashboardTitle[parentIndex]
                  .foodItems[childIndex]
                  .customization[index]
                  .customizationValues
                  .length;
          i++) {
        arrOfDashboardTitle[parentIndex]
            .foodItems[childIndex]
            .customization[index]
            .customizationValues[nIndex]
            .fcvIsDefault = 0;

        arrOfDashboardTitle[parentIndex]
            .foodItems[childIndex]
            .customization[index]
            .customizationValues[i]
            .isSelected = false;
      }

      arrOfDashboardTitle[parentIndex]
          .foodItems[childIndex]
          .customization[index]
          .customizationValues[nIndex]
          .isSelected = true;
    });
  }

  Future<Null> updatedCheckBoxCustomization(
      StateSetter updateState, int index, int nIndex) async {
    updateState(() {
      for (int i = 0;
          i <
              arrOfDashboardTitle[parentIndex]
                  .foodItems[childIndex]
                  .customization[index]
                  .customizationValues
                  .length;
          i++) {
        arrOfDashboardTitle[parentIndex]
            .foodItems[childIndex]
            .customization[index]
            .customizationValues[nIndex]
            .fcvIsDefault = 0;
      }

      if (arrOfDashboardTitle[parentIndex]
          .foodItems[childIndex]
          .customization[index]
          .customizationValues[nIndex]
          .isSelected) {
        arrOfDashboardTitle[parentIndex]
            .foodItems[childIndex]
            .customization[index]
            .customizationValues[nIndex]
            .isSelected = false;
      } else {
        arrOfDashboardTitle[parentIndex]
            .foodItems[childIndex]
            .customization[index]
            .customizationValues[nIndex]
            .isSelected = true;
      }
    });
  }

  void updateSelectionState() {
    for (int i = 0; i < arrOfDashboardTitle.length; i++) {
      for (int j = 0; j < arrOfDashboardTitle[i].foodItems.length; j++) {
        for (int k = 0;
            k < arrOfDashboardTitle[i].foodItems[j].customization.length;
            k++) {
          for (int l = 0;
              l <
                  arrOfDashboardTitle[i]
                      .foodItems[j]
                      .customization[k]
                      .customizationValues
                      .length;
              l++) {
            if (arrOfDashboardTitle[i]
                    .foodItems[j]
                    .customization[k]
                    .customizationValues[l]
                    .fcvIsDefault ==
                1) {
              arrOfDashboardTitle[i]
                  .foodItems[j]
                  .customization[k]
                  .customizationValues[l]
                  .isSelected = true;
            }
          }
        }
      }
    }
  }

/*
  void _apiAddToCart() async {
    isAddToCartLoading.value = true;

    String customizationId = await getCustomizationId();

    Request request = Request(url: urlManageFavoriteMaster, body: {
      'type': "API",
      'c_id': userId,
      'r_id': restaurantId,
      'f_id': arrOfDashboardTitle[parentIndex]
          .foodItems[childIndex]
          .foodId
          .toString(),
      'customization_id': customizationId,
    });

    request.post().then((value) {
      isAddToCartLoading.value = false;

      final responseData = json.decode(value.body);
      if (responseData["status_code"] == 1) {
      } else {
        Get.snackbar("Failed", responseData["message"],
            backgroundColor: Colors.red,
            borderRadius: 3,
            colorText: Colors.white);
      }
    }).catchError((onError) {
      print(onError);
    });
  }
*/

/*
  Future<int> _apiAddToCart() async {
    isAddToCartLoading.value = true;

    String customizationId = await getCustomizationId();

    Request request = Request(url: urlManageFavoriteMaster, body: {
      'type': "API",
      'c_id': userId,
      'r_id': restaurantId,
      'f_id': arrOfDashboardTitle[parentIndex]
          .foodItems[childIndex]
          .foodId
          .toString(),
      'customization_id': customizationId,
    });

    request.post().then((value) {
      isAddToCartLoading.value = false;

      final responseData = json.decode(value.body);
      if (responseData["status_code"] == 1) {
        return responseData[''];
      } else {
        Get.snackbar("Failed", responseData["message"],
            backgroundColor: Colors.red,
            borderRadius: 3,
            colorText: Colors.white);
      }
    }).catchError((onError) {
      print(onError);
    });
    return 0;
  }
*/

  getCustomizationId() {
    String customizationId = "";
    for (int i = 0;
        i <
            arrOfDashboardTitle[parentIndex]
                .foodItems[childIndex]
                .customization
                .length;
        i++) {
      for (int j = 0;
          j <
              arrOfDashboardTitle[parentIndex]
                  .foodItems[childIndex]
                  .customization[i]
                  .customizationValues
                  .length;
          j++) {
        if (arrOfDashboardTitle[parentIndex]
            .foodItems[childIndex]
            .customization[i]
            .customizationValues[j]
            .isSelected) {
          customizationId = customizationId +
              arrOfDashboardTitle[parentIndex]
                  .foodItems[childIndex]
                  .customization[i]
                  .customizationValues[j]
                  .fcvId
                  .toString();
          if (j <
              arrOfDashboardTitle[parentIndex]
                      .foodItems[childIndex]
                      .customization[i]
                      .customizationValues
                      .length -
                  1) {
            customizationId = customizationId + ",";
          }
        }
      }
    }
    return customizationId;
  }

  void handleAddToCart(int index, BuildContext context, [int nIndex]) async {
    if (arrOfDashboardTitle[index].foodItems[nIndex].customization.isNotEmpty) {
      // openCustomization(index, nIndex);
      var result = await Navigator.of(context).push(
        PageRouteBuilder(
          opaque: false, // set to false
          pageBuilder: (_, __, ___) => CustomizationPage.value(
              arrOfDashboardTitle[index].foodItems[nIndex]),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var begin = Offset(0.0, 1.0);
            var end = Offset.zero;
            var curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        ),
      );

      if (result != null) {
        if (result['result'] == "1") {
          ModelDashboardTitle modelDashboardTitle = arrOfDashboardTitle[index];

          modelDashboardTitle.foodItems[nIndex].fdQty =
              modelDashboardTitle.foodItems[nIndex].fdQty + 1;

          arrOfDashboardTitle[index] = modelDashboardTitle;
        }
      }
    } else {
      var result = await _addToCartController.apiAddToCart(
          arrOfDashboardTitle[index].foodItems[nIndex].foodId.toString(), "");

      if (result != null) {
        if (result == 1) {
          ModelDashboardTitle modelDashboardTitle = arrOfDashboardTitle[index];

          modelDashboardTitle.foodItems[nIndex].fdQty =
              modelDashboardTitle.foodItems[nIndex].fdQty + 1;

          arrOfDashboardTitle[index] = modelDashboardTitle;
        }
      }
    }
  }

  void handleRemoveToCart(int index, BuildContext context, [int nIndex]) async {
    arrOfDashboardTitle[index].foodItems[nIndex].isLoading = true;

    Map<String, dynamic> response =
        await _addToCartController.apiRemoveFromCart(
            arrOfDashboardTitle[index].foodItems[nIndex].foodId.toString());

    arrOfDashboardTitle[index].foodItems[nIndex].isLoading = false;
    if (response != null) {
      if (response['status_code'] == 1) {
        ModelDashboardTitle modelDashboardTitle = arrOfDashboardTitle[index];

        modelDashboardTitle.foodItems[nIndex].fdQty =
            modelDashboardTitle.foodItems[nIndex].fdQty - 1;

        arrOfDashboardTitle[index] = modelDashboardTitle;
        showSnackBar("Message", response['message'], Colors.green);
      } else if (response['status_code'] == "2") {
        showSnackBar("Notify", response['message'], Colors.yellow);
      } else {
        showSnackBar("Error", response['message'], Colors.red);
      }
    }
  }

  void _apiAddToCart(int index, int nIndex) async {
    isAddToCartLoading.value = true;

    String customizationId = await getCustomizationId();

    Request request = Request(url: urlManageFavoriteMaster, body: {
      'type': "API",
      'c_id': userId,
      'r_id': restaurantId,
      'f_id': arrOfDashboardTitle[index].foodItems[nIndex].foodId.toString(),
      'customization_id': customizationId,
    });

    request.post().then((value) {
      isAddToCartLoading.value = false;

      final responseData = json.decode(value.body);
      if (responseData["status_code"] == 1) {
        ModelDashboardTitle modelDashboardTitle = arrOfDashboardTitle[index];

        modelDashboardTitle.foodItems[nIndex].fdQty =
            modelDashboardTitle.foodItems[nIndex].fdQty + 1;

        arrOfDashboardTitle[index] = modelDashboardTitle;
      } else {
        Get.snackbar("Failed", responseData["message"],
            backgroundColor: Colors.red,
            borderRadius: 3,
            colorText: Colors.white);
      }
    }).catchError((onError) {
      print(onError);
    });
  }
}
