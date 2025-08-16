import 'package:flutter/material.dart';

class AppColor {
  static const kE5E5E5 = Color(0xffE5E5E5);
  static const kC4C4C4 = Color(0xffC4C4C4);
  static const k8C8E8F = Color(0xff8C8E8F);
  static const kDADADA = Color(0xffDADADA);
  static const k898989 = Color(0xff898989);
  static const kE5FFE6 = Color(0xffE5FFE6);
  static const kF5F5F5 = Color(0xFFF5F5F5);
  static const kF4F4F4 = Color(0xFFF4F4F4);
  static const kE3E2E2 = Color(0xFFE3E2E2);

  static const black = Colors.black;
  static const white = Colors.white;
  static const transparent = Colors.transparent;
}

Map<int, Color> kPrimaryMap = {
  50: const Color.fromRGBO(0, 0, 0, .1),
  100: const Color.fromRGBO(0, 0, 0, .2),
  200: const Color.fromRGBO(0, 0, 0, .3),
  300: const Color.fromRGBO(0, 0, 0, .4),
  400: const Color.fromRGBO(0, 0, 0, .5),
  500: const Color.fromRGBO(0, 0, 0, .6),
  600: const Color.fromRGBO(0, 0, 0, .7),
  700: const Color.fromRGBO(0, 0, 0, .8),
  800: const Color.fromRGBO(0, 0, 0, .9),
  900: const Color.fromRGBO(0, 0, 0, 1),
};

MaterialColor kMaterialColor = MaterialColor(AppColor.black.value, kPrimaryMap);
