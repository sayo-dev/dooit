import 'package:flutter/material.dart';

import 'components/app_color.dart';

class AppThemeData {
  static ThemeData appThemeData(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      primarySwatch: kMaterialColor,
      primaryColor: AppColor.black,
      scaffoldBackgroundColor: AppColor.white,
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColor.black,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColor.white,
      ),
      // splashColor: Colors.transparent,
      // splashFactory: NoSplash.splashFactory
    );
  }
}
