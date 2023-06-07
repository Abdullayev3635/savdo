import 'package:hive/hive.dart';

part 'viloyat_model.g.dart';

@HiveType(typeId: 11)
class ViloyatModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;

  ViloyatModel({
    this.id,
    this.name,
  });

  ViloyatModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }
}
