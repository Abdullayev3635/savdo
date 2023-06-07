import 'package:hive/hive.dart';
import 'package:savdo_agnet_client/core/utils/app_constants.dart';
import 'package:savdo_agnet_client/di/dependency_injection.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'korzina_hive.g.dart';

SharedPreferences sharedPreferences = di.get();

@HiveType(typeId: 1)
class KorzinaCard extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? category;
  @HiveField(3)
  int? currencyId;
  @HiveField(4)
  String? currencyName;
  @HiveField(5)
  num? price;
  @HiveField(6)
  num? residue;
  @HiveField(7)
  String? size;
  @HiveField(8)
  String? image;
  @HiveField(9)
  double? dona;
  @HiveField(10)
  double? bloklarSoni;
  @HiveField(11)
  int? blok;
  @HiveField(12)
  double? quantity;
  @HiveField(13)
  int? priceTypeId;
  @HiveField(14)
  num? incomePrice;
  @HiveField(15)
  int? incomePriceCurrencyId;
  @HiveField(16)
  DateTime? createdOn;

  KorzinaCard({
    required this.bloklarSoni,
    required this.blok,
    required this.residue,
    required this.price,
    required this.name,
    required this.dona,
    required this.quantity,
    required this.id,
    required this.category, //
    required this.size,
    required this.currencyId,
    required this.currencyName, //
    required this.image, //
    required this.priceTypeId, //
    required this.incomePrice, //
    required this.incomePriceCurrencyId, //
    required this.createdOn, //
  });

  KorzinaCard.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    quantity = json['quantity'];
    currencyId = json['currency_id'];
    price = json['price'];
    bloklarSoni = json['blok'];
    dona = json['piece'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = 0;
    data['product_id'] = id;
    data['currency_id'] = currencyId;
    data['quantity'] = quantity;
    data['price'] = price;
    data['quantity'] = dona;
    data['residue'] = residue;
    data['price_type_id'] = priceTypeId;
    data['income_price'] = incomePrice;
    data['income_price_currency_id'] = incomePriceCurrencyId;
    data['summa'] = quantity! * price!;
    data['blok'] = bloklarSoni;
    return data;
  }
}

//flutter packages pub run build_runner build
