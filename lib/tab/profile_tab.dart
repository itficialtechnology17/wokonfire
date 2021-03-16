import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:wokonfire/constant/constant_value.dart';
import 'package:wokonfire/constant/constants_key.dart';
import 'package:wokonfire/controller/user_controller.dart';
import 'package:wokonfire/offers/offer_screen.dart';
import 'package:wokonfire/order/order_history.dart';
import 'package:wokonfire/page/login.dart';
import 'package:wokonfire/page/profile/favorite_food.dart';
import 'package:wokonfire/page/profile/invite_friends.dart';
import 'package:wokonfire/page/profile/my_account.dart';
import 'package:wokonfire/utils/shared_preference.dart';
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
    'Favorite',
    'Offers',
    'Orders',
    'Referrals',
    'Help',
  ];

  final List<String> body = [
    'Name, Email, Mobile Number & Address',
    'Favorites Food Item By Category',
    'Restaurant & Others Offers',
    'View your order history',
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
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      if (index == 0) {
                        Get.to(MyAccount(""));
                      } else if (index == 1) {
                        Get.to(FavoriteFood());
                      } else if (index == 2) {
                        Get.to(OffersScreen());
                      } else if (index == 3) {
                        Get.to(OrderHistory());
                      } else if (index == 4) {
                        Get.to(InviteFriends());
                      }
                    },
                    child: _ListItem(
                      title: titles[index],
                      body: body[index],
                      isLastItem: (titles.length - 1) == index,
                    ),
                  ),
                ),
                CustomDividerView(),
                InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => _confirmLogout());
                    /*Get.changeTheme(
                        Get.isDarkMode ? ThemeData.light() : ThemeData.dark());*/
                  },
                  child: Row(
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
                ),
                Container(
                  alignment: Alignment.topCenter,
                  padding: const EdgeInsets.only(top: 20.0),
                  height: 200.0,
                  color: Colors.grey[200],
                  child: Text(
                    'Version 1.0.0',
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

  _confirmLogout() {
    return AlertDialog(
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Wrap(
            children: <Widget>[
              Text(
                "Confirm Logout ?",
                style: TextStyle(fontSize: 18),
              )
            ],
          )
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () async {
            // Navigator.of(context, rootNavigator: true).pop('dialog');
            await addBoolToSF(KEY_IS_LOGIN, false);
            isLogin = false;
/*
            Navigator.pushNamedAndRemoveUntil(
                context, "/LoginPage", (r) => false);*/
            Get.offAll(Login());
          },
          textColor: Colors.black,
          child: const Text('YES'),
        ),
        new FlatButton(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop('dialog');
          },
          textColor: Colors.red,
          child: const Text('CANCEL'),
        ),
      ],
    );
  }
}

class _AppBar extends StatelessWidget {
  UserController _userController = Get.find();
  @override
  Widget build(BuildContext context) {
    final subtitleStyle = Theme.of(context).textTheme.bodyText1;

    return Obx(() => Container(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    _userController.modelUser.value.userName == null
                        ? "Name"
                        : _userController.modelUser.value.userName == ""
                            ? AutofillHints.name
                            : _userController.modelUser.value.userName,
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 18.0),
                  ),
                ],
              ),
              verticalSpaceSmall(),
              Row(
                children: <Widget>[
                  Text(
                      _userController.modelUser.value.contactNumber == null
                          ? "Mobile Number"
                          : _userController.modelUser.value.contactNumber,
                      style: subtitleStyle),
                  horizontalSpaceSmall(),
                  ClipOval(
                    child: Container(
                      height: 3.0,
                      width: 3.0,
                      color: Colors.grey[700],
                    ),
                  ),
                  horizontalSpaceSmall(),
                  Text(
                      _userController.modelUser.value.email == null
                          ? "Email Address"
                          : _userController.modelUser.value.email == ""
                              ? "Email Address"
                              : _userController.modelUser.value.email,
                      style: subtitleStyle)
                ],
              ),
              verticalSpaceLarge(),
              CustomDividerView(
                dividerHeight: 1.8,
                color: Colors.black,
              )
            ],
          ),
        ));
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
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          verticalSpaceMedium(),
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
          verticalSpaceMedium(),
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
