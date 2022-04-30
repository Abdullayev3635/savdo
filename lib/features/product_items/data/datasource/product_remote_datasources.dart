import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:savdo_agnet_client/features/product/data/model/brand_product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/api_path.dart';

abstract class BrandProductsRemoteDatasource {
  Future<List<BrandProductModel>> getBrandProducts(
      {required int salesAgentId,
      required int priceTypeId,
      required int brandId});
}

class BrandProductsRemoteDatasourceImpl implements BrandProductsRemoteDatasource {
  final SharedPreferences sharedPreferences;
  final http.Client client;

  BrandProductsRemoteDatasourceImpl({
    required this.client,
    required this.sharedPreferences,
  });

  @override
  Future<List<BrandProductModel>> getBrandProducts(
      {required int salesAgentId,
      required int priceTypeId,
      required int brandId}) async {
    List<BrandProductModel> list = [];
    try {
      dynamic json = {
        "sales_agent_id": salesAgentId,
        "price_type_id": priceTypeId,
        "brand_id": brandId
      };
      final response = await client.post(
        Uri.parse(baseUrl + brandProductsPHP),
        body: jsonEncode(json),
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
          list.add(BrandProductModel.fromJson(parsed["data"][i]));
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
