import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:savdo_agnet_client/features/buyurtma/presentation/bloc/buyurtma_bloc/buyurtma_dialog_bloc.dart';
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
class App extends StatefulWidget {
  App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  SharedPreferences sharedPreferences = di.get();

  late BuyurtmaDialogBloc buyurtmaDialogBloc;

  @override
  void initState() {
    buyurtmaDialogBloc = di<BuyurtmaDialogBloc>();
    super.initState();
  }

  String? workerId;

  @override
  Widget build(BuildContext context) {
    workerId = sharedPreferences.getString(sharedSalesAgentId) ?? "";
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, _) => BlocProvider(
        create: (BuildContext context) => buyurtmaDialogBloc,
        child: MaterialApp(
          builder: (context, widget) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: widget!,
            );
          },
          debugShowCheckedModeBanner: false,
          home: workerId == "" ? LoginPage.screen() : const MainPage(),
        ),
      ),
    );
  }
}
