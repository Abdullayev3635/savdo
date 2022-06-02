import 'dart:convert';

import 'package:savdo_agnet_client/core/errors/failures.dart';
import 'package:savdo_agnet_client/features/korzina_screen/data/korzina_hive/error_model.dart';

import '../../../../core/utils/api_path.dart';
import '../../../../core/utils/app_constants.dart';
import '../korzina_hive/korzina_hive.dart';
import 'package:http/http.dart' as http;

abstract class KorzinaOrderRemoteDatasource {
  Future<dynamic> sendKorzinaData({required List<KorzinaCard> card});
}

class KorzinaOrderRemoteDatasourceImpl extends KorzinaOrderRemoteDatasource {
  final http.Client client;

  KorzinaOrderRemoteDatasourceImpl({required this.client});

  @override
  Future<List<ErrorModel>> sendKorzinaData(
      {required List<KorzinaCard> card}) async {
    try {
      List<ErrorModel> listError = [];
      var jsonList = jsonEncode(card.map((e) => e.toJson()).toList());
      dynamic json1 = {
        'sales_agent_id':
            int.parse(sharedPreferences.getString(sharedSalesAgentId)!),
        'customer_id': 1,
        'currency_id':
            int.parse(sharedPreferences.getString(sharedCurrencyId)!),
        'currency_value':
            int.parse(sharedPreferences.getString(sharedCurrencyValue)!),
        'price_type_id':
            int.parse(sharedPreferences.getString(sharedPriceTypeId)!),
        'description': "hkljhjljhlkjhklj"
      };
      dynamic json = {
        'order_info': json1,
        'product_list': jsonDecode(jsonList),
      };
      final response = await client.post(
        Uri.parse(baseUrl + orderPHP),
        body: jsonEncode(json),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json'
          // "Authorization": "Bearer ${sharedPreferences.getString("token")}"
        },
      );
      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body);
        for (int i = 0; i < (parsed["error_list"] as List).length; i++) {
          listError.add(ErrorModel.fromJson(parsed["error_list"][i]));
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
