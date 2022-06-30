import 'package:hive/hive.dart';
import 'package:savdo_agnet_client/core/utils/app_constants.dart';
import 'package:savdo_agnet_client/di/dependency_injection.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'client_korzina_hive.g.dart';

SharedPreferences sharedPreferences = di.get();

@HiveType(typeId: 1)
class ClientKorzinaCard extends HiveObject {
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
  int? residue;
  @HiveField(7)
  String? size;
  @HiveField(8)
  String? image;
  @HiveField(9)
  int? dona;
  @HiveField(10)
  int? bloklarSoni;
  @HiveField(11)
  int? blok;
  @HiveField(12)
  int? quantity;

  ClientKorzinaCard({
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
  });

  ClientKorzinaCard.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    quantity = json['quantity'];
    currencyId = json['currency_id'];
    price = json['price'];
    bloklarSoni = json['blok'];
    dona = json['piece'];
    sharedPreferences.setString(sharedSalesAgentId, json['sales_agent_id']);
    sharedPreferences.setString(sharedCustomerId, json['customer_id']);
    sharedPreferences.setString(sharedCurrencyValue, json['currency_value']);
    sharedPreferences.setString(sharedPriceTypeId, json['price_type_id']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = id;
    data['quantity'] = quantity;
    data['price'] = price;
    data['piece'] = dona;
    data['blok'] = bloklarSoni;
    data['currency_id'] = currencyId;
    return data;
  }
}

//flutter packages pub run build_runner build
