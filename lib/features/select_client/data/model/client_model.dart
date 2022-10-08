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
  @HiveField(4)
  String? phone1;
  @HiveField(5)
  String? coordinate;

  ClientModel({
    this.id,
    this.name,
    this.phone1,
    this.regionId,
    this.regionName,
    this.coordinate,
  });

  ClientModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name']??"";
    regionId = json['region_id']??"";
    regionName = json['region_name']??"";
    coordinate = json['coordinate']??"";
    phone1 = json['phone_1']??"";
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['phone_1'] = phone1;
    map['region_id'] = regionId;
    map['region_name'] = regionName;
    map['coordinate'] = coordinate;
    return map;
  }
}
