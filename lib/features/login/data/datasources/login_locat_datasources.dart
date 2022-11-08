import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/app_constants.dart';
import '../model/user_model.dart';

abstract class LoginLocalDataSource {
  Future<String> setDataLocal(UserModel list);
}

class LoginLocalDataSourceImpl implements LoginLocalDataSource {
  final SharedPreferences sharedPreferences;

  LoginLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<String> setDataLocal(UserModel list) async {
    try {
      sharedPreferences.setString(sharedSalesAgentId, list.workerId.toString());
      sharedPreferences.setString("worker_name", list.workerName.toString());
      sharedPreferences.setString("image", list.image.toString());
      sharedPreferences.setString(sharedBranchId, list.branchId.toString());
      sharedPreferences.setString("branch_name", list.branchName.toString());
      sharedPreferences.setString("roles", list.roles.toString());
      sharedPreferences.setString(sharedToken, list.token.toString());
      return "2";
    } on LocalFailure {
      return "500";
    }
  }
}
