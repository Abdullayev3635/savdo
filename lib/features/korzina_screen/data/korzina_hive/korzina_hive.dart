import 'package:hive/hive.dart';

// part 'group.g.dart';
part 'korzina_hive.g.dart';

@HiveType(typeId: 1)
class KorzinaCard extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String image;
  @HiveField(2)
  int price;
  @HiveField(3)
  String title;
  @HiveField(4)
  int number;
  @HiveField(5)
  String hajmi;
  @HiveField(6)
  String valyuta;
  @HiveField(7)
  int rating;
  @HiveField(8)
  String carType;

  KorzinaCard({
    required this.title,
    required this.valyuta,
    required this.hajmi,
    required this.image,
    required this.number,
    required this.id,
    required this.price,
    required this.rating,
    required this.carType,
  });
}
//flutter packages pub run build_runner build
