import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wokonfire/constant/constant_value.dart';
import 'package:wokonfire/controller/favorite_controller.dart';
import 'package:wokonfire/utils/ui_helper.dart';
import 'package:wokonfire/widgets/veg_badge_view.dart';

class FavoriteFood extends StatelessWidget {
  FavoriteController _favoriteController = Get.put(FavoriteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Material(
            color: Colors.transparent,
            type: MaterialType.circle,
            clipBehavior: Clip.hardEdge,
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Platform.isAndroid
                    ? Icons.keyboard_backspace
                    : Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
          ),
          centerTitle: true,
          title: Text(
            "Favorite Foods",
            style: Theme.of(context).textTheme.headline6.merge(
                  TextStyle(letterSpacing: 1.3, color: Colors.black),
                ),
          ),
        ),
        body: Obx(() => ListView.builder(
              shrinkWrap: true,
              itemCount: _favoriteController.arrOfFavorite.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: 8, right: 8, bottom: 8, top: 16),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.favorite,
                            size: 15.0,
                            color: Colors.red,
                          ),
                          horizontalSpaceSmall(),
                          Text(
                            _favoriteController.arrOfFavorite[index].fTitle,
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                .copyWith(fontSize: 20.0),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 8, right: 8, top: 8),
                      child: GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 8,
                        physics: NeverScrollableScrollPhysics(),
                        childAspectRatio: 0.7,
                        children: List.generate(
                          _favoriteController
                              .arrOfFavorite[index].favoriteList.length,
                          (nIndex) => Stack(
                            children: [
                              Container(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    /*Image.network(
                                      storageUrl +
                                          _favoriteController
                                              .arrOfFavorite[index]
                                              .favoriteList[nIndex]
                                              .foodImage,
                                      height: 130.0,
                                      fit: BoxFit.fill,
                                    ),*/
                                    Image.network(
                                      _favoriteController
                                                      .arrOfFavorite[index]
                                                      .favoriteList[nIndex]
                                                      .foodImage ==
                                                  null ||
                                              _favoriteController
                                                      .arrOfFavorite[index]
                                                      .favoriteList[nIndex]
                                                      .foodImage ==
                                                  ""
                                          ? defaultImage
                                          : _favoriteController
                                              .arrOfFavorite[index]
                                              .favoriteList[nIndex]
                                              .foodImage,
                                      height: 130.0,
                                      fit: BoxFit.fill,
                                    ),
                                    verticalSpaceExtraSmall(),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          _favoriteController
                                              .arrOfFavorite[index]
                                              .favoriteList[nIndex]
                                              .ftName
                                              .toUpperCase(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1
                                              .copyWith(
                                                fontSize: 10.0,
                                                color: Colors.grey[700],
                                              ),
                                        ),
                                        verticalSpaceExtraSmall(),
                                        Row(
                                          children: <Widget>[
                                            VegBadgeView(),
                                            horizontalSpaceExtraSmall(),
                                            Flexible(
                                              child: Text(
                                                _favoriteController
                                                    .arrOfFavorite[index]
                                                    .favoriteList[nIndex]
                                                    .foodName,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle2
                                                    .copyWith(fontSize: 13.0),
                                              ),
                                            ),
                                          ],
                                        ),
                                        verticalSpaceMedium(),
                                        // Spacer(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                                _favoriteController
                                                    .arrOfFavorite[index]
                                                    .favoriteList[nIndex]
                                                    .finalPrice,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1
                                                    .copyWith(fontSize: 14.0)),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 6.0,
                                                      horizontal: 25.0),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey),
                                              ),
                                              child: Text(
                                                'ADD',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle2
                                                    .copyWith(
                                                        color: Colors.green),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 4, left: 4),
                                child: Material(
                                  color: Colors.black12,
                                  type: MaterialType.circle,
                                  clipBehavior: Clip.hardEdge,
                                  child: InkWell(
                                    onTap: () {
                                      _favoriteController.openFavoriteTitle(
                                          index, context, nIndex);
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.all(4),
                                      child: _favoriteController
                                                  .arrOfFavorite[index]
                                                  .favoriteList[nIndex]
                                                  .favoriteId >
                                              0
                                          ? Icon(
                                              Icons.favorite,
                                              color: Colors.white,
                                            )
                                          : Icon(Icons.favorite_border,
                                              color: Colors.white),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                );
              },
            )));
  }
}
