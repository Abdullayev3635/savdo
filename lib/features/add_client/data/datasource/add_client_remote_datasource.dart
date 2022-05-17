import 'dart:convert';

import 'package:savdo_agnet_client/core/utils/api_path.dart';
import 'package:savdo_agnet_client/features/add_client/data/model/add_client_model.dart';
import 'package:http/http.dart' as http;

import '../../../../core/errors/failures.dart';

abstract class AddClientRemoteDatasource {
  Future<dynamic> addClient({required List<AddClientModel> clientDataList});
}

class AddClientRemoteDatasourceImpl extends AddClientRemoteDatasource {
  final http.Client client;

  AddClientRemoteDatasourceImpl({required this.client});

  @override
  Future<dynamic> addClient(
      {required List<AddClientModel> clientDataList}) async {
    var jsonList = jsonEncode(clientDataList.map((e) => e.toJson()).toList());
    try {
      dynamic json = {
        "address": jsonDecode(jsonList),
      };
      final response = await http.post(
        Uri.parse(baseUrl + clientPHP),
        body: jsonEncode(json),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json'
        },
      );
      if (response.statusCode == 200) {}
    } on InputFormatterFailure {
      return [];
    }
  }
}
