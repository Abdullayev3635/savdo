import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:savdo_agnet_client/core/errors/failures.dart';
import 'package:savdo_agnet_client/core/utils/api_path.dart';
import 'package:savdo_agnet_client/features/select_viloyat/data/model/viloyat_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ViloyatRemoteDataSource {
  Future<List<ViloyatModel>> getViloyat();

}

class ViloyatRemoteDataSourceImpl implements ViloyatRemoteDataSource {
  final SharedPreferences sharedPreferences;
  final http.Client client;

  ViloyatRemoteDataSourceImpl(
      {required this.sharedPreferences, required this.client});

  @override
  Future<List<ViloyatModel>> getViloyat() async {
    List<ViloyatModel> list = [];
    try {
      final response = await client.get(
        Uri.parse(baseUrl + statesPHP),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json'
          // "Authorization": "Bearer ${sharedPreferences.getString("token")}"
        },
      );
      if (response.statusCode == 200) {
        // log(response.body.toString());
        final parsed = jsonDecode(response.body);
        for (int i = 0; i < (parsed["data"] as List).length; i++) {
          list.add(ViloyatModel.fromJson(parsed["data"][i]));
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
