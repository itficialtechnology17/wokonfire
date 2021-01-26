import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:wokonfire/controller/offer_controller.dart';
import 'package:wokonfire/model/spotlight_best_top_food.dart';
import 'package:wokonfire/utils/ui_helper.dart';
import 'package:wokonfire/utils/url.dart';
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
              Tab(child: Text('OFFERS')),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _PaymentOffersCouponView(),
            Container(
              child: Center(
                child: Text("Currently there is no offers."),
              ),
            )
            // _RestaurantOfferView(),
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

class _PaymentOffersCouponView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StateOffer();
  }
}

class _StateOffer extends State<_PaymentOffersCouponView> {
  OfferController _offerController = Get.put(OfferController());

  @override
  void initState() {
    super.initState();
    if (_offerController.arrOfOffer.isEmpty) _offerController.apiGetOffer();
  }

  @override
  Widget build(BuildContext context) {
    // final coupons = AvailableCoupon.getAvailableCoupons();

    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          /* Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 15.0),
            height: 40.0,
            color: Colors.grey[200],
            child: Text('Available Coupons',
                style: Theme.of(context).textTheme.subtitle2),
          ),*/
          Expanded(
            child: Obx(() => ListView.separated(
                  shrinkWrap: true,
                  itemCount: _offerController.arrOfOffer.length,
                  separatorBuilder: (context, index) => Divider(),
                  itemBuilder: (context, index) => Container(
                    margin: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: Colors.yellow[100],
                                border: Border.all(color: Colors.grey[400]),
                              ),
                              child: Row(
                                children: [
                                  Image.network(
                                    storageUrl +
                                        _offerController
                                            .arrOfOffer[index].offPhoto,
                                    height: Get.width * 0.04,
                                    width: Get.width * 0.06,
                                    fit: BoxFit.cover,
                                  ),
                                  horizontalSpaceMedium(),
                                  Text(
                                      _offerController
                                          .arrOfOffer[index].offCode,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2),
                                ],
                              ),
                            ),
                            Spacer(),
                            Material(
                              color: Colors.white,
                              child: InkWell(
                                onTap: () {
                                  Map<String, dynamic> map =
                                      Map<String, dynamic>();
                                  map['offerId'] = _offerController
                                      .arrOfOffer[index].offId
                                      .toString();
                                  map['offerCode'] = _offerController
                                      .arrOfOffer[index].offCode
                                      .toString();
                                  Navigator.pop(context, map);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey[400]),
                                  ),
                                  child: Text("Apply".toUpperCase()),
                                ),
                              ),
                            ),
                            horizontalSpaceMedium(),
                          ],
                        ),
                        verticalSpaceSmall(),
                        Text(
                          _offerController.arrOfOffer[index].offTitle,
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        verticalSpaceMedium(),
                        CustomDividerView(
                          dividerHeight: 1.0,
                          color: Colors.grey,
                        ),
                        verticalSpaceMedium(),
                        Text(
                          _offerController.arrOfOffer[index].offNestedTitle,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(fontSize: 13.0),
                        ),
                        Visibility(
                          visible: _offerController.arrOfOffer[index].isMore
                              ? true
                              : false,
                          child: Column(
                            children: [
                              verticalSpaceMedium(),
                              Html(
                                data: _offerController
                                    .arrOfOffer[index].offTermCondition,
                              ),
                            ],
                          ),
                        ),
                        verticalSpaceMedium(),
                        InkWell(
                          onTap: () {
                            setState(() {
                              _offerController.arrOfOffer[index].isMore =
                                  !_offerController.arrOfOffer[index].isMore;
                            });
                          },
                          child: Text(
                            _offerController.arrOfOffer[index].isMore
                                ? "Less"
                                : "+ MORE",
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                .copyWith(color: Colors.blue),
                          ),
                        )
                      ],
                    ),
                  ),
                )),
          )
        ],
      ),
    );
  }
}
