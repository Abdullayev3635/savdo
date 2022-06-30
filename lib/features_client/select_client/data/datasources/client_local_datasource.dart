import 'package:hive/hive.dart';
import 'package:savdo_agnet_client/core/utils/app_constants.dart';
import 'package:savdo_agnet_client/features/select_client/data/model/client_model.dart';

abstract class SelectClientLocalDataSource {
  Future<List<ClientModel>> getSelectClient();

  Future<bool> setSelectClient(List<ClientModel> list);
}

class SelectClientLocalDataSourceImpl implements SelectClientLocalDataSource {


  @override
  Future<List<ClientModel>> getSelectClient() async {
    try {
      final box = Hive.box(clientBox);
      final eventsFromHive = box.get(clientBox).cast<ClientModel>() ?? [];
      return eventsFromHive;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<bool> setSelectClient(List<ClientModel> list) async {
    try {
      final box = Hive.box(clientBox);
      box.put(clientBox, list);
      return true;
    } catch (e) {
      return false;
    }
  }
}
