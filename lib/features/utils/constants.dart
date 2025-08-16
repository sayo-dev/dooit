import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const designSize = Size(375, 812);

SizedBox h(double height) {
  return SizedBox(height: height.h);
}

SizedBox w(double width) {
  return SizedBox(width: width.w);
}

final List<Color> pastelColors = [
  Color(0xFFE3F2FD), // Soft Blue
  Color(0xFFF3E5F5), // Lavender
  Color(0xFFFFF8E1), // Warm Beige
  Color(0xFFF1FFF9), // Mint Cream
  Color(0xFFFFEBEE), // Rose Tint
  Color(0xFFE0F7FA), // Aqua Tint
  Color(0xFFF5F5F5), // Cool Gray
];

final _random = Random();

Color shuffleColor() {
  return pastelColors[_random.nextInt(pastelColors.length)];
}
