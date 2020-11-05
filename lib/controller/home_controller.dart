import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wokonfire/model/model_dashboard_title.dart';
import 'package:wokonfire/model/model_slider.dart';
import 'package:wokonfire/network/request.dart';
import 'package:wokonfire/utils/url.dart';

class HomeController extends GetxController {
  var arrOfSlider = List<ModelSlider>().obs;
  var arrOfDashboardTitle = List<ModelDashboardTitle>().obs;
  var currentPosition = 0.0.obs;
  final pageController = PageController();

  @override
  void onInit() {
    super.onInit();

    _apiGetDashboard();
  }

  void _apiGetDashboard() async {
    Request request = Request(url: urlDashboard, body: {
      'type': "API",
      'c_id': "26",
      'lat': "21.143740",
      'long': "72.780731",
    });
    request.post().then((value) {
      final responseData = json.decode(value.body);

      arrOfSlider.value = (responseData['slider'] as List)
          .map((data) => ModelSlider.fromJson(data))
          .toList();

      arrOfDashboardTitle.value = (responseData['dashboard_titles'] as List)
          .map((data) => ModelDashboardTitle.fromJson(data))
          .toList();

      startBannerTimer();

      print("Successful");
    }).catchError((onError) {
      print(onError);
    });
  }

  void startBannerTimer() {
    Timer.periodic(
        Duration(seconds: 5),
        (timer) => {
              if (currentPosition < arrOfSlider.length - 1)
                {
                  currentPosition.value = currentPosition.value + 1.0,
                  pageController.animateToPage(currentPosition.toInt(),
                      duration: Duration(seconds: 1), curve: Curves.easeIn)
                }
              else
                {
                  currentPosition.value = 0,
                  pageController.animateToPage(currentPosition.toInt(),
                      duration: Duration(seconds: 1), curve: Curves.easeIn)
                }
            });
  }
}
