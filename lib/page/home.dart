import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:wokonfire/controller/cart_controller.dart';
import 'package:wokonfire/controller/customization_controller.dart';
import 'package:wokonfire/controller/favorite_controller.dart';
import 'package:wokonfire/controller/home_controller.dart';
import 'package:wokonfire/controller/search_controller.dart';
import 'package:wokonfire/tab/cart_tab.dart';
import 'package:wokonfire/tab/home_tab.dart';
import 'package:wokonfire/tab/profile_tab.dart';
import 'package:wokonfire/tab/search_tab.dart';
import 'package:wokonfire/utils/custom_color.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StateHome();
  }
}

class _StateHome extends State<Home> {
  var iconWidth = 25.0;
  var iconHeight = 25.0;
  CartController _cartController = Get.put(CartController());
  HomeController _homeController = Get.put(HomeController());

  FavoriteController _favoriteController = Get.put(FavoriteController());

  SearchController _searchController = Get.put(SearchController());
  CustomizationController _customizationController =
      Get.put(CustomizationController());

  var smallTextStyle = TextStyle(color: Colors.black, fontSize: 12);

  final List<Widget> _children = [
    HomeTab(),
    SearchTab(),
    CartTab(),
    ProfileTab()
  ];

  @override
  Widget build(BuildContext context) {
    final labelTextStyle =
        Theme.of(context).textTheme.subtitle2.copyWith(fontSize: 11.0);

    return Scaffold(
      body: Obx(() => _children[_homeController.selectedIndex.value]),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: darkOrange,
            unselectedItemColor: Colors.grey,
            currentIndex: _homeController.selectedIndex.value,
            selectedLabelStyle: labelTextStyle,
            unselectedLabelStyle: labelTextStyle,
            onTap: (index) {
              _homeController.selectedIndex.value = index;
              if (index == 2) {
                _cartController.apiGetCartItem();
              }
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text('HOME'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                title: Text('SEARCH'),
              ),
              BottomNavigationBarItem(
                icon: Stack(
                  children: <Widget>[
                    new Icon(Icons.add_shopping_cart_sharp),
                    new Positioned(
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: new BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        constraints: BoxConstraints(
                          minWidth: 12,
                          minHeight: 12,
                        ),
                        child: Visibility(
                          visible: _cartController.arrOfCart.length > 0
                              ? true
                              : false,
                          child: Text(
                            _cartController.arrOfCart.length.toString(),
                            style: new TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                title: Text('CART'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                title: Text('ACCOUNT'),
              ),
            ],
          )),
    );
  }
}
