import 'package:hive/hive.dart';

part 'branch_model.g.dart';

@HiveType(typeId: 20)
class BranchModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;
  BranchModel({this.id, this.name});

  BranchModel.fromJson(Map<String, dynamic> json) {
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
