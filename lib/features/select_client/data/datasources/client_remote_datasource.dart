import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:savdo_agnet_client/core/errors/failures.dart';
import 'package:savdo_agnet_client/core/utils/api_path.dart';
import 'package:savdo_agnet_client/features/select_client/data/model/client_model.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/utils/app_constants.dart';

abstract class SelectClientRemoteDataSource {
  Future<List<ClientModel>> getClient();

}

class SelectClientRemoteDataSourceImpl implements SelectClientRemoteDataSource {
  final SharedPreferences sharedPreferences;
  final http.Client client;

  SelectClientRemoteDataSourceImpl(
      {required this.sharedPreferences, required this.client});

  @override
  Future<List<ClientModel>> getClient() async {
    List<ClientModel> list = [];
    int brenchId = int.parse(sharedPreferences.getString(sharedBranchId)??"0");
    dynamic json = {
      "branch_id": brenchId
    };
    try {
      final response = await client.post(
        Uri.parse(baseUrl + clientPHP),
        body: jsonEncode(json),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          "Authorization": "Bearer ${sharedPreferences.getString("token")}"
        },
      );
      if (response.statusCode == 200) {
        log(response.body.toString());
        final parsed = jsonDecode(response.body);
        for (int i = 0; i < (parsed["data"] as List).length; i++) {
          list.add(ClientModel.fromJson(parsed["data"][i]));
        }
        return list;
      } else {
        return [];
      }
    } on InputFormatterFailure {
      return [];
    }
  }
}
