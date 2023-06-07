import 'package:hive/hive.dart';

part 'store_model.g.dart';

@HiveType(typeId: 14)
class StoreModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  int? branch_id;

  StoreModel({this.id, this.name, this.branch_id});

  StoreModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    branch_id = json['branch_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['branch_id'] = branch_id;
    return data;
  }
}
