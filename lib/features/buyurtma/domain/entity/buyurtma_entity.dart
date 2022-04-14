import 'package:equatable/equatable.dart';

class BuyurtmaEntity extends Equatable {
  final int id;
  final String name;
  final int qarz;
  final String narxTuri;
  final String savdoTuri;

  const BuyurtmaEntity(
      {required this.id,
      required this.name,
      required this.qarz,
      required this.narxTuri,
      required this.savdoTuri});

  @override
  List<Object?> get props => [
        id,
        name,
        qarz,
        narxTuri,
        savdoTuri,
      ];
}
