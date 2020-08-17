import 'package:flutter/material.dart';
import 'package:wokonfire/slider/slider_layout_view.dart';

class Introduction extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StateIntroduction();
  }
}

class _StateIntroduction extends State<Introduction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: onBoardingBody(),
    );
  }

  Widget onBoardingBody() => Container(
        child: SliderLayoutView(),
      );
}
