import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:savdo_agnet_client/features/product/data/model/brand_product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/api_path.dart';
import '../../../../core/utils/app_constants.dart';

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
  final SharedPreferences sharedPreferences;

  BrandProductsRemoteDatasourceImpl({
    required this.client,
    required this.sharedPreferences,
  });

  @override
  Future<List<BrandProductModel>> getBrandProducts(
      {required int salesAgentId,
      required int priceTypeId,
      required int page,
      required String name,
      required int? brandId}) async {
    int storeIdId = int.parse(sharedPreferences.getString(sharedStoreId)??"0");
    int currencyId = int.parse(sharedPreferences.getString(sharedCurrencyId)??"0");
    try {
      dynamic json = {
        "worker_id": 1,
        "page": page,
        "price_type_id": priceTypeId,
        "brand_id": brandId,
        "name": name,
        "currency_id":currencyId,
        "store_id":storeIdId
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
