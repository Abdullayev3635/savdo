import 'package:hive/hive.dart';

part 'client_model.g.dart';

@HiveType(typeId: 6)
class ClientModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  int? regionId;
  @HiveField(3)
  String? regionName;

  ClientModel({
    this.id,
    this.name,
    this.regionId,
    this.regionName,
  });

  ClientModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    regionId = json['region_id'];
    regionName = json['region_name'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['region_id'] = regionId;
    map['region_name'] = regionName;
    return map;
  }
}
