import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:wokonfire/controller/home_controller.dart';

class OfferBannerView extends StatelessWidget {
  HomeController homeController;
  OfferBannerView(this.homeController);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 180.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Swiper(
          itemHeight: 100,
          duration: 500,
          itemWidth: double.infinity,
          pagination: SwiperPagination(),
          itemCount: homeController.arrOfSlider.length,
          itemBuilder: (BuildContext context, int index) => Image.network(
            homeController.arrOfSlider[index].hbImage,
            fit: BoxFit.cover,
          ),
          autoplay: true,
          viewportFraction: 1.0,
          scale: 0.9,
        ),
      ),
      onTap: () {
        /*  Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GroceryScreen(),
          ),
        );*/
      },
    );
  }
}
