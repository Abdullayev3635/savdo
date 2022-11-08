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
  Future<dynamic> setData(String tel, String password) async {
    try {
      var body = {
        "phoneNumber": "998" + tel,
        "password": password,
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
        final parsed = json.decode(response.body);
        return UserModel.fromJson(parsed);
      } else {
        return "0";
      }
    } on InputFormatterFailure {
      return "500";
    }
  }
}
