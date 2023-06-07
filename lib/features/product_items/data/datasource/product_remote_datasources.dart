import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:savdo_agnet_client/features/product/data/model/brand_product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/api_path.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../buyurtma/data/model/price_model.dart';
import '../../../product/data/model/product_model_new.dart';

abstract class BrandProductsRemoteDatasource {
  Future<List<BrandProductModel>> getBrandProducts(
      {required int salesAgentId,
      required int priceTypeId,
      required int page,
      required String name,
      required int? brandId});

  Future<List<ProductsNew>> getAllProducts(
      {required int salesAgentId,
      required int priceTypeId,
      required int page,
      required String name,
      required int? brandId});

  Future<bool> sendChangedProduct({required ProductsNew json});
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
    int storeIdId =
        int.parse(sharedPreferences.getString(sharedStoreId) ?? "0");
    // int currencyId = int.parse(sharedPreferences.getString(sharedCurrencyId)??"0");
    int workerId =
        int.parse(sharedPreferences.getString(sharedSalesAgentId) ?? "0");
    try {
      dynamic json = {
        "worker_id": workerId,
        "page": page,
        "price_type_id": priceTypeId,
        "brand_id": brandId,
        "name": name,
        "store_id": storeIdId
      };
      final response = await client.post(
        Uri.parse(baseUrl + allBrandProductsPHP),
        body: jsonEncode(json),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          "Authorization": "Bearer ${sharedPreferences.getString("token")}"
        },
      );
      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body);
        List<BrandProductModel> list = [];
        if ((parsed["data"] as List).isNotEmpty) {
          for (int i = 0; i <= (parsed["data"] as List).length - 1; i++) {
            if (parsed["data"][i] != null && parsed["data"][i] != "") {
              if ((num.tryParse(parsed["data"][i]["residue"].toString()) ?? 0) >
                  0) {
                list.add(BrandProductModel.fromJson(parsed["data"][i]));
              }
            }
          }
          sharedPreferences.setString(
              lastPage, parsed["meta"]["last_page"].toString());
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

  @override
  Future<List<ProductsNew>> getAllProducts(
      {required int salesAgentId,
      required int priceTypeId,
      required int page,
      required String name,
      required int? brandId}) async {
    try {
      final response = await client.get(
        Uri.parse(baseUrl + allProductPHP),
        //body: jsonEncode(json),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          "Authorization": "Bearer ${sharedPreferences.getString("token")}"
        },
      );
      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body);
        print(parsed);
        List<ProductsNew> list = [];
        if ((parsed["data"] as List).isNotEmpty) {
          for (int i = 0; i <= (parsed["data"] as List).length - 1; i++) {
            if (parsed["data"][i] != null && parsed["data"][i] != "") {
              try {
                list.add(ProductsNew.fromJson(parsed["data"][i]));
              } on Exception {}
            }
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

  @override
  Future<bool> sendChangedProduct({required ProductsNew json}) async {
    try {
      final response = await client.put(
        Uri.parse(baseUrlWeb + restore.replaceAll("8", json.id.toString())),
        body: jsonEncode(json.toJson()),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          "Authorization": "Bearer ${sharedPreferences.getString("token")}"
        },
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on InputFormatterFailure {
      return false;
    }
  }
}
//(parsed["data"] as List).length
