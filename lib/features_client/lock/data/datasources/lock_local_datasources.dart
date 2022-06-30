import 'package:shared_preferences/shared_preferences.dart';

abstract class PassLocalDataSource {
  Future<bool> setCompile(String pass);
}

class PassLocalDataSourceImpl implements PassLocalDataSource {
  final SharedPreferences sharedPreferences;

  PassLocalDataSourceImpl({required this.sharedPreferences});


  @override
  Future<bool> setCompile(String pass) async {
    return sharedPreferences.getString('pin_code') == pass;
  }
}
