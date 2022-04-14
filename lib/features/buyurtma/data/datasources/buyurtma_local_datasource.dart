import 'dart:convert';

import 'package:savdo_agnet_client/core/errors/exceptions.dart';
import 'package:savdo_agnet_client/features/buyurtma/data/model/buyurtma_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class BuyurtmaLocalDataSource {
  Future<List<BuyurtmaModel>> getBuyurtma(int buyurtmaId);

  Future<void> ordersToCache(List<BuyurtmaModel> buyurtma);
}

const cachedOrdersList = 'cachedOrdersList';

class BuyurtmaLocalDataSourceImpl implements BuyurtmaLocalDataSource {
  final SharedPreferences sharedPreferences;

  BuyurtmaLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<BuyurtmaModel>> getBuyurtma(int buyurtmaId) async {
    final jsonOrderList = sharedPreferences.getStringList(cachedOrdersList);
    if (jsonOrderList!.isNotEmpty) {
      return Future.value(jsonOrderList
          .map((order) => BuyurtmaModel.fromJson(jsonDecode(order)))
          .toList());
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> ordersToCache(List<BuyurtmaModel> buyurtma) {
    final List<String> orderList =
        buyurtma.map((order) => jsonEncode(order.toJson())).toList();
    sharedPreferences.setStringList(cachedOrdersList, orderList);
    return Future.value(orderList);
  }
}
