import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:wokonfire/controller/home_controller.dart';
import 'package:wokonfire/controller/search_controller.dart';
import 'package:wokonfire/model/model_customization.dart';
import 'package:wokonfire/model/model_customization_value.dart';
import 'package:wokonfire/utils/ui_helper.dart';

class CustomizationController extends GetxController {
  var isAddToCartLoading = false.obs;

  var finalPrice = 0.obs;
  var controllerType = 0.obs;
  HomeController _homeController = Get.find();
  SearchController _searchController = Get.find();
  int mIndex = 0;
  int nmIndex = 0;

  void openCustomization(int controllerType, int index, int nIndex) {
    mIndex = index;
    nmIndex = nIndex;

    List<Customization> customization;
    if (controllerType == 0) {
      finalPrice.value = int.parse(_homeController
          .arrOfDashboardTitle[index].foodItems[nIndex].finalPrice);
      customization = _homeController
          .arrOfDashboardTitle[index].foodItems[nIndex].customization;
    } else if (controllerType == 1) {
      customization = _searchController.arrOfFood[nIndex].customization;
      finalPrice.value =
          int.parse(_searchController.arrOfFood[index].finalPrice);
    }

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
                      "Add To Cart".toUpperCase(),
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
                    itemCount: customization.length,
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
                                    text: customization[index].fcmTitle,
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                  TextSpan(text: "  "),
                                  TextSpan(
                                      text: customization[index].fcmTitle ==
                                              "Size"
                                          ? ""
                                          : customization[index]
                                                      .fcvExtraPrice !=
                                                  "0"
                                              ? "(Extra " +
                                                  customization[index]
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
                            ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: customization[index]
                                  .customizationValues
                                  .length,
                              itemBuilder: (context, nIndex) {
                                return InkWell(
                                  onTap: () {
                                    updatedCustomization(
                                        state, customization, index, nIndex);
                                  },
                                  child: Row(
                                    children: [
                                      customization[index]
                                                  .customizationValues[nIndex]
                                                  .fcvIsDefault ==
                                              1
                                          ? Icon(
                                              Ionicons.checkmark_circle,
                                              color: Colors.lightBlue,
                                              size: 25,
                                            )
                                          : !customization[index]
                                                  .customizationValues[nIndex]
                                                  .isSelected
                                              ? Icon(
                                                  Ionicons.ellipse_outline,
                                                  color: Colors.grey,
                                                  size: 25,
                                                )
                                              : Icon(
                                                  Ionicons.checkmark_circle,
                                                  color: Colors.lightBlue,
                                                  size: 25,
                                                ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: customization[index]
                                                  .customizationValues[nIndex]
                                                  .fcvName,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1,
                                            ),
                                            TextSpan(text: "  "),
                                            TextSpan(
                                                text: customization[index]
                                                            .customizationValues[
                                                                nIndex]
                                                            .fcvExtraPrice !=
                                                        "0"
                                                    ? "(Extra " +
                                                        customization[index]
                                                            .customizationValues[
                                                                nIndex]
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
                        margin: EdgeInsets.only(top: 16),
                        color: Colors.grey[200],
                      );
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  InkWell(
                      onTap: () {},
                      child: Obx(
                        () => Container(
                          width: Get.width,
                          height: Get.height * 0.06,
                          color: Colors.red,
                          child: !isAddToCartLoading.value
                              ? Center(
                                  child: Text(
                                    "Add To CARt".toUpperCase() +
                                        " ( Rs. " +
                                        finalPrice.toString() +
                                        " )",
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

  Future<Null> updatedCustomization(StateSetter updateState,
      List<Customization> customization, int index, int nIndex) async {
    updateState(() {
      Customization _customization = customization[index];
      CustomizationValue _customizationValue =
          _customization.customizationValues[nIndex];
      if (_customizationValue.isSelected) {
        _customizationValue.isSelected = false;
      } else {
        _customizationValue.isSelected = true;
      }
      _customization.customizationValues[index] = _customizationValue;
      if (controllerType == 0) {
        _homeController.arrOfDashboardTitle[mIndex].foodItems[nmIndex]
            .customization[index] = _customization;
      }
    });
  }
}
