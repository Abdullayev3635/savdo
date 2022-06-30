import 'package:hive/hive.dart';

part 'brand_model.g.dart';

@HiveType(typeId: 13)
class ClientBrandModel extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  int? count;

  ClientBrandModel({
    this.id,
    this.name,
    this.count,
  });
  ClientBrandModel.fromJson(Map<String, dynamic> json) {
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
