import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';
import 'package:savdo_agnet_client/di/dependency_injection.dart';
import 'package:savdo_agnet_client/features/korzina_screen/data/korzina_hive/error_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/utils/api_path.dart';
import '../../../../core/utils/app_constants.dart';
import '../korzina_hive/korzina_hive.dart';
import 'package:http/http.dart' as http;

import '../korzina_hive/tolov_hive.dart';

abstract class KorzinaOrderRemoteDatasource {
  Future<dynamic> sendKorzinaData(
      {required List<KorzinaCard> card, required List<TolovHive> paymentJson});
}

class KorzinaOrderRemoteDatasourceImpl extends KorzinaOrderRemoteDatasource {
  final http.Client client;

  KorzinaOrderRemoteDatasourceImpl({required this.client});

  @override
  Future<List<ErrorModel>> sendKorzinaData(
      {required List<KorzinaCard> card,
      required List<TolovHive> paymentJson}) async {
    try {
      List<ErrorModel> listError = [];

      var jsonProduct = jsonEncode(card.map((e) => e.toJson()).toList());
      var jsonPayment = jsonEncode(paymentJson.map((e) => e.toJson()).toList());
      dynamic json1 = {
        "doc_time": DateTime.now().toString(),
        'branch_id':
            int.parse(sharedPreferences.getString(sharedBranchId) ?? "0"),
        "suplier_id":
            int.parse(sharedPreferences.getString(sharedSalesAgentId) ?? "0"),
        "group_id": 0,
        'comment': "",
        'description': "",
        'from_shop': 'true',
        'store_id':
            int.parse(sharedPreferences.getString(sharedStoreId) ?? "0"),
        'sales_agent_id': "2",
        'customer_id':
            int.parse(sharedPreferences.getString(sharedCustomerId) ?? "0"),
        'region_id': 0,
        'dt_kt_data': [],
        'currency_id':
            int.parse(sharedPreferences.getString(sharedCurrencyId) ?? "0"),
        'currency_value':
            int.parse(sharedPreferences.getString(sharedCurrencyValue) ?? "0"),
        'price_type_id':
            int.parse(sharedPreferences.getString(sharedPriceTypeId) ?? "2"),
      };

      dynamic json = {
        'info': json1,
        'list': jsonDecode(jsonProduct),
        'payment': jsonDecode(jsonPayment),
        'discount': [],
      };

      print(json.toString());
      final response = await client.post(
        Uri.parse(baseUrl + wholeOrderPHP),
        body: jsonEncode(json),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          "Authorization": "Bearer ${sharedPreferences.getString("token")}"
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
