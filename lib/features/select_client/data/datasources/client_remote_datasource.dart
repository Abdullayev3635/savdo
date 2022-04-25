import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:savdo_agnet_client/core/errors/failures.dart';
import 'package:savdo_agnet_client/core/utils/api_path.dart';
import 'package:savdo_agnet_client/features/select_client/data/model/client_model.dart';

import 'package:shared_preferences/shared_preferences.dart';

abstract class SelectClientRemoteDataSource {
  Future<List<ClientModel>> getClient();

  Future<List<ClientModel>> selectClient(
      {required int customerId, required int salesAgentId});
}

class SelectClientRemoteDataSourceImpl implements SelectClientRemoteDataSource {
  final SharedPreferences sharedPreferences;
  final http.Client client;

  SelectClientRemoteDataSourceImpl(
      {required this.sharedPreferences, required this.client});

  @override
  Future<List<ClientModel>> getClient() async {
    List<ClientModel> list = [];

    try {
      final response = await client.get(
        Uri.parse(baseUrl + clientPHP),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json'
          // "Authorization": "Bearer ${sharedPreferences.getString("token")}"
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

  @override
  Future<List<ClientModel>> selectClient(
      {required int customerId, required int salesAgentId}) async {
    List<ClientModel> list = [];

    try {
      dynamic json = {
        "customer_id": customerId,
        "sales_agent_id": salesAgentId
      };
      final response = await client.post(
        Uri.parse(baseUrl + onSelectClientPHP),
        body: jsonEncode(json),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json'
          // "Authorization": "Bearer ${sharedPreferences.getString("token")}"
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
