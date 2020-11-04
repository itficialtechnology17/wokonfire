import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wokonfire/utils/custom_color.dart';
import 'package:wokonfire/utils/ui_helper.dart';
import 'package:wokonfire/widgets/custom_divider_view.dart';

class ProfileTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StateProfileTab();
  }
}

class _StateProfileTab extends State<ProfileTab> {
  final List<String> titles = [
    'My Account',
    'Address',
    'Favorite',
    'Offers',
    'Referrals',
    'Help',
  ];

  final List<String> body = [
    'Name, Email, Mobile Number, Profile Photo',
    'Home, Office & Other Address',
    'Favorites Food Item By Category',
    'Restaurant & Others Offers',
    'Refer & Earn In Wallet',
    'FAQ & Links',
  ];

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _AppBar(),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: titles.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => _ListItem(
                    title: titles[index],
                    body: body[index],
                    isLastItem: (titles.length - 1) == index,
                  ),
                ),
                CustomDividerView(),
                Row(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 10.0),
                      height: 50.0,
                      child: Text(
                        'LOGOUT',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2
                            .copyWith(fontSize: 16.0),
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.power_settings_new),
                    horizontalSpaceSmall(),
                  ],
                ),
                Container(
                  alignment: Alignment.topCenter,
                  padding: const EdgeInsets.only(top: 20.0),
                  height: 130.0,
                  color: Colors.grey[200],
                  child: Text(
                    'App Version v1.1.0',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: Colors.grey[700], fontSize: 13.0),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final subtitleStyle = Theme.of(context).textTheme.bodyText1;

    return Container(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'VINOTH',
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              InkWell(
                child: Text(
                  'EDIT',
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(fontSize: 17.0, color: darkOrange),
                ),
                onTap: () {},
              )
            ],
          ),
          verticalSpaceSmall(),
          Row(
            children: <Widget>[
              Text('8870123456', style: subtitleStyle),
              horizontalSpaceSmall(),
              ClipOval(
                child: Container(
                  height: 3.0,
                  width: 3.0,
                  color: Colors.grey[700],
                ),
              ),
              horizontalSpaceSmall(),
              Text('vinothvino@icloud.com', style: subtitleStyle)
            ],
          ),
          verticalSpaceLarge(),
          CustomDividerView(
            dividerHeight: 1.8,
            color: Colors.black,
          )
        ],
      ),
    );
  }
}

class _ListItem extends StatelessWidget {
  final String title;
  final String body;
  final bool isLastItem;

  const _ListItem({
    Key key,
    @required this.title,
    @required this.body,
    this.isLastItem = false,
  })  : assert(title != '', body != ''),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(fontSize: 15.0),
                  ),
                  verticalSpaceExtraSmall(),
                  Text(
                    body,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(fontSize: 13.0, color: Colors.black),
                  ),
                ],
              ),
              Spacer(),
              horizontalSpaceSmall(),
              Icon(Icons.keyboard_arrow_right)
            ],
          ),
          verticalSpaceLarge(),
          isLastItem
              ? SizedBox()
              : CustomDividerView(
                  dividerHeight: 0.8,
                  color: Colors.black26,
                ),
        ],
      ),
    );
  }
}
