import 'package:http/http.dart' as http;
import 'package:savdo_agnet_client/features/select_client/data/model/agent_model.dart';
import 'package:savdo_agnet_client/features/select_client/data/model/client_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SelectClientRemoteDataSource {
  Future<List<ClientModel>> getSelectClient(int clientId);

  Future<List<AgentModel>> getSelectAgent(String agentId);
}

class SelectClientRemoteDataSourceImpl implements SelectClientRemoteDataSource {
  final SharedPreferences sharedPreferences;
  final http.Client client;

  SelectClientRemoteDataSourceImpl(
      {required this.sharedPreferences, required this.client});

  @override
  Future<List<AgentModel>> getSelectAgent(String agentId) {
    // TODO: implement getSelectAgent
    throw UnimplementedError();
  }

  @override
  Future<List<ClientModel>> getSelectClient(int clientId) {
    // TODO: implement getSelectClient
    throw UnimplementedError();
  }

// @override
// Future<List<ClientModel>> getClient() async {
//   List<ClientModel> list = [];
//   try {
//     return true;
//   } on LocalFailure {
//     return false;
//   }
// }
}
