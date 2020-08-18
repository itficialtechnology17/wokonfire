import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height * 0.08,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage("assets/icons/home.png"),
                    width: iconWidth,
                    height: iconHeight,
                    fit: BoxFit.contain,
                  ),
//                  Text("Home".toUpperCase(), style: smallTextStyle,)
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.home),
//                  Text("Search".toUpperCase(), style: smallTextStyle)
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage("assets/icons/buy.png"),
                    width: iconWidth,
                    height: iconHeight,
                    fit: BoxFit.fitHeight,
                  ),
//                  Text("Cart".toUpperCase(), style: smallTextStyle)
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage("assets/icons/test.png"),
                    width: iconWidth,
                    height: iconHeight,
                    fit: BoxFit.fitHeight,
                  ),
//                  Text("Cart".toUpperCase(), style: smallTextStyle)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
