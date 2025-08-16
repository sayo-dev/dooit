import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension Widgets on Widget {
  Widget get hPad =>
      Padding(padding: EdgeInsets.symmetric(horizontal: 24.w), child: this);

  Widget get allPad =>
      Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
          child: this);

  Widget customPad({double? vertical, double? horizontal}) =>
      Padding(
          padding: EdgeInsets.symmetric(
              vertical: (vertical ?? 0).h, horizontal: (horizontal ?? 0).w),
          child: this);
}