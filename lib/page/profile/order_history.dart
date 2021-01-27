import 'dart:io';

import 'package:flutter/material.dart';
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
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        elevation: 0,
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
      body: ListView.separated(
        shrinkWrap: true,
        itemCount: restaurants.length,
        itemBuilder: (context, index) {
          return InkWell(
            child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              restaurants[index],
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            verticalSpaceExtraSmall(),
                            Text(
                              'Medavakkam',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(fontSize: 12.0),
                            ),
                            verticalSpaceSmall(),
                            Row(
                              children: <Widget>[
                                Text('Rs 112'),
                                horizontalSpaceExtraSmall(),
                                Icon(Icons.keyboard_arrow_right,
                                    color: Colors.grey[600])
                              ],
                            )
                          ],
                        ),
                        Spacer(),
                        Text('Delivered',
                            style: Theme.of(context).textTheme.subtitle2),
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
                      Text(foods[index]),
                      verticalSpaceExtraSmall(),
                      Text('July 14, 2:11 AM'),
                      verticalSpaceSmall(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            child: OutlineButton(
                              color: darkOrange,
                              borderSide:
                                  BorderSide(width: 1, color: darkOrange),
                              child: Text(
                                'REORDER',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2
                                    .copyWith(color: darkOrange),
                              ),
                              onPressed: () {},
                            ) /*Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                OutlineButton(
                                  color: darkOrange,
                                  borderSide:
                                      BorderSide(width: 1.5, color: darkOrange),
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
                            )*/
                            ,
                          ),
                          horizontalSpaceMedium(),
                          Expanded(
                            child: Text(
                                "") /*Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                OutlineButton(
                                  color: darkOrange,
                                  borderSide: BorderSide(
                                      width: 1.5, color: Colors.black),
                                  child: Text(
                                    'RATE FOOD',
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2
                                        .copyWith(color: Colors.black),
                                  ),
                                  onPressed: () {},
                                ),
                                verticalSpaceMedium(),
                                Text("You haven't rated\nthis food yet")
                              ],
                            )*/
                            ,
                          )
                        ],
                      ),
                      verticalSpaceMedium(),
                      CustomDividerView(dividerHeight: 1.5, color: Colors.black)
                    ],
                  )
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 8,
          );
        },
      ),
    );
  }
}
