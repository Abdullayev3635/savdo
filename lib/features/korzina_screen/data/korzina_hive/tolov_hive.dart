import 'package:hive/hive.dart';

part 'tolov_hive.g.dart';

@HiveType(typeId: 15)
class TolovHive extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? cash;
  @HiveField(2)
  int? paymentTypeId;
  @HiveField(3)
  int? currencyId;
  @HiveField(4)
  String? currencyValue;
  @HiveField(5)
  String? description;
  @HiveField(6)
  String? paymentTypeName;
  @HiveField(7)
  String? currencyName;
  TolovHive(
      {this.id,
        this.cash,
        this.paymentTypeId,
        this.currencyId,
        this.currencyValue,
        this.description,
        this.paymentTypeName,
        this.currencyName});

  TolovHive.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cash = json['cash'];
    paymentTypeId = json['payment_type_id'];
    currencyId = json['currency_id'];
    currencyValue = json['currency_value'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['summa'] = cash;
    data['payment_type_id'] = paymentTypeId;
    data['currency_id'] = currencyId;
    data['currency_value'] = currencyValue;
    data['description'] = description;
    return data;
  }
}