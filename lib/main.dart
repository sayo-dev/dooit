import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'features/core/storage.dart';
import 'features/screens/home/to_do/state/to_do_cubit.dart';
import 'features/utils/components/app_route.dart';
import 'features/utils/constants.dart';
import 'features/utils/theme_data.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  LocalStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ToDoCubit(),
      child: ScreenUtilInit(
        designSize: designSize,
        child: MaterialApp.router(
          theme: AppThemeData.appThemeData(context),
          title: 'Dooit',
          debugShowCheckedModeBanner: false,
          routerConfig: AppRoute.router,
        ),
      ),
    );
  }
}
