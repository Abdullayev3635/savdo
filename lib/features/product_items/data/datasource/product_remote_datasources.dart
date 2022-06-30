import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:savdo_agnet_client/features/product/data/model/brand_product_model.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/api_path.dart';

abstract class BrandProductsRemoteDatasource {
  Future<List<BrandProductModel>> getBrandProducts(
      {required int salesAgentId,
      required int priceTypeId,
      required int page,
      required String name,
      required int? brandId});
}

class BrandProductsRemoteDatasourceImpl
    implements BrandProductsRemoteDatasource {
  final http.Client client;

  BrandProductsRemoteDatasourceImpl({
    required this.client,
  });

  @override
  Future<List<BrandProductModel>> getBrandProducts(
      {required int salesAgentId,
      required int priceTypeId,
      required int page,
      required String name,
      required int? brandId}) async {
    try {
      dynamic json = {
        "worker_id": 8,
        "page": page,
        // salesAgentId,
        "price_type_id": 1,
        "brand_id": brandId,
        "name": name
      };
      final response = await client.post(
        Uri.parse(baseUrl + allBrandProductsPHP),
        body: jsonEncode(json),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json'
          // "Authorization": "Bearer ${sharedPreferences.getString("token")}"
        },
      );
      if (response.statusCode == 200) {
        // log(response.body.toString());
        final parsed =   jsonDecode(response.body);
        List<BrandProductModel> list = [];
        if ((parsed["data"] as List).isNotEmpty) {
          for (int i = 0; i <= (parsed["data"] as List).length - 1; i++) {
            list.add(BrandProductModel.fromJson(parsed["data"][i]));
          }
          return list;
        } else {
          return [];
        }
      } else {
        return [];
      }
    } on InputFormatterFailure {
      return [];
    }
  }
}
//(parsed["data"] as List).length
