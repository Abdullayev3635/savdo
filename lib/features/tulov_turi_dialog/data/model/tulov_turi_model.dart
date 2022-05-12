import 'package:hive/hive.dart';

part 'tulov_turi_model.g.dart';

@HiveType(typeId: 10)
class TulovTuriModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? createdAt;
  @HiveField(3)
  String? updatedAt;

  TulovTuriModel({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  TulovTuriModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}
