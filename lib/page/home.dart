import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wokonfire/controller/add_to_cart_controller.dart';
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

  CustomizationController _customizationController =
      Get.put(CustomizationController());
  HomeController _homeController = Get.put(HomeController());
  FavoriteController _favoriteController = Get.put(FavoriteController());

  CartController _cartController = Get.put(CartController());
  SearchController _searchController = Get.put(SearchController());
  AddToCartController _addToCartController = Get.put(AddToCartController());

  var smallTextStyle = TextStyle(color: Colors.black, fontSize: 12);

  int selectedIndex = 0;
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
      body: _children[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: darkOrange,
        unselectedItemColor: Colors.grey,
        currentIndex: selectedIndex,
        selectedLabelStyle: labelTextStyle,
        unselectedLabelStyle: labelTextStyle,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
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
            icon: Icon(Icons.add_shopping_cart),
            title: Text('CART'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            title: Text('ACCOUNT'),
          ),
        ],
      ),
    );
  }

  void _incrementTab(index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
