import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:wokonfire/constant/constant_value.dart';
import 'package:wokonfire/model/model_favorite_master.dart';
import 'package:wokonfire/network/request.dart';
import 'package:wokonfire/utils/shared_preference.dart';
import 'package:wokonfire/utils/url.dart';

class BottomSheetController extends GetxController {
  var arrOfFavoriteTitle = List<ModelFavoriteMaster>().obs;

  var isLoading = false.obs;
  var isTitleSelected = -1.obs;

  @override
  void onInit() {
    super.onInit();
    _apiGetFavoriteMaster();
  }

  void _apiGetFavoriteMaster() async {
    Request request = Request(url: urlGetFavoriteMaster, body: {
      'type': "API",
      'c_id': userId.toString(),
    });
    request.post().then((value) {
      final responseData = json.decode(value.body);

      arrOfFavoriteTitle.value = (responseData['favorite'] as List)
          .map((data) => ModelFavoriteMaster.fromJson(data))
          .toList();

      print("Successful");
    }).catchError((onError) {
      print(onError);
    });
  }

  void openFavoriteTitle(int index, int nIndex, BuildContext context) {
    _apiGetFavoriteMaster();
    isLoading.value = false;

    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, state) {
            return Container(
              color: Colors.white,
              padding: EdgeInsets.all(16),
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Add To Favorite",
                    style: Theme.of(context).textTheme.subtitle2.copyWith(
                          fontSize: 18,
                        ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  InkWell(
                    onTap: () {
                      openFavoriteAddTitle(context, "");
                    },
                    child: DottedBorder(
                      color: Colors.green,
                      strokeWidth: 1,
                      child: Container(
                        height: Get.height * 0.06,
                        width: Get.width,
                        child: Center(
                          child: Text(
                            "Create Favorite Category".toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                .copyWith(fontSize: 16, color: Colors.green),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Obx(() => ListView.separated(
                        shrinkWrap: true,
                        itemCount: arrOfFavoriteTitle.length,
                        itemBuilder: (context, index) {
                          return Material(
                            color: Colors.white,
                            child: InkWell(
                              onTap: () {
                                updated(state, index);
                              },
                              child: Container(
                                height: Get.height * 0.06,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 4,
                                    ),
                                    !arrOfFavoriteTitle[index].isSelected
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
                                    Text(
                                      arrOfFavoriteTitle[index].fTitle,
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
                                    ),
                                    Spacer(),
                                    Material(
                                      color: Colors.transparent,
                                      type: MaterialType.circle,
                                      clipBehavior: Clip.hardEdge,
                                      child: InkWell(
                                        onTap: () {
                                          openFavoriteAddTitle(
                                              context,
                                              arrOfFavoriteTitle[index].fTitle,
                                              index);
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.all(4),
                                          child: Icon(
                                            Ionicons.create_outline,
                                            size: 20,
                                            color: Colors.green,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Material(
                                      color: Colors.transparent,
                                      type: MaterialType.circle,
                                      clipBehavior: Clip.hardEdge,
                                      child: InkWell(
                                        onTap: () {
                                          _apiManageFavoriteMaster(
                                              arrOfFavoriteTitle[index].fTitle,
                                              "DELETE");
                                          arrOfFavoriteTitle.removeAt(index);
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.all(4),
                                          child: Icon(
                                            Ionicons.trash_outline,
                                            size: 20,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Container(
                            height: 1,
                            color: Colors.white,
                          );
                        },
                      )),
                  SizedBox(
                    height: 8,
                  ),
                  InkWell(
                    onTap: () {
                      if (isTitleSelected == -1) {
                        Get.snackbar(
                            "NOT SELECTED", "Please select favorite category",
                            backgroundColor: Colors.white, borderRadius: 3);
                      } else {}
                    },
                    child: Obx(() => Visibility(
                          visible: arrOfFavoriteTitle.isEmpty ? false : true,
                          child: Container(
                            width: Get.width,
                            height: Get.height * 0.06,
                            color: Colors.red,
                            child: !isLoading.value
                                ? Center(
                                    child: Text(
                                      "Add To Favorite".toUpperCase(),
                                      style: Theme.of(context).textTheme.button,
                                    ),
                                  )
                                : Center(
                                    child: SizedBox(
                                      height: Get.width * 0.08,
                                      width: Get.width * 0.08,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 3,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.white),
                                      ),
                                    ),
                                  ),
                          ),
                        )),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                ],
              ),
            );
          });
        });
  }

  Future<Null> updated(StateSetter updateState, int index) async {
    updateState(() {
      for (int i = 0; i < arrOfFavoriteTitle.length; i++) {
        arrOfFavoriteTitle[i].isSelected = false;
      }

      arrOfFavoriteTitle[index].isSelected = true;
      isTitleSelected = index;
    });
  }

  void openFavoriteAddTitle(BuildContext context, String paramFavoriteTitle,
      [int index]) {
    String favoriteTitle = paramFavoriteTitle;

    Get.bottomSheet(Container(
      color: Colors.white,
      constraints: BoxConstraints(minHeight: 150),
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          SizedBox(
            height: 16,
          ),
          Text(
            "Add new favorite title",
            style: Theme.of(context).textTheme.subtitle2.copyWith(
                  fontSize: 18,
                ),
          ),
          TextFormField(
            initialValue: favoriteTitle,
            onChanged: (value) {
              favoriteTitle = value;
            },
            decoration: InputDecoration(hintText: 'Enter Favorite Title'),
          ),
          SizedBox(
            height: 16,
          ),
          InkWell(
            onTap: () {
              if (favoriteTitle == "") {
                showToast("Please Enter Title");
              } else {
                if (paramFavoriteTitle == "") {
                  _apiManageFavoriteMaster(favoriteTitle, "ADD", context);
                } else {
                  _apiManageFavoriteMaster(
                      favoriteTitle, "UPDATE", context, index);
                }
              }
            },
            child: Obx(() => Container(
                  width: Get.width,
                  height: Get.height * 0.06,
                  color: Colors.red,
                  child: !isLoading.value
                      ? Center(
                          child: Text(
                            paramFavoriteTitle == ""
                                ? "Add"
                                : "UPDATE".toUpperCase(),
                            style: Theme.of(context).textTheme.button,
                          ),
                        )
                      : Center(
                          child: SizedBox(
                            height: Get.width * 0.08,
                            width: Get.width * 0.08,
                            child: CircularProgressIndicator(
                              strokeWidth: 3,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          ),
                        ),
                )),
          )
        ],
      ),
    ));
  }

  void _apiManageFavoriteMaster(String favoriteTitle, String actionType,
      [BuildContext context, int index]) async {
    if (actionType != "DELETE") isLoading.value = true;

    Request request = Request(url: urlManageFavoriteMaster, body: {
      'type': "API",
      'c_id': userId,
      'favorite_title': favoriteTitle,
      'f_m_id': arrOfFavoriteTitle[index].fMId.toString(),
      'action_type': actionType,
    });

    request.post().then((value) {
      if (actionType != "DELETE") isLoading.value = false;

      final responseData = json.decode(value.body);
      if (responseData["status_code"] == 1) {
        if (actionType != "DELETE") Navigator.of(context).pop();
        _apiGetFavoriteMaster();
        print("Add,Update Or Delete Successful");
      } else {
        Get.snackbar("Failed", responseData["message"],
            backgroundColor: Colors.red,
            borderRadius: 3,
            colorText: Colors.white);
        print("Add,Update Or Delete Failed");
      }
    }).catchError((onError) {
      print(onError);
    });
  }
}
