import 'package:savdo_agnet_client/features/buyurtma/data/model/currency_model.dart';
import 'package:savdo_agnet_client/features/buyurtma/data/model/price_type_model.dart';
import 'package:hive/hive.dart';

part 'buyurtma_model.g.dart';

@HiveType(typeId: 7)
class BuyurtmaModel {
  @HiveField(0)
  List<CurrencyModel>? currency;
  @HiveField(1)
  List<PriceTypeModel>? priceType;

  BuyurtmaModel({this.currency, this.priceType});
}
