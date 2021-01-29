import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wokonfire/constant/constant_value.dart';
import 'package:wokonfire/controller/favorite_controller.dart';
import 'package:wokonfire/controller/search_controller.dart';
import 'package:wokonfire/utils/search_shimmer_page.dart';
import 'package:wokonfire/utils/ui_helper.dart';
import 'package:wokonfire/widgets/veg_badge_view.dart';

class SearchTab extends StatelessWidget {
  final SearchController _searchController = Get.find();
  FavoriteController _favoriteController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() => Container(
              padding: EdgeInsets.all(12),
              child: _searchController.arrOfFood.isEmpty
                  ? SearchShimmer()
                  : ListView(
                      shrinkWrap: true,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              left: 15.0, top: 2.0, bottom: 2.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[400]),
                            borderRadius: BorderRadius.circular(2.0),
                          ),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Search for restaurants and food',
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .subtitle2
                                        .copyWith(
                                          color: Colors.grey,
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              horizontalSpaceMedium(),
                              IconButton(
                                icon: Icon(Icons.search),
                                onPressed: () {},
                              )
                            ],
                          ),
                        ),
                        verticalSpaceExtraSmall(),
                        Container(
                          padding: EdgeInsets.only(top: 16),
                          child: GridView.count(
                            shrinkWrap: true,
                            crossAxisCount: 2,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 8,
                            physics: NeverScrollableScrollPhysics(),
                            childAspectRatio: 2 / 3.2,
                            children: List.generate(
                              _searchController.arrOfFood.length,
                              (index) => Stack(
                                children: [
                                  Container(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        Image.network(
                                          _searchController.arrOfFood[index]
                                                          .foodImage ==
                                                      null ||
                                                  _searchController
                                                          .arrOfFood[index]
                                                          .foodImage ==
                                                      ""
                                              ? defaultImage
                                              : _searchController
                                                  .arrOfFood[index].foodImage,
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
                                              _searchController
                                                  .arrOfFood[index].foodName
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
                                                  child: RichText(
                                                    maxLines: 2,
                                                    text: TextSpan(
                                                        text: _searchController
                                                            .arrOfFood[index]
                                                            .ftName,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText1
                                                            .copyWith(
                                                                fontSize: 10.0,
                                                                color: Colors
                                                                    .black)),
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
                                                        _searchController
                                                            .arrOfFood[index]
                                                            .finalPrice,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1
                                                        .copyWith(
                                                            fontSize: 14.0)),
                                                SizedBox(
                                                  width: 16,
                                                ),
                                                Expanded(
                                                  child: Obx(() => Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          _searchController
                                                                      .arrOfFood[
                                                                          index]
                                                                      .fdQty ==
                                                                  0
                                                              ? InkWell(
                                                                  onTap: () {
                                                                    _searchController
                                                                        .handleAddToCart(
                                                                            index,
                                                                            context);
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        vertical:
                                                                            8.0,
                                                                        horizontal:
                                                                            25.0),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      border: Border.all(
                                                                          color:
                                                                              Colors.grey),
                                                                    ),
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Text(
                                                                        'ADD',
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .subtitle2
                                                                            .copyWith(color: Colors.green),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )
                                                              : Container(
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          4.0),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    border: Border.all(
                                                                        color: Colors
                                                                            .grey),
                                                                  ),
                                                                  child: Row(
                                                                    children: <
                                                                        Widget>[
                                                                      SizedBox(
                                                                        width:
                                                                            8,
                                                                      ),
                                                                      Expanded(
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              InkWell(
                                                                            child: _searchController.arrOfFood[index].isLoading
                                                                                ? SizedBox(
                                                                                    width: Get.height * 0.02,
                                                                                    height: Get.height * 0.02,
                                                                                    child: CircularProgressIndicator(
                                                                                      strokeWidth: 2,
                                                                                    ),
                                                                                  )
                                                                                : Icon(Icons.remove, color: Colors.green),
                                                                            onTap:
                                                                                () {
                                                                              _searchController.handleRemoveToCart(index);
                                                                            },
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            8,
                                                                      ),
                                                                      Expanded(
                                                                        child:
                                                                            Center(
                                                                          child: Text(
                                                                              _searchController.arrOfFood[index].fdQty.toString(),
                                                                              style: Theme.of(context).textTheme.subtitle2.copyWith(fontSize: 16.0)),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            8,
                                                                      ),
                                                                      Expanded(
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              InkWell(
                                                                            child:
                                                                                Icon(Icons.add, color: Colors.green),
                                                                            onTap:
                                                                                () {
                                                                              _searchController.handleAddToCart(index, context);
                                                                            },
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            8,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                          SizedBox(
                                                            height: 4,
                                                          ),
                                                          Visibility(
                                                            visible: _searchController
                                                                    .arrOfFood[
                                                                        index]
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
                                    margin: EdgeInsets.only(top: 4, left: 4),
                                    child: Material(
                                      color: Colors.black12,
                                      type: MaterialType.circle,
                                      clipBehavior: Clip.hardEdge,
                                      child: InkWell(
                                        onTap: () {
                                          _favoriteController.openFavoriteTitle(
                                              index, context);
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.all(4),
                                          child: _searchController
                                                      .arrOfFood[index]
                                                      .isFavorite >
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
                        ),
                      ],
                    ),
            )),
      ),
    );
  }
}
