import 'package:hive/hive.dart';

// part 'group.g.dart';
part 'korzina_hive.g.dart';

@HiveType(typeId: 1)
class KorzinaCard extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String category;
  @HiveField(3)
  int currencyId;
  @HiveField(4)
  String currencyName;
  @HiveField(5)
  String price;
  @HiveField(6)
  int residue;
  @HiveField(7)
  String size;
  @HiveField(8)
  String image;
  @HiveField(9)
  String dona;
  @HiveField(10)
  String bloklarSoni;
  @HiveField(11)
  String blok;

  KorzinaCard({
    required this.bloklarSoni,
    required this.blok,
    required this.residue,
    required this.price,
    required this.name,
    required this.dona,
    required this.id,
    required this.category,
    required this.size,
    required this.currencyId,
    required this.currencyName,
    required this.image,
  });
}
//flutter packages pub run build_runner build
