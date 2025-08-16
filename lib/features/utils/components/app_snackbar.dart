import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../text_style.dart';
import 'app_color.dart';

class AppSnackBar {
  static void showMessage(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 5),
    SnackBarAction? action,
    bool showCloseIcon = false,
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: Graphik.kFontW5.copyWith(
            color: AppColor.white,
            fontSize: 14.spMin,
          ),
        ),
        backgroundColor: AppColor.black,
        duration: duration,
        action: action,
        showCloseIcon: showCloseIcon,
        closeIconColor: AppColor.white,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(16.w),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        elevation: 6,
      ),
    );
  }
}
