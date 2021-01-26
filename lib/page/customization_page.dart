import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wokonfire/controller/add_to_cart_controller.dart';
import 'package:wokonfire/model/model_customization.dart';
import 'package:wokonfire/model/model_food.dart';
import 'package:wokonfire/utils/ui_helper.dart';

class CustomizationPage extends StatefulWidget {
  final ModelFood foodItem;

  @override
  State<StatefulWidget> createState() {
    return _StateCustomizationPage();
  }

  CustomizationPage.value(this.foodItem);
}

class _StateCustomizationPage extends State<CustomizationPage> {
  ModelFood foodItem;
  List<Customization> customization;
  @override
  void initState() {
    foodItem = widget.foodItem;
    customization = widget.foodItem.customization;
    super.initState();
  }

  AddToCartController _addToCartController = Get.find();

  var isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  )),
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
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
                      foodItem.foodName.toUpperCase(),
                      style: Theme.of(context).textTheme.subtitle2.copyWith(
                            fontSize: 18,
                          ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Rs. " + foodItem.finalPrice.toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        .copyWith(fontSize: 18, color: Colors.green),
                  ),
                  SizedBox(
                    height: 8,
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
                                    text: customization[index]
                                        .fcmTitle
                                        .toUpperCase(),
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
                            Container(
                              height: 2,
                              margin:
                                  EdgeInsets.only(top: 8, right: 8, bottom: 8),
                              child: Stack(
                                children: [
                                  Center(
                                    child: Container(
                                      width: Get.width,
                                      height: 1,
                                      color: Colors.grey[200],
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      width: Get.width * 0.10,
                                      height: 2,
                                      color: Colors.red,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            verticalSpaceSmall(),
                            //Max Selection==1 Radio Button
                            //else
                            //Max Selection>1 CheckBox Button
                            SizedBox(
                              height: 8,
                            ),
                            customization[index].fcmMaxSelection == 0
                                ? ListView.separated(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: customization[index]
                                        .customizationValues
                                        .length,
                                    itemBuilder: (context, nIndex) {
                                      return InkWell(
                                        onTap: () {
                                          setState(() {
                                            setSelection(index, nIndex);
                                          });
                                        },
                                        child: Row(
                                          children: [
                                            customization[index]
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
                                                    text: customization[index]
                                                        .customizationValues[
                                                            nIndex]
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
                                                              customization[
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
                                        height: 12,
                                      );
                                    },
                                  )
                                : ListView.separated(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: customization[index]
                                        .customizationValues
                                        .length,
                                    itemBuilder: (context, nIndex) {
                                      return InkWell(
                                        onTap: () {},
                                        child: Row(
                                          children: [
                                            customization[index]
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
                                                    text: customization[index]
                                                        .customizationValues[
                                                            nIndex]
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
                                                              customization[
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
                    height: 20,
                  ),
                  InkWell(
                      onTap: () async {
                        setState(() {
                          isLoading = true;
                        });
                        var result = await _addToCartController.apiAddToCart(
                            foodItem.foodId.toString(), getCustomizationId());
                        Map<String, String> map = Map<String, String>();
                        map['result'] = result.toString();
                        Navigator.pop(context, map);
                      },
                      child: Container(
                        width: Get.width,
                        height: Get.height * 0.06,
                        color: Colors.red,
                        child: Center(
                          child: !isLoading
                              ? Text(
                                  "Add To CARt"
                                      .toUpperCase() /* +
                                        " ( Rs. " +
                                        finalPrice.toString() +
                                        " )"*/
                                  ,
                                  style: Theme.of(context).textTheme.button,
                                )
                              : SizedBox(
                                  height: Get.height * 0.03,
                                  width: Get.height * 0.03,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  ),
                                ),
                        ),
                      )),
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

  void setSelection(int index, int nIndex) {
    for (int i = 0; i < customization[index].customizationValues.length; i++) {
      if (i == nIndex) {
        customization[index].customizationValues[i].isSelected = true;
      } else {
        customization[index].customizationValues[i].isSelected = false;
      }
    }
  }

  getCustomizationId() {
    String customizationId = "";
    for (int i = 0; i < customization.length; i++) {
      for (int j = 0; j < customization[i].customizationValues.length; j++) {
        if (customization[i].customizationValues[j].isSelected) {
          customizationId = customizationId +
              customization[i].customizationValues[j].fcvId.toString();
          if (j < customization[i].customizationValues.length - 1) {
            customizationId = customizationId + ",";
          }
        }
      }
    }
    return customizationId;
  }
}
