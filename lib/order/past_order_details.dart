import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:wokonfire/model/model_order.dart';
import 'package:wokonfire/utils/ui_helper.dart';
import 'package:wokonfire/widgets/my_separator.dart';

class PastOrderDetails extends StatelessWidget {
  final ModelOrder modelOrder;
  PastOrderDetails(this.modelOrder);

  @override
  Widget build(BuildContext context) {
    final textStyle =
        Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 16.0);

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
          "Order Details",
          style: Theme.of(context).textTheme.headline6.merge(
                TextStyle(letterSpacing: 1.3, color: Colors.black),
              ),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Row(
            children: [
              SizedBox(
                width: 16,
              ),
              Column(
                children: [
                  Icon(
                    Icons.location_on,
                    color: Colors.grey,
                  ),
                  Container(
                    width: 3,
                    height: 3,
                    margin: EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey),
                  ),
                  Container(
                    width: 3,
                    height: 3,
                    margin: EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey),
                  ),
                  Container(
                    width: 3,
                    height: 3,
                    margin: EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey),
                  ),
                  Container(
                    width: 3,
                    height: 3,
                    margin: EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey),
                  ),
                  Container(
                    width: 3,
                    height: 3,
                    margin: EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey),
                  ),
                  Container(
                    width: 3,
                    height: 3,
                    margin: EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey),
                  ),
                  Icon(
                    Icons.home,
                    color: Colors.grey,
                  ),
                ],
              ),
              SizedBox(
                width: 16,
              ),
              Expanded(
                child: Column(
                  children: [
                    ListTile(
                      title: Text(modelOrder.data[0].rlName),
                      subtitle: Text(modelOrder.data[0].rlAddress),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    ListTile(
                      title: Text(modelOrder.orderDeliveryType),
                      subtitle: Text(modelOrder.caMapAddress),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 16,
              ),
            ],
          ),
          Container(
            width: Get.width,
            margin: EdgeInsets.symmetric(horizontal: 16),
            height: 1,
            color: Colors.grey[100],
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            children: [
              SizedBox(
                width: 16,
              ),
              Icon(
                  modelOrder.orderStatusText == "Delivered"
                      ? Icons.done
                      : modelOrder.orderStatusText == "Cancel"
                          ? Icons.close
                          : Icons.stop_circle_outlined,
                  color: modelOrder.orderStatusText == "Delivered"
                      ? Colors.green
                      : modelOrder.orderStatusText == "Cancel"
                          ? Colors.red
                          : Colors.orangeAccent),
              SizedBox(
                width: 16,
              ),
              Expanded(
                child: Text(
                  modelOrder.orderStatusText == "Delivered"
                      ? "Order will be deliver on " +
                          modelOrder.date.toString() +
                          ", " +
                          modelOrder.time.toString()
                      : modelOrder.orderStatusText == "Cancel"
                          ? "Order cancelled from your end."
                          : modelOrder.orderStatusText,
                ),
              ),
              SizedBox(
                width: 16,
              )
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            height: Get.height * 0.05,
            width: Get.width,
            padding: EdgeInsets.symmetric(horizontal: 16),
            color: Colors.grey[200],
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text("BILL DETAILS",
                  style: Theme.of(context).textTheme.headline6.copyWith(
                        fontSize: 14,
                        letterSpacing: 1,
                      )),
            ),
          ),
          verticalSpaceSmall(),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: modelOrder.data.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: [
                        RichText(
                          text: TextSpan(
                              text: modelOrder.data[index].foodName,
                              style: Theme.of(context).textTheme.bodyText2),
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Icon(
                            Icons.close,
                            size: 10,
                          ),
                        ),
                        Text(modelOrder.data[index].quantity.toString(),
                            style: textStyle),
                      ],
                    ),
                    Text('Rs ' + modelOrder.data[index].price.toString(),
                        style: textStyle),
                  ],
                ),
              );
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: MySeparator(),
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Total', style: textStyle),
                  Text(
                      'Rs ' +
                          (modelOrder.totalAmount + modelOrder.discountAmount)
                              .toString(),
                      style: textStyle),
                ],
              )),
          verticalSpaceMedium(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Discount', style: textStyle),
                Text('Rs ' + modelOrder.discountAmount.toString(),
                    style: textStyle),
              ],
            ),
          ),
          verticalSpaceMedium(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Tax & Charges', style: textStyle),
                Text('Rs ' + modelOrder.taxCharges.toString(),
                    style: textStyle),
              ],
            ),
          ),
          verticalSpaceMedium(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Delivery Fees', style: textStyle),
                Text('Rs ' + modelOrder.deliveryCharge.toString(),
                    style: textStyle),
              ],
            ),
          ),
          verticalSpaceMedium(),
          Container(
            color: Colors.grey[50],
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Paid', style: textStyle),
                Text('Rs ' + modelOrder.totalAmount.toString(),
                    style: textStyle),
              ],
            ),
          )
        ],
      ),
    );
  }
}
