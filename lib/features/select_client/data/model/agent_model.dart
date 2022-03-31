import 'package:hive/hive.dart';

part 'agent_model.g.dart';


@HiveType(typeId: 2)
class AgentModel extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;

  AgentModel({
    this.id,
    this.name,
  });

  AgentModel.fromJson(Map<String, dynamic> json) {
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
