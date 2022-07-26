import 'package:hive/hive.dart';
import 'package:savdo_agnet_client/features/product/data/model/category_model.dart';
import 'package:savdo_agnet_client/features_client/product/data/model/brand_model.dart';
import 'package:savdo_agnet_client/features_client/product/data/model/brand_product_model.dart';
import 'package:savdo_agnet_client/features_client/product/data/model/category_model.dart';

import '../../../../core/utils/app_constants.dart';

abstract class ClientCatalogLocalDataSource {
  Future<List<ClientCategoryModel>> getClientCategory();

  Future<List<ClientBrandModel>> getClientBrand();

  Future<List<ClientBrandProductModel>> getClientBrandProducts();

  Future<bool> setClientCategory(List<ClientCategoryModel> list);

  Future<bool> setClientBrand(List<ClientBrandModel> list);

  Future<bool> setClientBrandProducts(List<ClientBrandProductModel> list);
}

class ClientCategoryLocalDataSourceImpl extends ClientCatalogLocalDataSource {
  @override
  Future<List<ClientCategoryModel>> getClientCategory() async {
    try {
      final box = Hive.box(categoryBox);
      final eventsFromHive = box.get(categoryBox)?.cast<CategoryModel>() ?? [];
      return eventsFromHive;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<bool> setClientCategory(List<ClientCategoryModel> list) async {
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
  Future<List<ClientBrandModel>> getClientBrand() async {
    try {
      final box = Hive.box(brandBox);
      final eventsFromHive = box.get(brandBox)?.cast<ClientBrandModel>() ?? [];
      return eventsFromHive;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<bool> setClientBrand(List<ClientBrandModel> list) async {
    try {
      final box = Hive.box(brandBox);
      box.put(brandBox, list);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<ClientBrandProductModel>> getClientBrandProducts() async {
    try {
      final box = Hive.box(brandProductsBox);
      final eventsFromHive =
          box.get(brandProductsBox).cast<ClientBrandProductModel>() ?? [];
      return eventsFromHive;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<bool> setClientBrandProducts(List<ClientBrandProductModel> list) async {
    try {
      final box = Hive.box(brandProductsBox);
      box.put(brandProductsBox, list);
      return true;
    } catch (e) {
      return false;
    }
  }
}
