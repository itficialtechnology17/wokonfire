import 'package:flutter/material.dart';
import 'package:wokonfire/tab/cart_tab.dart';
import 'package:wokonfire/tab/home_tab.dart';
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

  var smallTextStyle = TextStyle(color: Colors.black, fontSize: 12);

  int selectedIndex = 0;
  final List<Widget> _children = [HomeTab(), SearchTab(), CartTab(), HomeTab()];

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
