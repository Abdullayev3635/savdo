import 'dart:convert';

import 'package:savdo_agnet_client/core/utils/api_path.dart';
import 'package:savdo_agnet_client/features/add_client/data/model/add_client_model.dart';
import 'package:http/http.dart' as http;
import 'package:savdo_agnet_client/features/add_client/data/model/error_model.dart';

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
    try {
      List<AddClientErrorModel> listError = [];
      dynamic json = {
        "address": clientDataList[0].address,
        "state_id": clientDataList[0].stateId,
        "region_id": clientDataList[0].regionId,
        "login": clientDataList[0].login,
        "name": clientDataList[0].name,
        "password": clientDataList[0].password,
        "legal_physical": clientDataList[0].legalPhysical,
        "phone_1": clientDataList[0].phone1,
        "cordinates": clientDataList[0].coordinates,
      };
      final response = await http.post(
        Uri.parse(baseUrl + clientPHP),
        body: jsonEncode(json),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json'
        },
      );
      if (response.statusCode == 200) {
        response.contentLength;
        final parsed = jsonDecode(response.body);
        for (int i = 0; i < (parsed["error_list"] as List).length; i++) {
          listError.add(AddClientErrorModel.fromJson(parsed["errors"]));
          print(listError);
        }
        return listError;
      } else {
        return [];
      }
    } on InputFormatterFailure {
      return [];
    }
  }
}
