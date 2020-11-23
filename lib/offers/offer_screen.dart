import 'package:flutter/material.dart';
import 'package:wokonfire/model/available_coupon.dart';
import 'package:wokonfire/model/spotlight_best_top_food.dart';
import 'package:wokonfire/utils/ui_helper.dart';
import 'package:wokonfire/widgets/custom_divider_view.dart';
import 'package:wokonfire/widgets/food_list_item_view.dart';

class OffersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'OFFERS',
            style:
                Theme.of(context).textTheme.subtitle2.copyWith(fontSize: 17.0),
          ),
          bottom: TabBar(
            indicatorColor: Colors.black,
            tabs: <Widget>[
              Tab(child: Text('RESTAURANT OFFERS')),
              Tab(child: Text('OTHERS OFFERS')),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _RestaurantOfferView(),
            _PaymentOffersCouponView(),
          ],
        ),
      ),
    );
  }
}

class _RestaurantOfferView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final foods = SpotlightBestTopFood.getPopularAllRestaurants();
    foods.addAll(SpotlightBestTopFood.getPopularAllRestaurants());
    foods.addAll(SpotlightBestTopFood.getPopularAllRestaurants());

    return Container(
      margin: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          verticalSpaceSmall(),
          Text(
            'All Offers (18)',
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(fontWeight: FontWeight.bold, fontSize: 19.0),
          ),
          verticalSpaceMedium(),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 18,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: InkWell(
                  onTap: () {
                    /*Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RestaurantDetailScreen(),
                      ),
                    );*/
                  },
                  child: FoodListItemView(
                    restaurant: foods[index],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _PaymentOffersCouponView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final coupons = AvailableCoupon.getAvailableCoupons();

    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 15.0),
            height: 40.0,
            color: Colors.grey[200],
            child: Text('Available Coupons',
                style: Theme.of(context).textTheme.subtitle2),
          ),
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: coupons.length,
              separatorBuilder: (context, index) => Divider(),
              itemBuilder: (context, index) => Container(
                margin: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.orange[100],
                        border: Border.all(color: Colors.grey[400]),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Image.asset(
                            'assets/images/food1.jpg',
                            height: 10.0,
                            width: 10.0,
                            fit: BoxFit.cover,
                          ),
                          horizontalSpaceMedium(),
                          Text(coupons[index].coupon,
                              style: Theme.of(context).textTheme.subtitle2)
                        ],
                      ),
                    ),
                    verticalSpaceSmall(),
                    Text(
                      coupons[index].discount,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    verticalSpaceMedium(),
                    CustomDividerView(
                      dividerHeight: 1.0,
                      color: Colors.grey,
                    ),
                    verticalSpaceMedium(),
                    Text(
                      coupons[index].desc,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(fontSize: 13.0),
                    ),
                    verticalSpaceMedium(),
                    InkWell(
                      child: Text(
                        '+ MORE',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2
                            .copyWith(color: Colors.blue),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
