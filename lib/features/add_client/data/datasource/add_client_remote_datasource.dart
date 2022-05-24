import 'dart:convert';
import 'dart:developer';

import 'package:savdo_agnet_client/core/utils/api_path.dart';
import 'package:savdo_agnet_client/features/add_client/data/model/add_client_model.dart';
import 'package:http/http.dart' as http;
import 'package:savdo_agnet_client/features/add_client/data/model/data_model.dart';
import 'package:savdo_agnet_client/features/add_client/data/model/error_model.dart';
import 'package:savdo_agnet_client/features/add_client/data/model/name.dart';
import 'package:savdo_agnet_client/features/add_client/data/model/phone.dart';

import '../../../../core/errors/failures.dart';

List<NameModel> nameModel = [];

abstract class AddClientRemoteDatasource {
  Future<dynamic> addClient({required AddClientModel clientDataList});

  Future<dynamic> getAllData();
}

class AddClientRemoteDatasourceImpl extends AddClientRemoteDatasource {
  final http.Client client;

  AddClientRemoteDatasourceImpl({required this.client});

  @override
  Future<dynamic> addClient({required AddClientModel clientDataList}) async {
    try {
      List<AddClientErrorModel> listError = [];
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
        }
        return listError;
      } else {
        return [];
      }
    } on InputFormatterFailure {
      return [];
    }
  }

  @override
  Future<dynamic> getAllData() async {
    List<NameModel> nameList = [];
    List<LoginModel> loginList = [];
    List<DataModel> testList = [];

    try {
      final response = await client.get(
        Uri.parse(apiFilter),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        try {
          final parsed = jsonDecode(response.body);
          for (int i = 0; i < (parsed["name"] as List).length; i++) {
            nameList.add(NameModel.fromJson(parsed["name"][i]));
            nameModel = nameList;
          }
          for (int i = 0; i < (parsed["login"] as List).length; i++) {
            loginList.add(LoginModel.fromJson(parsed["login"][i]));
          }
          testList.add(DataModel(name: nameList, login: loginList));
          log(testList[0].login.length.toString());
          return testList;
        } catch (e) {
          log(e.toString());
        }
      } else {
        testList = [];
      }

      return testList;
    } on InputFormatterFailure {
      return [];
    }
  }
}
