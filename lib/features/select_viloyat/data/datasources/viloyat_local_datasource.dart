import 'package:hive/hive.dart';
import 'package:savdo_agnet_client/core/utils/app_constants.dart';
import 'package:savdo_agnet_client/features/select_viloyat/data/model/viloyat_model.dart';

abstract class ViloyatLocalDataSource {
  Future<List<ViloyatModel>> getSelectViloyat();

  Future<bool> setSelectViloyat(List<ViloyatModel> list);
}

class ViloyatLocalDataSourceImpl implements ViloyatLocalDataSource {

  @override
  Future<List<ViloyatModel>> getSelectViloyat() async {
    try {
      final box = Hive.box(viloyatBox);
      final eventsFromHive = box.get(viloyatBox).cast<ViloyatModel>() ?? [];
      return eventsFromHive;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<bool> setSelectViloyat(List<ViloyatModel> list) async {
    try {
      final box = Hive.box(viloyatBox);
      box.put(viloyatBox, list);
      return true;
    } catch (e) {
      return false;
    }
  }

// @override
// Future<dynamic> getCategory() async {
//   try {
//     final shared = sharedPreferences.get('select_client');
//   }
// }
}
