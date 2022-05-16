import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:savdo_agnet_client/features/tulov_qilish/data/model/tulov_client_debit_credit.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/api_path.dart';

abstract class TulovRemoteDataSource {
  Future<dynamic> getClientDebitCredit(
      {required int customerId, required int salesAgentId});
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
