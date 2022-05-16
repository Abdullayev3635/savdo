import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:savdo_agnet_client/features/foto_xisobot/data/model/foto_model.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/api_path.dart';

abstract class FotoRemoteDataSource {
  Future<dynamic> sendFoto();
}

class FotoRemoteDataSourceImpl implements FotoRemoteDataSource {
  final http.Client client;

  FotoRemoteDataSourceImpl({required this.client});

  @override
  Future<dynamic> sendFoto() async {
    List<FotoModel> list = [];

    try {
      dynamic json = {
        "customer_id": 1,
        "sales_agent_id": 1
      };
      final response = await client.post(
        Uri.parse(baseUrl + photoPHP),
        body: jsonEncode(json),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json'
        },
      );
      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body);
        for (int i = 0; i < (parsed as List).length; i++) {
          list.add(FotoModel.fromJson(parsed[i]));
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
