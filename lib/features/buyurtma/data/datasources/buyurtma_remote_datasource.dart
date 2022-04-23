import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:savdo_agnet_client/features/buyurtma/data/model/buyurtma_model.dart';
import 'package:savdo_agnet_client/features/buyurtma/data/model/narx_turi_model.dart';
import 'package:savdo_agnet_client/features/buyurtma/data/model/savdo_turi_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/api_path.dart';

abstract class BuyurtmaRemoteDataSource {
  Future<BuyurtmaModel> getBuyurtma();
}

class BuyurtmaRemoteDataSourceImpl implements BuyurtmaRemoteDataSource {
  final SharedPreferences sharedPreferences;
  final http.Client client;

  BuyurtmaRemoteDataSourceImpl(
      {required this.sharedPreferences, required this.client});

  @override
  Future<BuyurtmaModel> getBuyurtma() async {
    List<NarxTuriModel> listPrice = [];
    List<SavdoTuriModel> listSavdo = [];

    try {
      final response = await client.get(
        Uri.parse(baseUrl + narxTuriPHP),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          // "Authorization": "Bearer ${sharedPreferences.getString("token")}"
        },
      );
      if (response.statusCode == 200) {
        try {
          final parsed = json.decode(response.body);
          for (int i = 0; i < (parsed["data"] as List).length; i++) {
            listPrice.add(NarxTuriModel.fromJson(parsed["data"][i]));
          }
        } catch (e) {
          debugPrint(e.toString());
        }
      } else {
        listPrice = [];
      }

      final response2 = await client.get(
        Uri.parse(baseUrl + narxTuriPHP),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          // "Authorization": "Bearer ${sharedPreferences.getString("token")}"
        },
      );
      if (response2.statusCode == 200) {
        try {
          final parsed = json.decode(response2.body);
          for (int i = 0; i < (parsed["data"] as List).length; i++) {
            listSavdo.add(SavdoTuriModel.fromJson(parsed["data"][i]));
          }
        } catch (e) {
          debugPrint(e.toString());
        }
      } else {
        listSavdo = [];
      }

      return BuyurtmaModel(narxTuri: listPrice, savdoTuri: listSavdo);
    } on InputFormatterFailure {
      return BuyurtmaModel(narxTuri: [], savdoTuri: []);
    }
  }
}
