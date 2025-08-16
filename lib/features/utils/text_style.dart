
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'components/app_color.dart';

const String graphik = 'Graphik';

mixin Graphik on TextStyle {
  static TextStyle kFontW3 = TextStyle(
    fontFamily: graphik,
    fontWeight: FontWeight.w300,
    color: AppColor.black,
    fontSize: 16.spMin,
  );
  static TextStyle kFontW4 = TextStyle(
    fontFamily: graphik,
    fontWeight: FontWeight.w400,
    color: AppColor.black,
    fontSize: 16.spMin,
  );
  static TextStyle kFontW5 = TextStyle(
    fontFamily: graphik,
    fontWeight: FontWeight.w500,
    color: AppColor.black,
    fontSize: 16.spMin,
  );
  static TextStyle kFontW6 = TextStyle(
    fontFamily: graphik,
    fontWeight: FontWeight.w600,
    color: AppColor.black,
    fontSize: 16.spMin,
  );
  static TextStyle kFontW7 = TextStyle(
    fontFamily: graphik,
    fontWeight: FontWeight.w700,
    color: AppColor.black,
    fontSize: 16.spMin,
  );
}
