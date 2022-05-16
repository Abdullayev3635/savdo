import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:savdo_agnet_client/features/buyurtma/data/model/buyurtma_model.dart';
import 'package:http/http.dart' as http;
import 'package:savdo_agnet_client/features/buyurtma/data/model/currency_model.dart';
import 'package:savdo_agnet_client/features/buyurtma/data/model/price_type_model.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/api_path.dart';
import '../model/client_debit_credit.dart';

abstract class BuyurtmaRemoteDataSource {
  Future<dynamic> getBuyurtma();

  Future<dynamic> getClientDebitCredit(
      {required int customerId, required int salesAgentId});
}

class BuyurtmaRemoteDataSourceImpl implements BuyurtmaRemoteDataSource {
  final http.Client client;

  BuyurtmaRemoteDataSourceImpl({required this.client});

  @override
  Future<dynamic> getBuyurtma() async {

    List<CurrencyModel> currencyList = [];
    List<PriceTypeModel> priceTypeList = [];

    List<BuyurtmaModel> buyurtmaList = [];

    try {
      final response = await client.get(
        Uri.parse(baseUrl + savdoAndNarxPHP),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          // "Authorization": "Bearer ${sharedPreferences.getString("token")}"
        },
      );
      if (response.statusCode == 200) {
        try {
          final parsed = jsonDecode(response.body);
          log(response.body);
          for (int i = 0; i < (parsed["currency"] as List).length; i++) {
            currencyList.add(CurrencyModel.fromJson(parsed["currency"][i]));
          }
          for (int i = 0; i < (parsed["priceType"] as List).length; i++) {
            priceTypeList.add(PriceTypeModel.fromJson(parsed["priceType"][i]));
          }
          buyurtmaList.add(BuyurtmaModel(currency: currencyList, priceType: priceTypeList));

          return buyurtmaList;
        } catch (e) {
          debugPrint(e.toString());
        }
      } else {
        buyurtmaList = [];
      }

      return buyurtmaList;
    } on InputFormatterFailure {
      return [];
    }
  }

  @override
  Future<dynamic> getClientDebitCredit(
      {required int customerId, required int salesAgentId}) async {
    List<ClientDebitCreditModel> list = [];

    try {
      dynamic json = {
        "customer_id": customerId,
        "sales_agent_id": salesAgentId
      };
      final response = await client.post(
        Uri.parse(baseUrl + onSelectClientPHP),
        body: jsonEncode(json),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json'
        },
      );
      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body);
        for (int i = 0; i < (parsed as List).length; i++) {
          list.add(ClientDebitCreditModel.fromJson(parsed[i]));
        }
        log(list.toList().toString());
        return list;
      } else {
        return [];
      }
    } on InputFormatterFailure {
      return [];
    }
  }
}
