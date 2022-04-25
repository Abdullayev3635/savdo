//
// import 'package:hive/hive.dart';
//
// part 'client_model.g.dart';
//
// @HiveType(typeId: 3)
// class ClientModel extends HiveObject{
//   @HiveField(0)
//   int? id;
//   @HiveField(1)
//   String? name;
//
//   ClientModel({
//     this.id,
//     this.name,
//   });
//
//   ClientModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['name'] = name;
//     return data;
//   }
// }


class ClientModel {
  int? id;
  String? name;
  String? symbol;
  String? value;
  String? createdAt;
  String? updatedAt;

  ClientModel(
      {this.id,
        this.name,
        this.symbol,
        this.value,
        this.createdAt,
        this.updatedAt});

  ClientModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    symbol = json['symbol'];
    value = json['value'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['symbol'] = symbol;
    data['value'] = value;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}