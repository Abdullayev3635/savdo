import 'package:hive/hive.dart';
import 'package:savdo_agnet_client/core/utils/app_constants.dart';
import 'package:savdo_agnet_client/features/select_region/data/model/region_model.dart';

abstract class RegionLocalDataSource {
  Future<List<RegionModel>> getSelectRegion();

  Future<bool> setSelectRegion(List<RegionModel> list);
}

class RegionLocalDataSourceImpl implements RegionLocalDataSource {
  @override
  Future<List<RegionModel>> getSelectRegion() async {
    try {
      final box = Hive.box(regionBox);
      final eventsFromHive = box.get(regionBox).cast<RegionModel>() ?? [];
      return eventsFromHive;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<bool> setSelectRegion(List<RegionModel> list) async {
    try {
      final box = Hive.box(regionBox);
      box.put(regionBox, list);
      return true;
    } catch (e) {
      return false;
    }
  }
}
