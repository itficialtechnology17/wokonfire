import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wokonfire/controller/order_controller.dart';
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
      appBar: AppBar(),
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
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: _orderController.arrOfOrder.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => Container(
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
                                  ClipOval(
                                    child: Container(
                                      padding: const EdgeInsets.all(2.2),
                                      color: Colors.green,
                                      child: Icon(Icons.check,
                                          color: Colors.white, size: 14.0),
                                    ),
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
                                Text(_orderController.arrOfOrder[index].addedOn
                                    .toString()),
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
                                          OutlineButton(
                                            color: darkOrange,
                                            borderSide: BorderSide(
                                                width: 1.5, color: darkOrange),
                                            child: Text(
                                              'REORDER',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2
                                                  .copyWith(color: darkOrange),
                                            ),
                                            onPressed: () {},
                                          ),
                                          verticalSpaceMedium(),
                                          Text(
                                              'Delivery rating not\napplicable for this order')
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Spacer(),
                                    )
                                    /*horizontalSpaceMedium(),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: <Widget>[
                                          OutlineButton(
                                            color: darkOrange,
                                            borderSide: BorderSide(
                                                width: 1.5,
                                                color: Colors.black),
                                            child: Text(
                                              'RATE FOOD',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2
                                                  .copyWith(
                                                      color: Colors.black),
                                            ),
                                            onPressed: () {},
                                          ),
                                          verticalSpaceMedium(),
                                          Text(
                                              "You haven't rated\nthis food yet")
                                        ],
                                      ),
                                    )*/
                                  ],
                                ),
                                verticalSpaceMedium(),
                                CustomDividerView(
                                    dividerHeight: 1.5, color: Colors.black)
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
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
