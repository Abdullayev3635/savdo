import 'dart:async';
import 'package:flutter/material.dart';
import 'di/dependency_injection.dart' as di;
import 'features/app.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runZonedGuarded(() {
    runApp(const AppProvider());
  }, (error, stacktrace) {
    debugPrint(error.toString());
    debugPrint(stacktrace.toString());
  });
}
