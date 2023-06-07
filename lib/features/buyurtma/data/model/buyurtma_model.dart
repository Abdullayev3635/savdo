import 'package:savdo_agnet_client/features/buyurtma/data/model/branch_model.dart';
import 'package:savdo_agnet_client/features/buyurtma/data/model/currency_model.dart';
import 'package:savdo_agnet_client/features/buyurtma/data/model/price_type_model.dart';
import 'package:hive/hive.dart';
import 'package:savdo_agnet_client/features/buyurtma/data/model/store_model.dart';
part 'buyurtma_model.g.dart';

@HiveType(typeId: 7)
class BuyurtmaModel {
  @HiveField(0)
  List<CurrencyModel>? currency;
  @HiveField(1)
  List<PriceTypeModel>? priceType;
  @HiveField(2)
  List<StoreModel>? stores;
  @HiveField(3)
  List<BranchModel>? branchs;

  BuyurtmaModel({this.currency, this.priceType, this.stores,this.branchs});
}
