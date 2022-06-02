import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:savdo_agnet_client/core/utils/app_constants.dart';
import 'package:savdo_agnet_client/di/dependency_injection.dart';
import 'package:savdo_agnet_client/features/archive/data/model/archive_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/api_path.dart';

abstract class ArchiveRemoteDatasource {
  Future<List<ArchiveModel>> getArchiveData();
}

class ArchiveRemoteDatasourceImpl extends ArchiveRemoteDatasource {
  final http.Client client;

  ArchiveRemoteDatasourceImpl({required this.client});

  @override
  Future<List<ArchiveModel>> getArchiveData() async {
    List<ArchiveModel> list = [];
    SharedPreferences sharedPreferences = di.get();
    try {
      final response = await client.get(
        Uri.parse(baseUrl +
            archivePHP +
            (sharedPreferences.getString(sharedSalesAgentId) ?? '')),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json'
          // "Authorization": "Bearer ${sharedPreferences.getString("token")}"
        },
      );
      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body);
        for (int i = 0; i < (parsed["data"] as List).length; i++) {
          list.add(ArchiveModel.fromJson(parsed["data"][i]));
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
