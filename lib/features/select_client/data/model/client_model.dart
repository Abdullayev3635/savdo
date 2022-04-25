class ClientModel {
  int? id;
  // int? qarzdorligi;
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