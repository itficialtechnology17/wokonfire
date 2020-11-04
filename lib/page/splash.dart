import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wokonfire/page/home.dart';

class Splash extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StateSplash();
  }
}

class _StateSplash extends State<Splash> {
  @override
  void initState() {
    super.initState();
    var _duration = new Duration(seconds: 2);
    Timer(_duration, moveToNextPage);
  }

  moveToNextPage() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Home()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.red[800],
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Center(
              child: Image(
                image: AssetImage("assets/images/ic_logo.png"),
              ),
            ),
          )),
    );
  }
}
