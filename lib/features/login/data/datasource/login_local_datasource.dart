import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/errors/failures.dart';
import '../model/user_model.dart';

abstract class LoginLocalDataSource {
  Future<String> setDataLocal(List<UserModel> list);
}

class LoginLocalDataSourceImpl implements LoginLocalDataSource {
  final SharedPreferences sharedPreferences;

  LoginLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<String> setDataLocal(List<UserModel> list) async {
    try {
      sharedPreferences.setString("id", list[0].id.toString());
      sharedPreferences.setString("name", list[0].name.toString());
      sharedPreferences.setString("login", list[0].login.toString());
      sharedPreferences.setString("phone", list[0].phoneNumber.toString());
      sharedPreferences.setString("regionId", list[0].regionId.toString());
      sharedPreferences.setString("sectorId", list[0].sectorId.toString());
      sharedPreferences.setString("token", list[0].token.toString());
      return "2";
    } on LocalFailure {
      return "500";
    }
  }
}
