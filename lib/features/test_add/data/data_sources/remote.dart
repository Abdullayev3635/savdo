import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:savdo_agnet_client/features/test_add/data/models/name.dart';
import 'package:savdo_agnet_client/features/test_add/data/models/phone.dart';
import 'package:savdo_agnet_client/features/test_add/data/models/test_model.dart';

import '../../../../core/errors/failures.dart';

abstract class TestRemoteDataSource {
  Future<dynamic> getTest();
}

class TestRemoteDataSourceImpl implements TestRemoteDataSource {
  final http.Client client;

  TestRemoteDataSourceImpl({required this.client});

  @override
  Future<dynamic> getTest() async {
    List<NameModel> nameList = [];
    List<LoginModel> loginList = [];

    List<TestModel> testList = [];

    try {
      final response = await client.get(
        Uri.parse("http://192.168.30.79:5002/api/filter"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        try {
          final parsed = jsonDecode(response.body);
          log(response.body);
          for (int i = 0; i < (parsed["name"] as List).length; i++) {
            nameList.add(NameModel.fromJson(parsed["name"][i]));
          }
          for (int i = 0; i < (parsed["login"] as List).length; i++) {
            loginList.add(LoginModel.fromJson(parsed["login"][i]));
          }
          testList.add(TestModel(name: nameList, login: loginList));
          print(testList[0].login[1].phone);
          return testList;
        } catch (e) {
          debugPrint(e.toString());
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
