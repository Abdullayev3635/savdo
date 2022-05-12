import 'package:savdo_agnet_client/features/product/data/model/category_model.dart';


abstract class BrandProductsLocalDataSource {
  Future<dynamic> getCatalog();

  Future<bool> setCatalog(List<CategoryModel> list);
}

class BrandProductsLocalDataSourceImpl extends BrandProductsLocalDataSource {
  @override
  Future getCatalog() async {
    // try {
    // final box = Hive.box(categoryBox);
    // final eventsFromHive = box.get(categoryBox) ?? [];
    // return eventsFromHive;
    // } catch (e) {
    //   return [];
    // }
  }

  @override
  Future<bool> setCatalog(List<CategoryModel> list) async {
    return false;
    // try {
    //   final box = Hive.box(categoryBox);
    //   box.put(categoryBox, list);
    //   return true;
    // } catch (e) {
    //   return false;
    // }
  }
}
