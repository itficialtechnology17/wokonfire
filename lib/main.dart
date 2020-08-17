import 'package:flutter/material.dart';
import 'package:wokonfire/page/splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Splash(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Colors.black,
            // Use the old theme but    apply the following three changes
            textTheme:
                Theme.of(context).textTheme.apply(fontFamily: 'Roboto')));
  }
}
