import 'package:hive/hive.dart';

part 'price_type_model.g.dart';

@HiveType(typeId: 9)
class PriceTypeModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;

  PriceTypeModel({this.id, this.name});

  PriceTypeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
