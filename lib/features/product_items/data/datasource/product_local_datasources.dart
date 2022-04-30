import 'package:hive/hive.dart';
import 'package:savdo_agnet_client/features/product/data/model/category_model.dart';

import '../../../../core/utils/app_constants.dart';

abstract class BrandProductsLocalDataSource {
  Future<dynamic> getCatalog();

  Future<bool> setCatalog(List<CatalogModel> list);
}

class BrandProductsLocalDataSourceImpl extends BrandProductsLocalDataSource {
  @override
  Future getCatalog() async {
    try {
      final box = Hive.box(catalogBox);
      final eventsFromHive = box.get(catalogBox)?.cast<CatalogModel>() ?? [];
      return eventsFromHive;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<bool> setCatalog(List<CatalogModel> list) async {
    try {
      final box = Hive.box(catalogBox);
      box.put(catalogBox, list);
      return true;
    } catch (e) {
      return false;
    }
  }
}
