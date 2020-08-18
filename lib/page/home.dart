import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StateHome();
  }
}

class _StateHome extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.green,
    );
  }
}
