import 'package:flutter/cupertino.dart';

class Slider {
  final String sliderImageUrl;

  Slider({
    @required this.sliderImageUrl,
  });
}

final sliderArrayList = [
  Slider(sliderImageUrl: 'assets/images/ic_onboard_01.png'),
  Slider(sliderImageUrl: 'assets/images/ic_onboard_02.png'),
  Slider(sliderImageUrl: 'assets/images/ic_onboard_03.png'),
  Slider(sliderImageUrl: 'assets/images/ic_onboard_04.png'),
];
