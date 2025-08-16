import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_svg/flutter_svg.dart';

import '../utils/components/app_color.dart';
import '../utils/components/app_route.dart';
import '../utils/components/asset_resources/resources.dart';
import '../utils/constants.dart';
import '../utils/text_style.dart';

class Welcome extends HookWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      final timer = Timer.periodic(Duration(seconds: 5), (_) {
        if (context.mounted) {
          context.go(AppRoute.home);
        }
      });
      return () => timer.cancel;
    }, []);
    return Scaffold(
      backgroundColor: AppColor.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            SvgPicture.asset(Vectors.logoWhite),
            h(32),
            Text(
              'Dooit',
              style: Graphik.kFontW6.copyWith(
                fontSize: 32.spMin,
                color: AppColor.white,
              ),
            ),
            Spacer(),
            Text(
              'Write what you need to do.  Everyday.',
              textAlign: TextAlign.center,
              style: Graphik.kFontW6.copyWith(color: AppColor.kC4C4C4),
            ),
            h(30),
          ],
        ),
      ),
    );
  }
}
