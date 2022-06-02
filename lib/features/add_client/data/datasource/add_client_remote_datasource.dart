import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:savdo_agnet_client/core/utils/api_path.dart';
import 'package:savdo_agnet_client/features/add_client/data/model/add_client_model.dart';
import 'package:savdo_agnet_client/features/add_client/data/model/name.dart';

List<NameModel> nameModel = [];

abstract class AddClientRemoteDatasource {
  Future<dynamic> addClient({required AddClientModel clientDataList});

  Future<dynamic> validateNameClient({required String validateName});

  Future<dynamic> validatePhoneClient({required String validatePhone});
}

class AddClientRemoteDatasourceImpl extends AddClientRemoteDatasource {
  final http.Client client;

  AddClientRemoteDatasourceImpl({required this.client});

  @override
  Future<dynamic> addClient({required AddClientModel clientDataList}) async {
    // try {
      dynamic json = {
        "address": clientDataList.address,
        "state_id": clientDataList.stateId,
        "region_id": clientDataList.regionId,
        "login": clientDataList.login,
        "name": clientDataList.name,
        "password": clientDataList.password,
        "legal_physical": clientDataList.legalPhysical,
        "phone_1": clientDataList.phone1,
        "cordinates": clientDataList.coordinates,
        "sales_agent_id": clientDataList.salesAgentId
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
        const trueData = "[\"TRUE\"]";
        if (response.body.toString().contains(trueData)) {
          return true;
        } else {
          return false;
        }
      }
      // if (response.statusCode == 200) {
      //   response.contentLength;
      //   final parsed = jsonDecode(response.body);
      //   for (int i = 0; i < (parsed["error_list"] as List).length; i++) {
      //     listError.add(AddClientErrorModel.fromJson(parsed["errors"]));
      //   }
      //   return listError;
      // } else {
      //   return [];
      // }
    // } on InputFormatterFailure {
    //   return [];
    // }
  }

  @override
  Future validatePhoneClient({required String validatePhone}) async {
    dynamic json = {
      "phone_number": validatePhone,
    };
    final response = await http.post(
      Uri.parse(baseUrl + clientValidatePhonePHP),
      body: jsonEncode(json),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json'
      },
    );
    if (response.statusCode == 200) {
      const trueData = "{\"data\":\"TRUE\"}";
      if (response.body.toString() == trueData) {
        return response.body.toString() == trueData;
      } else {
        return false;
      }
    }
  }

  @override
  Future validateNameClient({required String validateName}) async {
    dynamic json = {
      "name": validateName,
    };
    final response = await http.post(
      Uri.parse(baseUrl + clientValidateNamePHP),
      body: jsonEncode(json),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json'
      },
    );
    if (response.statusCode == 200) {
      const trueData = "{\"data\":\"TRUE\"}";
      if (response.body.toString() == trueData) {
        return response.body.toString() == trueData;
      } else {
        return false;
      }
    }
  }
}
