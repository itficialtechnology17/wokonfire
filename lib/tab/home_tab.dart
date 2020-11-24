import 'dart:ui';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:wokonfire/constant/constant_value.dart';
import 'package:wokonfire/constant/constants_key.dart';
import 'package:wokonfire/controller/bottomsheet_controller.dart';
import 'package:wokonfire/controller/home_controller.dart';
import 'package:wokonfire/offers/offer_screen.dart';
import 'package:wokonfire/page/location_picker.dart';
import 'package:wokonfire/utils/shimmer_page.dart';
import 'package:wokonfire/utils/ui_helper.dart';
import 'package:wokonfire/utils/url.dart';
import 'package:wokonfire/widgets/custom_button.dart';
import 'package:wokonfire/widgets/entry_field.dart';
import 'package:wokonfire/widgets/veg_badge_view.dart';

class HomeTab extends StatelessWidget {
  final HomeController _homeController = Get.put(HomeController());
  final BottomSheetController _bottomSheetController =
      Get.put(BottomSheetController());

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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OffersScreen(),
                      ),
                    );
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
                            Obx(() => PageView.builder(
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
                                )),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Obx(() => Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.05,
                                    child: Center(
                                      child: DotsIndicator(
                                        dotsCount:
                                            _homeController.arrOfSlider.length,
                                        position: _homeController
                                            .currentPosition.value,
                                        decorator: DotsDecorator(
                                          color:
                                              Colors.black12, // Inactive color
                                          activeColor: Colors.white,
                                        ),
                                      ),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                      Obx(() => ListView.builder(
                            shrinkWrap: true,
                            itemCount:
                                _homeController.arrOfDashboardTitle.length,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 8, right: 8, bottom: 8, top: 16),
                                    child: Row(
                                      children: <Widget>[
                                        Icon(Icons.thumb_up, size: 20.0),
                                        horizontalSpaceSmall(),
                                        Text(
                                          _homeController
                                              .arrOfDashboardTitle[index]
                                              .dtName,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline4
                                              .copyWith(fontSize: 20.0),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: 8, right: 8, top: 8),
                                    child: GridView.count(
                                      shrinkWrap: true,
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 16,
                                      crossAxisSpacing: 8,
                                      physics: NeverScrollableScrollPhysics(),
                                      childAspectRatio: 0.7,
                                      children: List.generate(
                                        _homeController
                                            .arrOfDashboardTitle[index]
                                            .foodItems
                                            .length,
                                        (nIndex) => Stack(
                                          children: [
                                            Container(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: <Widget>[
                                                  Image.network(
                                                    storageUrl +
                                                        _homeController
                                                            .arrOfDashboardTitle[
                                                                index]
                                                            .foodItems[nIndex]
                                                            .foodImage,
                                                    height: 130.0,
                                                    fit: BoxFit.fill,
                                                  ),
                                                  verticalSpaceExtraSmall(),
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Text(
                                                        _homeController
                                                            .arrOfDashboardTitle[
                                                                index]
                                                            .foodItems[nIndex]
                                                            .ftName
                                                            .toUpperCase(),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText1
                                                            .copyWith(
                                                              fontSize: 10.0,
                                                              color: Colors
                                                                  .grey[700],
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
                                                                  .foodItems[
                                                                      nIndex]
                                                                  .foodName,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .subtitle2
                                                                  .copyWith(
                                                                      fontSize:
                                                                          13.0),
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
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        6.0,
                                                                    horizontal:
                                                                        25.0),
                                                            decoration:
                                                                BoxDecoration(
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .grey),
                                                            ),
                                                            child: Text(
                                                              'ADD',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .subtitle2
                                                                  .copyWith(
                                                                      color: Colors
                                                                          .green),
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
                                              margin: EdgeInsets.only(
                                                  top: 4, left: 4),
                                              child: Material(
                                                color: Colors.black12,
                                                type: MaterialType.circle,
                                                clipBehavior: Clip.hardEdge,
                                                child: InkWell(
                                                  onTap: () {
                                                    /* Get.to(
                                                        FavoriteBottomSheet());*/
                                                    _bottomSheetController
                                                        .openFavoriteTitle(
                                                            index,
                                                            nIndex,
                                                            context);
                                                  },
                                                  child: Padding(
                                                    padding: EdgeInsets.all(4),
                                                    child: _homeController
                                                                .arrOfDashboardTitle[
                                                                    index]
                                                                .foodItems[
                                                                    nIndex]
                                                                .isFavorite ==
                                                            1
                                                        ? Icon(
                                                            Icons.favorite,
                                                            color: Colors.white,
                                                          )
                                                        : Icon(
                                                            Icons
                                                                .favorite_border,
                                                            color:
                                                                Colors.white),
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
                          )),
                      /*Padding(
                  padding:
                      EdgeInsets.only(left: 8, right: 8, bottom: 8, top: 16),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.thumb_up, size: 20.0),
                      horizontalSpaceSmall(),
                      Text(
                        'Recommended',
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
                      foods.length,
                      (index) => Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Image.asset(
                              foods[index].image,
                              height: 130.0,
                              fit: BoxFit.fill,
                            ),
                            verticalSpaceExtraSmall(),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'BREAKFAST',
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
                                        foods[index].title,
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
                                    Text(foods[index].price,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            .copyWith(fontSize: 14.0)),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 6.0, horizontal: 25.0),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                      ),
                                      child: Text(
                                        'ADD',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2
                                            .copyWith(color: Colors.green),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.thumb_up, size: 20.0),
                      horizontalSpaceSmall(),
                      Text(
                        'Top Picks For You',
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            .copyWith(fontSize: 20.0),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  child: GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 8,
                    physics: NeverScrollableScrollPhysics(),
                    childAspectRatio: 0.7,
                    children: List.generate(
                      foods.length,
                      (index) => Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Image.asset(
                              foods[index].image,
                              height: 130.0,
                              fit: BoxFit.fill,
                            ),
                            verticalSpaceExtraSmall(),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'BREAKFAST',
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
                                        foods[index].title,
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
                                    Text(foods[index].price,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            .copyWith(fontSize: 14.0)),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 6.0, horizontal: 25.0),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                      ),
                                      child: Text(
                                        'ADD',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2
                                            .copyWith(color: Colors.green),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),*/
                    ],
                  ))),
      ),
    );
  }
}

/*

class _StateHomeTab extends State<HomeTab> {
  List<RestaurantDetail> foods = List<RestaurantDetail>();



  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (_, __) {
          return <Widget>[
            SliverAppBar(
              pinned: true,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Now -> Vesu",
                    style: Theme.of(context)
                        .textTheme
                        .headline3
                        .copyWith(fontSize: 20.0),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text("HG-2, SNS Platina, JH Ambani School",
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          .copyWith(fontSize: 12.0))
                ],
              ),
              actions: [
                InkWell(
                  child: Container(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.local_offer,
                          size: 20,
                        ),
                        horizontalSpaceExtraSmall(),
                        Text(
                          'Offer',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2
                              .copyWith(fontSize: 18.0, color: Colors.black),
                        ),
                        horizontalSpaceExtraSmall(),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OffersScreen(),
                      ),
                    );
                  },
                )
              ],
            ),
          ];
        },
        body: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: ListView(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              children: [
                _homeController.arrOfSlider.isEmpty
                    ? Container(
                        height: 180,
                        width: Get.width,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : InkWell(
                        child: Container(
                          height: 180.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Swiper(
                            itemHeight: 100,
                            duration: 500,
                            itemWidth: double.infinity,
                            pagination: SwiperPagination(),
                            itemCount: _homeController.arrOfSlider.length,
                            itemBuilder: (BuildContext context, int index) =>
                                Image.network(
                              _homeController.arrOfSlider[index].hbImage,
                              fit: BoxFit.cover,
                            ),
                            autoplay: true,
                            viewportFraction: 1.0,
                            scale: 0.9,
                          ),
                        ),
                        onTap: () {},
                      ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 8, right: 8, bottom: 8, top: 16),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.thumb_up, size: 20.0),
                      horizontalSpaceSmall(),
                      Text(
                        'Recommended',
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
                      foods.length,
                      (index) => Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Image.asset(
                              foods[index].image,
                              height: 130.0,
                              fit: BoxFit.fill,
                            ),
                            verticalSpaceExtraSmall(),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'BREAKFAST',
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
                                        foods[index].title,
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
                                    Text(foods[index].price,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            .copyWith(fontSize: 14.0)),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 6.0, horizontal: 25.0),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                      ),
                                      child: Text(
                                        'ADD',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2
                                            .copyWith(color: Colors.green),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.thumb_up, size: 20.0),
                      horizontalSpaceSmall(),
                      Text(
                        'Top Picks For You',
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            .copyWith(fontSize: 20.0),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  child: GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 8,
                    physics: NeverScrollableScrollPhysics(),
                    childAspectRatio: 0.7,
                    children: List.generate(
                      foods.length,
                      (index) => Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Image.asset(
                              foods[index].image,
                              height: 130.0,
                              fit: BoxFit.fill,
                            ),
                            verticalSpaceExtraSmall(),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'BREAKFAST',
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
                                        foods[index].title,
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
                                    Text(foods[index].price,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            .copyWith(fontSize: 14.0)),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 6.0, horizontal: 25.0),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                      ),
                                      child: Text(
                                        'ADD',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2
                                            .copyWith(color: Colors.green),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

Container _buildAppBar(BuildContext context) => Container(
      margin: const EdgeInsets.symmetric(horizontal: 15.0),
      height: 60.0,
      child: Row(
        children: <Widget>[
          Text(
            'Other',
            style:
                Theme.of(context).textTheme.headline4.copyWith(fontSize: 21.0),
          ),
          horizontalSpaceExtraSmall(),
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Icon(Icons.keyboard_arrow_down),
          ),
          Spacer(),
        ],
      ),
    );
*/
