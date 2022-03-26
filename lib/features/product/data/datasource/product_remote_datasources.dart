import 'dart:convert';

import 'package:savdo_agnet_client/features/product/data/model/category_model1.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/api_path.dart';

abstract class CatalogRemoteDatasource {
  Future<List<CatalogModel>> getCatalog();
}

class CatalogRemoteDatasourceImpl implements CatalogRemoteDatasource {
  final SharedPreferences sharedPreferences;
  final http.Client client;

  CatalogRemoteDatasourceImpl({
    required this.client,
    required this.sharedPreferences,
  });

  @override
  Future<List<CatalogModel>> getCatalog() async {
    List<CatalogModel> list = [];
    try {
      final response = await client.get(
        Uri.parse(baseUrl + categoriesPHP),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          "Authorization": "Bearer ${sharedPreferences.getString("token")}"
        },
      );
      if (response.statusCode == 200) {
        final parsed = json.decode(response.body);
        for (int i = 0; i < (parsed["data"] as List).length; i++) {
          list.add(CatalogModel.fromJson(parsed["data"][i]));
        }
        if (list.isNotEmpty) {
          list[0].isCheck = true;
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
