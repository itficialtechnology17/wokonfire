import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wokonfire/model/restaurant_detail.dart';
import 'package:wokonfire/offers/offer_banner_view.dart';
import 'package:wokonfire/offers/offer_screen.dart';
import 'package:wokonfire/utils/ui_helper.dart';
import 'package:wokonfire/widgets/veg_badge_view.dart';

class HomeTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StateHomeTab();
  }
}

class _StateHomeTab extends State<HomeTab> {
  List<RestaurantDetail> foods = List<RestaurantDetail>();
  @override
  void initState() {
    super.initState();
    foods = RestaurantDetail.getBreakfast();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        actions: [
          InkWell(
            child: Container(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  Icon(
                    Icons.local_offer,
                  ),
                  horizontalSpaceExtraSmall(),
                  Text(
                    'Offer',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        .copyWith(fontSize: 18.0, color: Colors.white),
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
      body: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: [
          OfferBannerView(),
          Padding(
            padding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
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
                            style:
                                Theme.of(context).textTheme.bodyText1.copyWith(
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            style:
                                Theme.of(context).textTheme.bodyText1.copyWith(
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
