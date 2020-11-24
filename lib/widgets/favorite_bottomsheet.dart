import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:wokonfire/controller/bottomsheet_controller.dart';

class FavoriteBottomSheet extends StatelessWidget {
  BottomSheetController _bottomSheetController =
      Get.put(BottomSheetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.1),
      body: Column(
        children: [
          Expanded(
            child: Image.asset(
              "assets/images/ic_transparent.png",
              width: Get.width,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
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
                    _bottomSheetController.openFavoriteAddTitle(context, "");
                  },
                  child: DottedBorder(
                    color: Colors.green,
                    strokeWidth: 1,
                    child: Container(
                      height: Get.height * 0.06,
                      width: Get.width,
                      child: Center(
                        child: Text(
                          "Create New Title".toUpperCase(),
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
                      itemCount:
                          _bottomSheetController.arrOfFavoriteTitle.length,
                      itemBuilder: (context, index) {
                        return Material(
                          color: Colors.white,
                          child: InkWell(
                            onTap: () {
                              if (_bottomSheetController
                                      .arrOfFavoriteTitle[index].isSelected ==
                                  false) {
                                _bottomSheetController.arrOfFavoriteTitle[index]
                                    .isSelected = true;
                              } else {
                                _bottomSheetController.arrOfFavoriteTitle[index]
                                    .isSelected = false;
                              }
                            },
                            child: Container(
                              height: Get.height * 0.06,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 4,
                                  ),
                                  !_bottomSheetController
                                          .arrOfFavoriteTitle[index].isSelected
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
                                    _bottomSheetController
                                        .arrOfFavoriteTitle[index].fTitle,
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
                                        _bottomSheetController
                                            .openFavoriteAddTitle(
                                                context,
                                                _bottomSheetController
                                                    .arrOfFavoriteTitle[index]
                                                    .fTitle,
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
                                        _bottomSheetController
                                            .openFavoriteAddTitle(
                                                context,
                                                _bottomSheetController
                                                    .arrOfFavoriteTitle[index]
                                                    .fTitle);
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
                  onTap: () {},
                  child: Obx(() => Visibility(
                        visible:
                            _bottomSheetController.arrOfFavoriteTitle.isEmpty
                                ? false
                                : true,
                        child: Container(
                          width: Get.width,
                          height: Get.height * 0.06,
                          color: Colors.red,
                          child: !_bottomSheetController.isLoading.value
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
                                      valueColor: AlwaysStoppedAnimation<Color>(
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
          )
        ],
      ),
    );
  }
}
