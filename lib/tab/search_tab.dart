import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wokonfire/model/restaurant_detail.dart';
import 'package:wokonfire/utils/ui_helper.dart';
import 'package:wokonfire/widgets/veg_badge_view.dart';

class SearchTab extends StatefulWidget {
  @override
  _StateSearchTab createState() => _StateSearchTab();
}

class _StateSearchTab extends State<SearchTab>
    with SingleTickerProviderStateMixin {
  List<RestaurantDetail> foods = List<RestaurantDetail>();

  @override
  void initState() {
    super.initState();
    foods = RestaurantDetail.getBreakfast();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(12),
          child: ListView(
            shrinkWrap: true,
            children: [
              Container(
                padding:
                    const EdgeInsets.only(left: 15.0, top: 2.0, bottom: 2.0),
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
                          hintStyle:
                              Theme.of(context).textTheme.subtitle2.copyWith(
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
                  childAspectRatio: 0.7,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 8,
                  physics: NeverScrollableScrollPhysics(),
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
          ),
        ),
      ),
    );
  }
}