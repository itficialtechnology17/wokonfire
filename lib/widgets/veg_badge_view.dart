import 'package:flutter/material.dart';

class VegBadgeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2.0),
      height: 10.0,
      width: 10.0,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green[800]),
      ),
      child: ClipOval(
        child: Container(
          height: 5.0,
          width: 5.0,
          color: Colors.green[800],
        ),
      ),
    );
  }
}
