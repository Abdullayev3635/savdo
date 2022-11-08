import 'dart:convert';

import 'package:savdo_agnet_client/core/errors/failures.dart';
import 'package:savdo_agnet_client/features/korzina_screen/data/korzina_hive/error_model.dart';

import '../../../../core/utils/api_path.dart';
import '../../../../core/utils/app_constants.dart';
import '../korzina_hive/korzina_hive.dart';
import 'package:http/http.dart' as http;

abstract class KorzinaOrderRemoteDatasource {
  Future<dynamic> sendKorzinaData({required List<KorzinaCard> card, required dynamic paymentJson});
}

class KorzinaOrderRemoteDatasourceImpl extends KorzinaOrderRemoteDatasource {
  final http.Client client;

  KorzinaOrderRemoteDatasourceImpl({required this.client});

  @override
  Future<List<ErrorModel>> sendKorzinaData(
      {required List<KorzinaCard> card, required dynamic paymentJson}) async {
    try {
      List<ErrorModel> listError = [];
      var jsonList = jsonEncode(card.map((e) => e.toJson()).toList());
      dynamic json1 = {
        'group_id': 0,
        'branch_id':
            int.parse(sharedPreferences.getString(sharedBranchId) ?? "0"),
        'currency_id':
            int.parse(sharedPreferences.getString(sharedCurrencyId) ?? "0"),
        'currency_rate':
            int.parse(sharedPreferences.getString(sharedCurrencyValue) ?? "0"),
        'customer_id':
            int.parse(sharedPreferences.getString(sharedCustomerId) ?? "0"),
        'description': "",
        'price_type_id':
            int.parse(sharedPreferences.getString(sharedPriceTypeId) ?? "2"),
        'sales_agent_id':
            int.parse(sharedPreferences.getString(sharedSalesAgentId) ?? "0"),
        'store_id':
            int.parse(sharedPreferences.getString(sharedStoreId) ?? "0"),
        "supplier_id": 1,
        "doc_time": "2022-11-02 22:35:08",
      };
      dynamic json2 = {
        'responsible_worker_id':
            int.parse(sharedPreferences.getString(sharedSalesAgentId) ?? "0"),
        'operation_type': 1,
        'currency_id':
            int.parse(sharedPreferences.getString(sharedCurrencyId) ?? "0"),
        'currency_rate':
            int.parse(sharedPreferences.getString(sharedCurrencyValue) ?? "0"),
        'price_type_id':
            int.parse(sharedPreferences.getString(sharedPriceTypeId) ?? "2"),
        'cashback_customer_id': 1,
        'cashback_summa': 0,
      };

      dynamic json = {
        'info': json1,
        'list': jsonDecode(jsonList),
        'others': json2,
        'payment': paymentJson,
      };
      print(json.toString());
      final response = await client.post(
        Uri.parse(baseUrl + chakanaOrderPHP),
        body: jsonEncode(json),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json'
          // "Authorization": "Bearer ${sharedPreferences.getString("token")}"
        },
      );
      if (response.statusCode == 200) {
        return [];
      } else {
        return [];
      }
    } on InputFormatterFailure {
      return [];
    }
  }
}
