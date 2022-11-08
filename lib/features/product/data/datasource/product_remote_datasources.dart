import 'dart:convert';

import 'package:savdo_agnet_client/features/product/data/model/brand_model.dart';
import 'package:savdo_agnet_client/features/product/data/model/brand_product_model.dart';
import 'package:savdo_agnet_client/features/product/data/model/category_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/api_path.dart';
import '../../../../core/utils/app_constants.dart';

abstract class CategoryRemoteDatasource {
  Future<List<CategoryModel>> getCategory();

  Future<List<BrandModel>> getBrand(
      {required int productTypeId, required int priceTypeId});

  Future<List<BrandProductModel>> getBrandProducts(
      {required int salesAgentId,
      required int priceTypeId,
      required int brandId,
      required int currency_id});
}

  class CategoryRemoteDatasourceImpl implements CategoryRemoteDatasource {
  final http.Client client;
  final SharedPreferences sharedPreferences;

  CategoryRemoteDatasourceImpl({required this.client,required this.sharedPreferences});

  @override
  Future<List<CategoryModel>> getCategory() async {
    List<CategoryModel> list = [];
    int storeIdId = int.parse(sharedPreferences.getString(sharedStoreId)??"0");
    dynamic json = {
      "store_id":storeIdId,
    };
    try {
      final response = await client.post(
        Uri.parse(baseUrl + catalogPHP),
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
          list.add(CategoryModel.fromJson(parsed["data"][i]));
        }
        return list;
      } else {
        return [];
      }
    } on InputFormatterFailure {
      return [];
    }
  }

  @override
  Future<List<BrandModel>> getBrand(
      {required int productTypeId, required int priceTypeId}) async {
    List<BrandModel> list = [];
    int storeIdId = int.parse(sharedPreferences.getString(sharedStoreId)??"0");
    int currencyId = int.parse(sharedPreferences.getString(sharedCurrencyId)??"0");

    try {
      dynamic json = {
        "product_type_id": productTypeId,
        "price_type_id": priceTypeId,
        "currency_id": currencyId,
        "store_id":storeIdId
      };
      final response = await client.post(
        Uri.parse(baseUrl + brandPHP),
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
          list.add(BrandModel.fromJson(parsed["data"][i]));
        }
        return list;
      } else {
        return [];
      }
    } on InputFormatterFailure {
      return [];
    }
  }

  @override
  Future<List<BrandProductModel>> getBrandProducts(
      {required int salesAgentId,
      required int priceTypeId,
      required int brandId,
      required int currency_id}) async {
    List<BrandProductModel> list = [];
    int storeIdId = int.parse(sharedPreferences.getString(sharedStoreId)??"0");
    try {
      dynamic json = {
        "sales_agent_id": salesAgentId,
        "price_type_id": priceTypeId,
        "brand_id": brandId,
        "currency_id": brandId,
        "store_id": storeIdId,

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
        for (int i = 0; i < (parsed['data'] as List).length; i++) {
          list.add(BrandProductModel.fromJson(parsed['data'][i]));
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
