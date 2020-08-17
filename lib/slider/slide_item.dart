import 'package:flutter/cupertino.dart';
import 'package:wokonfire/model/slider.dart';

class SlideItem extends StatelessWidget {
  final int index;
  SlideItem(this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width,
      width: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(sliderArrayList[index].sliderImageUrl))),
    );
  }
}
