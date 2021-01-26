import 'dart:ui';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:wokonfire/constant/constant_value.dart';
import 'package:wokonfire/constant/constants_key.dart';
import 'package:wokonfire/controller/add_to_cart_controller.dart';
import 'package:wokonfire/controller/favorite_controller.dart';
import 'package:wokonfire/controller/home_controller.dart';
import 'package:wokonfire/offers/offer_screen.dart';
import 'package:wokonfire/page/location_picker.dart';
import 'package:wokonfire/utils/shimmer_page.dart';
import 'package:wokonfire/utils/ui_helper.dart';
import 'package:wokonfire/widgets/custom_button.dart';
import 'package:wokonfire/widgets/entry_field.dart';
import 'package:wokonfire/widgets/veg_badge_view.dart';

class HomeTab extends StatelessWidget {
  HomeController _homeController = Get.find();
  AddToCartController _addToCartController = Get.find();
  FavoriteController _favoriteController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (_, __) {
          return <Widget>[
            SliverAppBar(
              pinned: true,
              title: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LocationPicker(
                          apiKey: GOOGLE_API_KEY, // Put YOUR OWN KEY here.
                          onPlacePicked: (result) {
                            var latitude =
                                result.geometry.location.lat.toString();
                            var logitude =
                                result.geometry.location.lng.toString();
                            Navigator.of(context).pop();
                          },
                          initialPosition: kInitialPosition,
                          useCurrentLocation: true,
                          selectedPlaceWidgetBuilder:
                              (_, selectedPlace, state, isSearchBarFocused) {
                            return isSearchBarFocused
                                ? Container()
                                : showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext bc) {
                                      return Container(
                                        child: new Wrap(children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 18.0, left: 12),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Icon(
                                                      Icons.check_box,
                                                      size: 20,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Flexible(
                                                  child: EntryField(
                                                    horizontalPadding: 0,
                                                    labelFontSize: 15,
                                                    labelFontWeight:
                                                        FontWeight.w400,
                                                    controller:
                                                        TextEditingController()
                                                          ..text,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 20.0,
                                                left: 12,
                                                right: 12),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Icon(Icons.location_on,
                                                    size: 20),
                                                SizedBox(width: 15),
                                                Text(
                                                  '1124, Patestine Street, Jackson Tower,\nNear City Garden, New York, USA',
                                                  style:
                                                      TextStyle(fontSize: 15),
                                                ),
                                              ],
                                            ),
                                          ),
                                          CustomButton(
                                            onTap: () => Navigator.pop(context),
                                          ),
                                        ]),
                                      );
                                    });
                          }),
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Now -> $currentArea",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          .copyWith(fontSize: 20.0),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(currentAddress,
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .copyWith(fontSize: 12.0))
                  ],
                ),
              ),
              actions: [
                InkWell(
                  child: Container(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        Icon(
                          Ionicons.pricetag_outline,
                          size: 20,
                        ),
                        horizontalSpaceExtraSmall(),
                        Text(
                          'Offer'.toUpperCase(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(fontSize: 18.0, color: Colors.black),
                        ),
                        horizontalSpaceExtraSmall(),
                      ],
                    ),
                  ),
                  onTap: () {
                    Get.to(OffersScreen());
                  },
                )
              ],
            ),
          ];
        },
        body: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: Obx(() => _homeController.arrOfSlider.isEmpty
                ? ShimmerPage()
                : ListView(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    children: [
                      Container(
                        color: Colors.white,
                        height: MediaQuery.of(context).size.height * 0.25,
                        width: MediaQuery.of(context).size.width,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            PageView.builder(
                              itemCount: _homeController.arrOfSlider.length,
                              controller: _homeController.pageController,
                              itemBuilder:
                                  (BuildContext context, int position) {
                                return Image(
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                    _homeController
                                        .arrOfSlider[position].hbImage,
                                  ),
                                );
                              },
                              onPageChanged: (int index) {
                                _homeController.currentPosition.value =
                                    index.toDouble();
                              },
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                child: Center(
                                  child: DotsIndicator(
                                    dotsCount:
                                        _homeController.arrOfSlider.length,
                                    position:
                                        _homeController.currentPosition.value,
                                    decorator: DotsDecorator(
                                      color: Colors.black12, // Inactive color
                                      activeColor: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: _homeController.arrOfDashboardTitle.length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 8, top: 16),
                                child: Row(
                                  children: <Widget>[
                                    horizontalSpaceSmall(),
                                    Text(
                                      _homeController
                                          .arrOfDashboardTitle[index].dtName
                                          .toUpperCase(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          .copyWith(fontSize: 18.0),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                height: 2,
                                margin: EdgeInsets.only(
                                    left: 8, right: 8, bottom: 8),
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
                              Container(
                                padding:
                                    EdgeInsets.only(left: 8, right: 8, top: 8),
                                child: GridView.count(
                                  shrinkWrap: true,
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 16,
                                  crossAxisSpacing: 8,
                                  physics: NeverScrollableScrollPhysics(),
                                  childAspectRatio: 2 / 3.2,
                                  children: List.generate(
                                    _homeController.arrOfDashboardTitle[index]
                                        .foodItems.length,
                                    (nIndex) => Stack(
                                      children: [
                                        Container(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: <Widget>[
                                              Image.network(
                                                _homeController
                                                                .arrOfDashboardTitle[
                                                                    index]
                                                                .foodItems[
                                                                    nIndex]
                                                                .foodImage ==
                                                            null ||
                                                        _homeController
                                                                .arrOfDashboardTitle[
                                                                    index]
                                                                .foodItems[
                                                                    nIndex]
                                                                .foodImage ==
                                                            ""
                                                    ? defaultImage
                                                    : _homeController
                                                        .arrOfDashboardTitle[
                                                            index]
                                                        .foodItems[nIndex]
                                                        .foodImage,
                                                height: 120.0,
                                                fit: BoxFit.fill,
                                              ),
                                              verticalSpaceExtraSmall(),
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    _homeController
                                                        .arrOfDashboardTitle[
                                                            index]
                                                        .foodItems[nIndex]
                                                        .foodName
                                                        .toUpperCase(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle1
                                                        .copyWith(
                                                          fontSize: 13.0,
                                                        ),
                                                  ),
                                                  verticalSpaceExtraSmall(),
                                                  Row(
                                                    children: <Widget>[
                                                      VegBadgeView(),
                                                      horizontalSpaceExtraSmall(),
                                                      Flexible(
                                                        child: Text(
                                                          _homeController
                                                              .arrOfDashboardTitle[
                                                                  index]
                                                              .foodItems[nIndex]
                                                              .ftName,
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodyText1
                                                              .copyWith(
                                                                  fontSize:
                                                                      10.0,
                                                                  color: Colors
                                                                      .black),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  verticalSpaceMedium(),
                                                  // Spacer(),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      Text(
                                                          currency +
                                                              " " +
                                                              _homeController
                                                                  .arrOfDashboardTitle[
                                                                      index]
                                                                  .foodItems[
                                                                      nIndex]
                                                                  .finalPrice,
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodyText1
                                                              .copyWith(
                                                                  fontSize:
                                                                      14.0)),
                                                      SizedBox(
                                                        width: 16,
                                                      ),
                                                      Expanded(
                                                        child: Obx(() => Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .end,
                                                              children: [
                                                                _homeController
                                                                            .arrOfDashboardTitle[index]
                                                                            .foodItems[nIndex]
                                                                            .fdQty ==
                                                                        0
                                                                    ? InkWell(
                                                                        onTap:
                                                                            () {
                                                                          _homeController.handleAddToCart(
                                                                              index,
                                                                              context,
                                                                              nIndex);
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          padding: const EdgeInsets.symmetric(
                                                                              vertical: 8.0,
                                                                              horizontal: 25.0),
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            border:
                                                                                Border.all(color: Colors.grey),
                                                                          ),
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Text(
                                                                              'ADD',
                                                                              style: Theme.of(context).textTheme.subtitle2.copyWith(color: Colors.green),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      )
                                                                    : Container(
                                                                        padding:
                                                                            const EdgeInsets.symmetric(vertical: 4.0),
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          border:
                                                                              Border.all(color: Colors.grey),
                                                                        ),
                                                                        child:
                                                                            Row(
                                                                          children: <
                                                                              Widget>[
                                                                            SizedBox(
                                                                              width: 8,
                                                                            ),
                                                                            Expanded(
                                                                              child: Center(
                                                                                child: InkWell(
                                                                                  child: _homeController.arrOfDashboardTitle[index].foodItems[nIndex].isLoading
                                                                                      ? SizedBox(
                                                                                          width: Get.height * 0.02,
                                                                                          height: Get.height * 0.02,
                                                                                          child: CircularProgressIndicator(
                                                                                            strokeWidth: 2,
                                                                                          ),
                                                                                        )
                                                                                      : Icon(Icons.remove, color: Colors.green),
                                                                                  onTap: () {
                                                                                    _homeController.handleRemoveToCart(index, context, nIndex);
                                                                                  },
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              width: 8,
                                                                            ),
                                                                            Expanded(
                                                                              child: Center(
                                                                                child: Text(_homeController.arrOfDashboardTitle[index].foodItems[nIndex].fdQty.toString(), style: Theme.of(context).textTheme.subtitle2.copyWith(fontSize: 16.0)),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              width: 8,
                                                                            ),
                                                                            Expanded(
                                                                              child: Center(
                                                                                child: InkWell(
                                                                                  child: Icon(Icons.add, color: Colors.green),
                                                                                  onTap: () {
                                                                                    _homeController.handleAddToCart(index, context, nIndex);
                                                                                  },
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              width: 8,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                SizedBox(
                                                                  height: 4,
                                                                ),
                                                                Visibility(
                                                                  visible: _homeController
                                                                          .arrOfDashboardTitle[
                                                                              index]
                                                                          .foodItems[
                                                                              nIndex]
                                                                          .customization
                                                                          .isEmpty
                                                                      ? false
                                                                      : true,
                                                                  child: Text(
                                                                    "Customization",
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodyText2,
                                                                  ),
                                                                )
                                                              ],
                                                            )),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin:
                                              EdgeInsets.only(top: 4, left: 4),
                                          child: Material(
                                            color: Colors.black12,
                                            type: MaterialType.circle,
                                            clipBehavior: Clip.hardEdge,
                                            child: InkWell(
                                              onTap: () {
                                                _favoriteController
                                                    .openFavoriteTitle(
                                                        index, context, nIndex);
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.all(4),
                                                child: _homeController
                                                            .arrOfDashboardTitle[
                                                                index]
                                                            .foodItems[nIndex]
                                                            .isFavorite >
                                                        0
                                                    ? Icon(
                                                        Icons.favorite,
                                                        color: Colors.white,
                                                      )
                                                    : Icon(
                                                        Icons.favorite_border,
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
                      ),
                    ],
                  ))),
      ),
    );
  }
}
