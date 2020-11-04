import 'package:flutter/cupertino.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _PastOrderListView(),
    );
  }
}

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
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ListView.builder(
          shrinkWrap: true,
          itemCount: restaurants.length,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => _PastOrdersListItemView(
            restaurant: restaurants[index],
            foodItem: foods[index],
          ),
        ),
        /* FlatButton(
          child: Text(
            'VIEW MORE ORDERS',
            style: Theme.of(context)
                .textTheme
                .subtitle2
                .copyWith(color: darkOrange),
          ),
          onPressed: () {},
        ),*/
        verticalSpaceSmall(),
      ],
    );
  }
}

class _PastOrdersListItemView extends StatelessWidget {
  final String restaurant;
  final String foodItem;

  const _PastOrdersListItemView({
    Key key,
    @required this.restaurant,
    @required this.foodItem,
  })  : assert(restaurant != '', foodItem != ''),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
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
                      restaurant,
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
                        Text('Rs112'),
                        horizontalSpaceExtraSmall(),
                        Icon(Icons.keyboard_arrow_right,
                            color: Colors.grey[600])
                      ],
                    )
                  ],
                ),
                Spacer(),
                Text('Delivered', style: Theme.of(context).textTheme.subtitle2),
                horizontalSpaceSmall(),
                ClipOval(
                  child: Container(
                    padding: const EdgeInsets.all(2.2),
                    color: Colors.green,
                    child: Icon(Icons.check, color: Colors.white, size: 14.0),
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
              Text(foodItem),
              verticalSpaceExtraSmall(),
              Text('July 14, 2:11 AM'),
              verticalSpaceSmall(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        OutlineButton(
                          color: darkOrange,
                          borderSide: BorderSide(width: 1.5, color: darkOrange),
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
                        Text('Delivery rating not\napplicable for this order')
                      ],
                    ),
                  ),
                  horizontalSpaceMedium(),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        OutlineButton(
                          color: darkOrange,
                          borderSide:
                              BorderSide(width: 1.5, color: Colors.black),
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
                    ),
                  )
                ],
              ),
              verticalSpaceMedium(),
              CustomDividerView(dividerHeight: 1.5, color: Colors.black)
            ],
          )
        ],
      ),
    );
  }
}
