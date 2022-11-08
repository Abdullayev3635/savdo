import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:savdo_agnet_client/core/errors/failures.dart';
import 'package:savdo_agnet_client/core/utils/api_path.dart';

abstract class EditClientRemoteDatasource {
  Future<dynamic> getEditClient(String phone1, String coordinate, int id);
}

class EditClientRemoteDatasourceImpl extends EditClientRemoteDatasource {
  final http.Client client;

  EditClientRemoteDatasourceImpl({required this.client});

  @override
  Future getEditClient(String phone1, String coordinate, int id) async {
    try {
      dynamic json = {
        "coordinate": coordinate,
        "phone_1": phone1,
      };
      final response = await client.put(
        Uri.parse(baseUrl + clientCreatePHP + '/$id'),
        body: jsonEncode(json),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          // "Authorization": "Bearer ${sharedPreferences.getString("token")}"
        },
      );
      if (response.statusCode == 200) {
        const trueData = "[\"TRUE\"]";
        if (response.body.toString().contains(trueData)) {
          return true;
        } else {
          return false;
        }
      }
    } on InputFormatterFailure {
      return [];
    }
  }
}
