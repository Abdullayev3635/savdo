import 'package:hive/hive.dart';

part 'client_model.g.dart';

@HiveType(typeId: 6)
class ClientModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;

  ClientModel({
    this.id,
    this.name,
  });

  ClientModel.fromJson(dynamic json) {
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
