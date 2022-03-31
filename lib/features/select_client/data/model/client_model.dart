
import 'package:hive/hive.dart';

part 'client_model.g.dart';

@HiveType(typeId: 3)
class ClientModel extends HiveObject{
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;

  ClientModel({
    this.id,
    this.name,
  });

  ClientModel.fromJson(Map<String, dynamic> json) {
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
