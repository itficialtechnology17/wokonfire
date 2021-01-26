import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:wokonfire/constant/constant_value.dart';
import 'package:wokonfire/controller/cart_controller.dart';
import 'package:wokonfire/controller/home_controller.dart';
import 'package:wokonfire/offers/offer_screen.dart';
import 'package:wokonfire/page/checkout.dart';
import 'package:wokonfire/utils/show_snackbar.dart';
import 'package:wokonfire/utils/ui_helper.dart';
import 'package:wokonfire/widgets/custom_divider_view.dart';

class CartTab extends StatelessWidget {
  CartController _cartController = Get.find();
  HomeController _homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child:
              /*_cartController.arrOfCart.isEmpty
                  ? Container(
                      height: Get.height,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          Image.asset('assets/images/ic_empty_cart.png'),
                          Center(
                            child: Text(
                              "Your Cart is Empty",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Center(
                            child: Text(
                                "Looks like you haven't made\nyour choice yet.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey)),
                          ),
                          SizedBox(
                            height: 48,
                          ),
                          InkWell(
                            onTap: () {
                              _homeController.selectedIndex.value = 0;
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                  border: Border.all(color: darkOrange)),
                              child: Text(
                                "Browse Food".toUpperCase(),
                                style: TextStyle(color: darkOrange),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  : */
              Container(
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
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _AddressPaymentView(),
    );
  }
}

class _OrderView extends StatelessWidget {
  CartController _cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: _cartController.arrOfCart.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Image.network(
                        _cartController.arrOfCart[index].foodImage == null ||
                                _cartController.arrOfCart[index].foodImage == ""
                            ? defaultImage
                            : _cartController.arrOfCart[index].foodImage,
                        height: Get.width * 0.15,
                        width: Get.width * 0.20,
                        fit: BoxFit.cover,
                      ),
                      horizontalSpaceSmall(),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // verticalSpaceSmall(),
                            Text(_cartController.arrOfCart[index].foodName,
                                style: Theme.of(context).textTheme.subtitle2),
                            verticalSpaceSmall(),
                            RichText(
                              overflow: TextOverflow.fade,
                              text: TextSpan(
                                  text: _cartController
                                      .arrOfCart[index].customization,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      .copyWith(fontSize: 12)),
                            ),
                            verticalSpaceSmall(),
                            Text(
                                'Rs. ' +
                                    _cartController.arrOfCart[index].finalPrice,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2
                                    .copyWith(color: Colors.green)),
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
  CartController _cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () async {
          Map<String, dynamic> result = await Get.to(OffersScreen());
          if (result != null) {
            Map<String, dynamic> responseCoupon = await _cartController
                .apiApplyCoupon(result['offerCode'], result['offerId']);
            if (responseCoupon != null) {
              if (responseCoupon['status_code'] == 1) {
                showSnackBar(result['offerCode'],
                    "Coupon code successfully applied.", Colors.green);
                _cartController.apiGetCartItem();
              } else {
                showSnackBar("Error", responseCoupon['message'], Colors.green);
              }
            }
          }
        },
        child: Obx(() => _cartController.couponCode.value.isEmpty
            ? Container(
                padding: EdgeInsets.all(20.0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.local_offer,
                        size: 20.0, color: Colors.grey[700]),
                    horizontalSpaceMedium(),
                    Text(
                      'APPLY COUPON',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2
                          .copyWith(fontSize: 16.0),
                    ),
                    Spacer(),
                    _cartController.isApplyingOffer.value
                        ? SizedBox(
                            width: Get.height * 0.02,
                            height: Get.height * 0.02,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          )
                        : Icon(Icons.keyboard_arrow_right, color: Colors.grey),
                  ],
                ),
              )
            : Container(
                padding: EdgeInsets.all(20.0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.local_offer,
                        size: 20.0, color: Colors.grey[700]),
                    horizontalSpaceMedium(),
                    Text(
                      _cartController.couponCode.value + ' APPLIED',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2
                          .copyWith(fontSize: 16.0),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        _cartController.couponCode.value = "";
                      },
                      child: Icon(Icons.close, color: Colors.grey),
                    ),
                  ],
                ),
              )),
      ),
    );
  }
}

class _BillDetailView extends StatelessWidget {
  final CartController _cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    final textStyle =
        Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 16.0);

    final greenTextStyle = Theme.of(context)
        .textTheme
        .bodyText1
        .copyWith(fontSize: 16.0, color: Colors.green);

    return Obx(() => Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Bill Details',
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(fontSize: 17.0),
              ),
              verticalSpaceSmall(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Item total', style: textStyle),
                  Text('Rs ' + _cartController.itemTotal.toString(),
                      style: textStyle),
                ],
              ),
              Visibility(
                visible:
                    _cartController.couponCode.value.isEmpty ? false : true,
                child: Column(
                  children: [
                    verticalSpaceMedium(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Discount', style: greenTextStyle),
                        Text('Rs ' + _cartController.discount.toString(),
                            style: greenTextStyle),
                      ],
                    ),
                  ],
                ),
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
                  Text('Rs ' + _cartController.deliveryFees.toString(),
                      style: textStyle),
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
                    Text('Rs ' + _cartController.taxesAndCharges.toString(),
                        style: textStyle),
                  ],
                ),
              ),
              _buildDivider(),
              Container(
                alignment: Alignment.center,
                height: 60.0,
                child: Row(
                  children: <Widget>[
                    Text('To Pay',
                        style: Theme.of(context).textTheme.subtitle2),
                    Spacer(),
                    Text('Rs ' + _cartController.amountToPay.toString(),
                        style: textStyle),
                  ],
                ),
              ),
            ],
          ),
        ));
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
  final CartController _cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          height: Get.height * 0.10,
          child: Column(
            children: <Widget>[
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
                            'Rs ' + _cartController.amountToPay.toString(),
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
                    child: InkWell(
                      splashColor: Colors.white,
                      onTap: () {
                        Get.to(Checkout());
                      },
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
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
