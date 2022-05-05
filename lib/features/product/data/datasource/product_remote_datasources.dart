import 'dart:convert';

import 'package:savdo_agnet_client/features/product/data/model/brand_model.dart';
import 'package:savdo_agnet_client/features/product/data/model/brand_product_model.dart';
import 'package:savdo_agnet_client/features/product/data/model/category_model.dart';
import 'package:http/http.dart' as http;

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/api_path.dart';

abstract class CategoryRemoteDatasource {
  Future<List<CategoryModel>> getCategory();

  Future<List<BrandModel>> getBrand(
      {required int productTypeId, required int priceTypeId});

  Future<List<BrandProductModel>> getBrandProducts(
      {required int salesAgentId,required int priceTypeId,required int brandId});
}

class CategoryRemoteDatasourceImpl implements CategoryRemoteDatasource {
  final http.Client client;

  CategoryRemoteDatasourceImpl({
    required this.client,
  });

  @override
  Future<List<CategoryModel>> getCategory() async {
    List<CategoryModel> list = [];
    try {
      final response = await client.get(
        Uri.parse(baseUrl + catalogPHP),
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
      try {
        dynamic json = {
          "product_type_id": productTypeId,
          "price_type_id": priceTypeId
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
      {required int salesAgentId, required int priceTypeId, required int brandId}) async {
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
