import 'dart:convert';

import 'package:savdo_agnet_client/core/errors/failures.dart';
import 'package:savdo_agnet_client/features/archive_details/data/model/archive_details_model.dart';

import '../../../../core/utils/api_path.dart';
import 'package:http/http.dart' as http;

abstract class ArchiveDetailsRemoteDatasource {
  Future<dynamic> getDetails({required int? orderId});
}

class ArchiveDetailsRemoteDatasourceImpl
    extends ArchiveDetailsRemoteDatasource {
  final http.Client client;

  ArchiveDetailsRemoteDatasourceImpl({required this.client});

  @override
  Future<List<ArchiveDetailsModel>> getDetails({required int? orderId}) async {
    try {
      List<ArchiveDetailsModel> list = [];

      dynamic json = {
        'order_id': orderId,
      };
      final response = await client.post(
        Uri.parse(baseUrl + archiveDetailsPHP),
        body: jsonEncode(json),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json'
          // "Authorization": "Bearer ${sharedPreferences.getString("token")}"
        },
      );
      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body);
        for (int i = 0; i < (parsed["data"] as List).length; i++) {
          list.add(ArchiveDetailsModel.fromJson(parsed["data"][i]));
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
