import 'package:savdo_agnet_client/features/buyurtma/data/model/buyurtma_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

abstract class BuyurtmaRemoteDataSource {
  Future<List<BuyurtmaModel>> getBuyurtma(int buyurtmaId);
}

class BuyurtmaRemoteDataSourceImpl implements BuyurtmaRemoteDataSource {
  final SharedPreferences sharedPreferences;
  final http.Client client;

  BuyurtmaRemoteDataSourceImpl({
    required this.sharedPreferences,
    required this.client,
  });

  @override
  Future<List<BuyurtmaModel>> getBuyurtma(int buyurtmaId) {
    return  buyurtmaId as Future<List<BuyurtmaModel>>;
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
