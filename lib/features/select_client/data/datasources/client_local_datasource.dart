import 'package:hive/hive.dart';
import 'package:savdo_agnet_client/core/utils/app_constants.dart';
import 'package:savdo_agnet_client/features/select_client/data/model/agent_model.dart';
import 'package:savdo_agnet_client/features/select_client/data/model/client_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SelectClientLocalDataSource {
  Future<dynamic> getSelectClient(int userId);

  Future<dynamic> getSelectAgent(String agentId);
}

class SelectClientLocalDataSourceImpl implements SelectClientLocalDataSource {
  final SharedPreferences sharedPreferences;

  SelectClientLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<dynamic> getSelectAgent(String? agentId) async {
    try {
      final box = Hive.box(clientBox);
      final eventsFromHive = box.get(clientBox)?.cast<ClientModel>() ?? [];
      return eventsFromHive;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<dynamic> getSelectClient(int? userId) async {
    try {
      final box = Hive.box(agentBox);
      final eventsFromHive = box.get(agentBox).cast<AgentModel>() ?? [];
      return eventsFromHive;
    } catch (e) {
      return [];
    }
  }

// @override
// Future<dynamic> getCategory() async {
//   try {
//     final shared = sharedPreferences.get('select_client');
//   }
// }
}
