import 'package:flutter/material.dart';
import 'package:mediq/helpers/calculate_pixels.dart';

Container appbarIcon(double dw) {
  return Container(
    margin: EdgeInsets.only(left: getPixels(24, dw)),
    child: Transform.scale(
      scale: 1.4,
      child: Image.asset(
        'assets/images/logo.png',
        scale: 1.4,
      ),
    ),
  );
}
