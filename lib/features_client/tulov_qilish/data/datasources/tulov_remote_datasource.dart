import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:savdo_agnet_client/features/tulov_qilish/data/model/tulov_client_debit_credit.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/api_path.dart';

abstract class TulovRemoteDataSource {
  Future<dynamic> getClientDebitCredit({
    required int customerId,
    required int salesAgentId,
  });

  Future<dynamic> getPayment(
      {required int customerId,
      required int salesAgentId,
      required int branchId,
      required int currencyValue,
      required int currencyId,
      required int paymentTypeId,
      required double summa,
      required double paymentAmount,
      required String description});
}

class TulovRemoteDataSourceImpl implements TulovRemoteDataSource {
  final http.Client client;

  TulovRemoteDataSourceImpl({required this.client});

  @override
  Future<dynamic> getClientDebitCredit(
      {required int customerId, required int salesAgentId}) async {
    List<TulovClientDebitCreditModel> list = [];

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
          list.add(TulovClientDebitCreditModel.fromJson(parsed[i]));
        }
        // log(list.toList().toString());
        return list;
      } else {
        return [];
      }
    } on InputFormatterFailure {
      return [];
    }
  }

  @override
  Future<dynamic> getPayment({
    required int customerId,
    required int salesAgentId,
    required int branchId,
    required int currencyValue,
    required int currencyId,
    required int paymentTypeId,
    required double summa,
    required double paymentAmount,
    required String description,
  }) async {
    try {
      dynamic json = {
        "sales_agent_id": salesAgentId,
        "customer_id": customerId,
        "branch_id": 1,
        "currency_value": currencyValue,
        "payment_type_id": paymentTypeId,
        "summa": summa,
        "payment_amount": paymentAmount,
        "description": description,
        "currency_id": currencyId,
      };
      final response = await client.post(
        Uri.parse(baseUrl + tulovQilishPHP),
        body: jsonEncode(json),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body);
        return parsed["message"];
      }
    } on InputFormatterFailure {
      return 'Xato';
    }
  }
}
