import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:wokonfire/utils/SABT.dart';
import 'package:wokonfire/utils/ui_helper.dart';
import 'package:wokonfire/widgets/my_separator.dart';

class OrderDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textStyle =
        Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 16.0);

    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: Get.height * 0.35,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: SABT(
                      child: Text(
                        "Order Summary",
                        style: Theme.of(context).textTheme.headline6.merge(
                              TextStyle(
                                  letterSpacing: 1.3, color: Colors.black),
                            ),
                      ),
                    ),
                    background: Image.asset(
                      "assets/images/ic_map_bg.png",
                      fit: BoxFit.fill,
                    )),
              ),
            ];
          },
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
                          title: Text("Restaurant Name"),
                          subtitle: Text("Restaurant Address"),
                        ),
                        ListTile(
                          title: Text("Customer Area (Vesu)"),
                          subtitle: Text("Customer Address"),
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
                  Icon(Icons.done, color: Colors.green),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Text(
                      "Order will be deliver withing 40 minutes. Order will be deliver withing 40 minutes",
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
                itemCount: 3,
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
                                  text: "Chili Pepper Cottage Cheese",
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
                            Text('5 ', style: textStyle),
                          ],
                        ),
                        Text('Rs 10', style: textStyle),
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
                      Text('Item total', style: textStyle),
                      Text('Rs 500', style: textStyle),
                    ],
                  )),
              verticalSpaceMedium(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Discount', style: textStyle),
                    Text('Rs 10', style: textStyle),
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
                    Text('To Pay', style: textStyle),
                    Text('Rs 500', style: textStyle),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
