// import 'package:hive/hive.dart';
//
// part 'buyurtma_model.g.dart';
//
// @HiveType(typeId: 4)
// class BuyurtmaModel extends HiveObject {
//   // @HiveField(0)
//   // int? id;
//   // @HiveField(1)
//   // String? name;
//   // @HiveField(3)
//   // int? qarz;
//   // @HiveField(4)
//   // String? narxTuri;
//   // @HiveField(5)
//   // String? savdoTuri;
//
//   BuyurtmaModel({
//     this.id,
//     this.name,
//     this.qarz,
//     this.narxTuri,
//     this.savdoTuri,
//   });
//
//   BuyurtmaModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     qarz = json['qarz'];
//     narxTuri = json['narxTuri'];
//     savdoTuri = json['savdoTuri'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['name'] = name;
//     data['qarz'] = qarz;
//     data['narxTuri'] = narxTuri;
//     data['savdoTuri'] = savdoTuri;
//     return data;
//   }
// }

import 'package:savdo_agnet_client/features/buyurtma/domain/entity/buyurtma_entity.dart';

class BuyurtmaModel extends BuyurtmaEntity {
  const BuyurtmaModel(
      {required id,
      required name,
      required qarz,
      required narxTuri,
      required savdoTuri})
      : super(
            id: id,
            name: name,
            qarz: qarz,
            narxTuri: narxTuri,
            savdoTuri: savdoTuri);

  factory BuyurtmaModel.fromJson(Map<String, dynamic> json) {
    return BuyurtmaModel(
      id: json['id'],
      name: json['name'],
      qarz: json['qarz'],
      narxTuri: json['narxTuri'],
      savdoTuri: json['savdoTuri'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['qarz'] = qarz;
    data['narxTuri'] = narxTuri;
    data['savdoTuri'] = savdoTuri;
    return data;
  }
}
