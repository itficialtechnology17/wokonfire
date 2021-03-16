import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wokonfire/controller/order_controller.dart';
import 'package:wokonfire/order/past_order_details.dart';
import 'package:wokonfire/utils/custom_color.dart';
import 'package:wokonfire/utils/ui_helper.dart';
import 'package:wokonfire/widgets/custom_divider_view.dart';
import 'package:wokonfire/widgets/dotted_seperator_view.dart';

class OrderHistory extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StateOrderHistory();
  }
}

class _StateOrderHistory extends State<OrderHistory> {
  OrderController _orderController = Get.find();

  @override
  void initState() {
    super.initState();
    if (_orderController.arrOfOrder.isEmpty) _orderController.apiGetOrder();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
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
          "Order History",
          style: Theme.of(context).textTheme.headline6.merge(
                TextStyle(letterSpacing: 1.3, color: Colors.black),
              ),
        ),
      ),
      body: Obx(() => _orderController.isGettingOrder.value
          ? Center(
              child: CircularProgressIndicator(),
            )
          : _orderController.arrOfOrder.isEmpty
              ? Container(
                  child: Center(
                    child: Text("No Order Founds."),
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: _orderController.arrOfOrder.length,
                  itemBuilder: (context, index) => Material(
                    child: InkWell(
                      onTap: () {
                        Get.to(PastOrderDetails(
                            _orderController.arrOfOrder[index]));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        _orderController
                                            .arrOfOrder[index].orderNo
                                            .toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2,
                                      ),
                                      verticalSpaceExtraSmall(),
                                      Text(
                                        _orderController
                                            .arrOfOrder[index].orderDeliveryType
                                            .toString()
                                            .toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            .copyWith(fontSize: 12.0),
                                      ),
                                      verticalSpaceSmall(),
                                      Row(
                                        children: <Widget>[
                                          Text('Rs. ' +
                                              _orderController
                                                  .arrOfOrder[index].totalAmount
                                                  .toString()),
                                          horizontalSpaceExtraSmall(),
                                          Icon(Icons.keyboard_arrow_right,
                                              color: Colors.grey[600])
                                        ],
                                      )
                                    ],
                                  ),
                                  Spacer(),
                                  Text(
                                      _orderController
                                          .arrOfOrder[index].orderStatusText,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2),
                                  horizontalSpaceSmall(),
                                  Container(
                                    child: Icon(
                                        _orderController.arrOfOrder[index]
                                                    .orderStatusText ==
                                                "Delivered"
                                            ? Icons.check_circle
                                            : _orderController.arrOfOrder[index]
                                                        .orderStatusText ==
                                                    "Cancel"
                                                ? Icons.cancel
                                                : Icons.stop_circle_outlined,
                                        color: _orderController
                                                    .arrOfOrder[index]
                                                    .orderStatusText ==
                                                "Delivered"
                                            ? Colors.green
                                            : _orderController.arrOfOrder[index]
                                                        .orderStatusText ==
                                                    "Cancel"
                                                ? Colors.red
                                                : Colors
                                                    .orangeAccent) /*Icon(Icons.check,
                                          color: Colors.white, size: 14.0)*/
                                    ,
                                  )
                                ],
                              ),
                            ),
                            verticalSpaceSmall(),
                            DottedSeperatorView(),
                            verticalSpaceMedium(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(_orderController
                                    .arrOfOrder[index].caMapAddress),
                                verticalSpaceExtraSmall(),
                                verticalSpaceSmall(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: <Widget>[
                                          _orderController.arrOfOrder[index]
                                                      .orderStatusText ==
                                                  "Delivered"
                                              ? OutlineButton(
                                                  color: darkOrange,
                                                  borderSide: BorderSide(
                                                      width: 1.5,
                                                      color: darkOrange),
                                                  child: Text(
                                                    'REORDER',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle2
                                                        .copyWith(
                                                            color: darkOrange),
                                                  ),
                                                  onPressed: () {},
                                                )
                                              : _orderController
                                                          .arrOfOrder[index]
                                                          .orderStatusText ==
                                                      "Pending"
                                                  ? OutlineButton(
                                                      color: darkOrange,
                                                      borderSide: BorderSide(
                                                          width: 1.5,
                                                          color: Colors.black),
                                                      child: Text(
                                                        'Track Order'
                                                            .toUpperCase(),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .subtitle2
                                                            .copyWith(
                                                                color: Colors
                                                                    .black),
                                                      ),
                                                      onPressed: () {},
                                                    )
                                                  : Container(
                                                      height: 1,
                                                    ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: Get.width * 0.05,
                                    ),
                                    _orderController.arrOfOrder[index]
                                                .orderStatusText ==
                                            "Delivered"
                                        ? Expanded(
                                            child: OutlineButton(
                                              color: darkOrange,
                                              borderSide: BorderSide(
                                                  width: 1.5,
                                                  color: darkOrange),
                                              child: Text(
                                                'RATE ORDER',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle2
                                                    .copyWith(
                                                        color: darkOrange),
                                              ),
                                              onPressed: () {},
                                            ),
                                          )
                                        : Spacer()
                                  ],
                                ),
                                verticalSpaceMedium(),
                                Text(_orderController.arrOfOrder[index].date +
                                    ", " +
                                    _orderController.arrOfOrder[index].time
                                        .toString()),
                                verticalSpaceMedium(),
                                index < _orderController.arrOfOrder.length - 1
                                    ? CustomDividerView(
                                        dividerHeight: 1.5, color: Colors.black)
                                    : Container(
                                        height: 1,
                                      )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )),
    );
  }
}

/*
class _PastOrderListView extends StatelessWidget {
  final List<String> restaurants = [
    'Sea Emperor',
    'Fireflies Restaurant',
    'Chai Truck',
  ];

  final List<String> foods = [
    'Pepper BBQ x 1',
    'Chicken Noodles x 1',
    'Milk Tea x 1'
  ];

  @override
  Widget build(BuildContext context) {
    return ;
  }
}
*/
