import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:savdo_agnet_client/features/firmalar/presentation/pages/firmalar_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../di/dependency_injection.dart';

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

  @override
  Widget build(BuildContext context) {
    // String id = sharedPreferences.getString('id') ?? "";
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context,_) => MaterialApp(
        builder: (context, widget) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: widget!,
          );
        },
        debugShowCheckedModeBanner: false,
        home:FirmalarPage.screen(),
      ),
    );
  }
}
