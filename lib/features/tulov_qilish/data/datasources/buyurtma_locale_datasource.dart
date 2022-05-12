import 'package:hive/hive.dart';
import 'package:savdo_agnet_client/core/utils/app_constants.dart';
import 'package:savdo_agnet_client/features/buyurtma/data/model/buyurtma_model.dart';
import 'package:savdo_agnet_client/features/buyurtma/data/model/currency_model.dart';
import 'package:savdo_agnet_client/features/buyurtma/data/model/price_type_model.dart';

abstract class BuyurtmaLocaleDatasource {
  Future<List<BuyurtmaModel>> getBuyurtma();

  Future<bool> setBuyurtma(List<BuyurtmaModel> list);

  Future<List<CurrencyModel>> getCurrency();

  Future<bool> setCurrency(List<CurrencyModel> list);

  Future<List<PriceTypeModel>> getPriceType();

  Future<bool> setPriceType(List<PriceTypeModel> list);
}

class BuyurtmaLocaleDatasourceImpl extends BuyurtmaLocaleDatasource {
  @override
  Future<List<BuyurtmaModel>> getBuyurtma() async {
    try {
      final box = Hive.box(buyurtmaBox);
      final eventsFromHive = box.get(buyurtmaBox)?.cast<BuyurtmaModel>() ?? [];
      return eventsFromHive;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<List<CurrencyModel>> getCurrency() async {
    try {
      final box = Hive.box(currencyBox);
      final eventsFromHive = box.get(currencyBox)?.cast<CurrencyModel>() ?? [];
      return eventsFromHive;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<List<PriceTypeModel>> getPriceType() async {
    try {
      final box = Hive.box(priceTypeBox);
      final eventsFromHive =
          box.get(priceTypeBox)?.cast<PriceTypeModel>() ?? [];
      return eventsFromHive;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<bool> setBuyurtma(List<BuyurtmaModel> list) async {
    try {
      final box = Hive.box(buyurtmaBox);
      await box.put(buyurtmaBox, list);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> setCurrency(List<CurrencyModel> list) async {
    try {
      final box = Hive.box(currencyBox);
      box.put(currencyBox, list);
      return true;
    } catch (e) {
      return false;
    }
  }


  @override
  Future<bool> setPriceType(List<PriceTypeModel> list) async {
    try {
      final box = Hive.box(priceTypeBox);
      box.put(priceTypeBox, list);
      return true;
    } catch (e) {
      return false;
    }
  }
}
