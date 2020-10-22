import 'package:flutter/material.dart';
import 'package:wokonfire/page/splash.dart';
import 'package:wokonfire/utils/app_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Splash(),
        debugShowCheckedModeBanner: false,
        theme: appPrimaryTheme());
  }
}
