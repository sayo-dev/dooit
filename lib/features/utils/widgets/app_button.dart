import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../components/app_color.dart';
import '../components/asset_resources/resources.dart';
import '../text_style.dart';

class AppButton extends StatelessWidget {
  final String text;
  final double fontSize;
  final double height;
  final double width;
  final VoidCallback onPressed;
  final bool inactive;
  final Color? color;
  final Color? borderColor;
  final Color? textColor;
  final String? icon;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.fontSize = 18,
    this.height = 45,
    this.width = 125,
    this.inactive = false,
    this.borderColor,
    String? icon,
    Color? color,
    Color? textColor,
  }) : color = AppColor.black,
       textColor = AppColor.white,
       icon = Vectors.add;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: inactive ? null : onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        elevation: 0,
        fixedSize: Size(width.w, height.h),
        splashFactory: InkRipple.splashFactory,
        overlayColor: textColor?.withOpacity(0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null)
            Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: SvgPicture.asset(icon!),
            ),
          Text(
            text,
            style: Graphik.kFontW4.copyWith(
              color: textColor,
              fontSize: fontSize.spMin,
            ),
          ),
        ],
      ),
    );
  }
}
