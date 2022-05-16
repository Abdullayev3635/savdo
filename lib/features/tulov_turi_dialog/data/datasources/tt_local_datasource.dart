import 'package:hive/hive.dart';
import 'package:savdo_agnet_client/core/utils/app_constants.dart';
import 'package:savdo_agnet_client/features/tulov_turi_dialog/data/model/tulov_turi_model.dart';

abstract class SelectTulovTuriLocalDataSource {
  Future<List<TulovTuriModel>> getSelectTulovTuri();

  Future<bool> setSelectTulovTuri(List<TulovTuriModel> list);
}

class SelectTulovTuriLocalDataSourceImpl implements SelectTulovTuriLocalDataSource {


  @override
  Future<List<TulovTuriModel>> getSelectTulovTuri() async {
    try {
      final box = Hive.box(tulovTuriBox);
      final eventsFromHive = box.get(tulovTuriBox).cast<TulovTuriModel>() ?? [];
      return eventsFromHive;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<bool> setSelectTulovTuri(List<TulovTuriModel> list) async {
    try {
      final box = Hive.box(tulovTuriBox);
      box.put(tulovTuriBox, list);
      return true;
    } catch (e) {
      return false;
    }
  }

}
