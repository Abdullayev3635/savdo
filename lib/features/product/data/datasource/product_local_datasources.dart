import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:savdo_agnet_client/features/product/data/model/brand_model.dart';
import 'package:savdo_agnet_client/features/product/data/model/brand_product_model.dart';
import 'package:savdo_agnet_client/features/product/data/model/category_model.dart';

import '../../../../core/utils/app_constants.dart';

abstract class CatalogLocalDataSource {
  Future<List<CategoryModel>> getCategory();

  Future<List<BrandModel>> getBrand();

  Future<List<BrandProductModel>> getBrandProducts();

  Future<bool> setCategory(List<CategoryModel> list);

  Future<bool> setBrand(List<BrandModel> list);

  Future<bool> setBrandProducts(List<BrandProductModel> list);
}

class CategoryLocalDataSourceImpl extends CatalogLocalDataSource {
  @override
  Future<List<CategoryModel>> getCategory() async {
    try {
      final box = Hive.box(categoryBox);
      final eventsFromHive = box.get(categoryBox)?.cast<CategoryModel>() ?? [];
      return eventsFromHive;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<bool> setCategory(List<CategoryModel> list) async {
    try {
      final box = Hive.box(categoryBox);
      box.put(categoryBox, list);
    //  log(box.get(categoryBox));
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<BrandModel>> getBrand() async {
    try {
      final box = Hive.box(brandBox);
      final eventsFromHive = box.get(brandBox)?.cast<BrandModel>() ?? [];
      return eventsFromHive;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<bool> setBrand(List<BrandModel> list) async {
    try {
      final box = Hive.box(brandBox);
      box.put(brandBox, list);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<BrandProductModel>> getBrandProducts() async {
    try {
      final box = Hive.box(brandProductsBox);
      final eventsFromHive =
          box.get(brandProductsBox).cast<BrandProductModel>() ?? [];
      return eventsFromHive;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<bool> setBrandProducts(List<BrandProductModel> list) async {
    try {
      final box = Hive.box(brandProductsBox);
      box.put(brandProductsBox, list);
      return true;
    } catch (e) {
      return false;
    }
  }
}
