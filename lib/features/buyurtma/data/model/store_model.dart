import 'package:hive/hive.dart';

part 'store_model.g.dart';

@HiveType(typeId: 14)
class StoreModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;

  StoreModel({this.id, this.name});

  StoreModel.fromJson(Map<String, dynamic> json) {
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
