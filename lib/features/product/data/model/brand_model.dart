import 'package:hive/hive.dart';

part 'brand_model.g.dart';

@HiveType(typeId: 2)
class BrandModel extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  int? count;

  BrandModel({
    this.id,
    this.name,
    this.count,
  });
  BrandModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['count'] = count;
    return data;
  }
}
