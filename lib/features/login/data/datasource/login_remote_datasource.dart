import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/api_path.dart';
import '../model/user_model.dart';

abstract class LoginRemoteDatasource {
  Future<dynamic> setData(String tel, String macAddress);
}

class LoginRemoteDatasourceImpl implements LoginRemoteDatasource {
  final http.Client client;

  LoginRemoteDatasourceImpl({required this.client});

  @override
  Future<dynamic> setData(String tel, String macAddress) async {
    List<UserModel> _list = [];
    try {
      var body = {
        "phone_number": tel,
        "pass": macAddress,
      };

      final response = await client.post(
        Uri.parse(baseUrl + loginPHP),
        body: jsonEncode(body),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        if (response.body.toString() == "1") {
          return response.body.toString();
        } else if (response.body.toString() == "0") {
          return response.body.toString();
        } else {
          final parsed = json.decode(response.body);
          for (int i = 0; i < (parsed["data"] as List).length; i++) {
            _list.add(UserModel.fromJson(parsed["data"][i]));
          }
          return _list;
        }
      } else {
        return "0";
      }
    } on InputFormatterFailure {
      return "500";
    }
  }
}
