import 'package:hive/hive.dart';

part 'region_model.g.dart';

@HiveType(typeId: 12)
class RegionModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;

  RegionModel({
    this.id,
    this.name,
  });

  RegionModel.fromJson(dynamic json) {
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
