import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:savdo_agnet_client/features/firmalar/presentation/pages/firmalar_page.dart';
import 'package:savdo_agnet_client/features/main/presentation/pages/main_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/utils/app_constants.dart';
import '../di/dependency_injection.dart';
import 'login/presentation/pages/login_page.dart';

class AppProvider extends StatelessWidget {
  const AppProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return App();
  }
}

// ignore: must_be_immutable
class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  SharedPreferences sharedPreferences = di.get();

  String? workerId;

  @override
  Widget build(BuildContext context) {
    workerId = sharedPreferences.getString(sharedSalesAgentId) ?? "";
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, _) => MaterialApp(
        builder: (context, widget) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: widget!,
          );
        },
        debugShowCheckedModeBanner: false,
        home: workerId == "" ? LoginPage.screen() : const MainPage(),
      ),
    );
  }
}
