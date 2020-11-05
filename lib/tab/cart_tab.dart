import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:wokonfire/controller/cart_controller.dart';
import 'package:wokonfire/utils/ui_helper.dart';
import 'package:wokonfire/utils/url.dart';
import 'package:wokonfire/widgets/custom_divider_view.dart';

class CartTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(top: 15.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _OrderView(),
                CustomDividerView(dividerHeight: 15.0),
                _CouponView(),
                CustomDividerView(dividerHeight: 15.0),
                _BillDetailView(),
                _DecoratedView(),
                _AddressPaymentView(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _OrderView extends StatelessWidget {
  final CartController _cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: _cartController.arrOfCart.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Image.network(
                        storageUrl + _cartController.arrOfCart[index].foodImage,
                        height: Get.width * 0.25,
                        width: Get.width * 0.25,
                      ),
                      horizontalSpaceSmall(),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            verticalSpaceSmall(),
                            Text(_cartController.arrOfCart[index].foodName,
                                style: Theme.of(context).textTheme.subtitle1),
                            verticalSpaceSmall(),
                            RichText(
                              overflow: TextOverflow.fade,
                              text: TextSpan(
                                  text: _cartController
                                      .arrOfCart[index].customization,
                                  style: Theme.of(context).textTheme.bodyText2),
                            ),
                            verticalSpaceSmall(),
                            Text(
                                'Rs. ' +
                                    _cartController.arrOfCart[index].finalPrice,
                                style: Theme.of(context).textTheme.subtitle2),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  height: 35.0,
                                  width: 100.0,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      InkWell(
                                        child: Icon(Icons.remove,
                                            color: Colors.green),
                                        onTap: () {
                                          _cartController.removeFromCart(index);
                                        },
                                      ),
                                      Spacer(),
                                      Text(
                                          _cartController
                                              .arrOfCart[index].quantity
                                              .toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2
                                              .copyWith(fontSize: 16.0)),
                                      Spacer(),
                                      InkWell(
                                        child: Icon(Icons.add,
                                            color: Colors.green),
                                        onTap: () {
                                          _cartController.addAddMore(index);
                                        },
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            );
          },
        ));
  }
}

class _CouponView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: <Widget>[
          Icon(Icons.local_offer, size: 20.0, color: Colors.grey[700]),
          horizontalSpaceMedium(),
          Text(
            'APPLY COUPON',
            style:
                Theme.of(context).textTheme.subtitle2.copyWith(fontSize: 16.0),
          ),
          Spacer(),
          Icon(Icons.keyboard_arrow_right, color: Colors.grey),
        ],
      ),
    );
  }
}

class _BillDetailView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textStyle =
        Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 16.0);

    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Bill Details',
            style:
                Theme.of(context).textTheme.headline6.copyWith(fontSize: 17.0),
          ),
          verticalSpaceSmall(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Item total', style: textStyle),
              Text('Rs 129.00', style: textStyle),
            ],
          ),
          verticalSpaceMedium(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text('Delivery Fee', style: textStyle),
                        horizontalSpaceSmall(),
                        Icon(Icons.info_outline, size: 14.0)
                      ],
                    ),
                    verticalSpaceSmall(),
                    Text(
                      'Your Delivery Partner is travelling long distance to deliver your order',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(fontSize: 13.0),
                    ),
                  ],
                ),
              ),
              Text('Rs 54.00', style: textStyle),
            ],
          ),
          verticalSpaceLarge(),
          _buildDivider(),
          Container(
            alignment: Alignment.center,
            height: 60.0,
            child: Row(
              children: <Widget>[
                Text('Taxes and Charges', style: textStyle),
                horizontalSpaceSmall(),
                Icon(Icons.info_outline, size: 14.0),
                Spacer(),
                Text('Rs 26.67', style: textStyle),
              ],
            ),
          ),
          _buildDivider(),
          Container(
            alignment: Alignment.center,
            height: 60.0,
            child: Row(
              children: <Widget>[
                Text('To Pay', style: Theme.of(context).textTheme.subtitle2),
                Spacer(),
                Text('Rs 210.00', style: textStyle),
              ],
            ),
          ),
        ],
      ),
    );
  }

  CustomDividerView _buildDivider() => CustomDividerView(
        dividerHeight: 1.0,
        color: Colors.grey[400],
      );
}

class _DecoratedView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      color: Colors.grey[200],
    );
  }
}

class _AddressPaymentView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          /*Container(
            height: 50.0,
            color: Colors.black,
            child: Row(
              children: <Widget>[
                Icon(Icons.phone, color: Colors.yellow[800]),
                horizontalSpaceSmall(),
                Text(
                  'Want your order left outside? Call delivery executive',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Colors.white),
                )
              ],
            ),
          ),*/
          /* Container(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      height: 60.0,
                      width: 60.0,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      child: Icon(Icons.add_location, size: 30.0),
                    ),
                    Positioned(
                      top: 0.0,
                      right: 0.0,
                      child: Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      ),
                    )
                  ],
                ),
                horizontalSpaceMedium(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Deliver to Other',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2
                          .copyWith(fontSize: 17.0),
                    ),
                    Text(
                      'Keelkattalai',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: Colors.grey),
                    ),
                    verticalSpaceSmall(),
                    Text(
                      '43 MINS',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ],
                ),
                Spacer(),
                InkWell(
                  child: Text(
                    'ADD ADDRESS',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        .copyWith(color: darkOrange),
                  ),
                  onTap: () {},
                ),
                verticalSpaceMedium(),
              ],
            ),
          ),*/
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Rs210.00',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2
                            .copyWith(fontSize: 18.0),
                      ),
                      verticalSpaceExtraSmall(),
                      Text(
                        'VIEW DETAIL BILL',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2
                            .copyWith(color: Colors.blue),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10.0),
                  color: Colors.green,
                  height: 58.0,
                  child: Text(
                    'PROCEED TO PAY',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        .copyWith(color: Colors.white),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
