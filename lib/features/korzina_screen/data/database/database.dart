import 'package:hive/hive.dart';

import '../korzina_hive/korzina_hive.dart';

class Database {
  String korzinaName = 'korzina_box';

  ///open Box
  Future<Box> korzinaBox() async {
    var box = await Hive.openBox<KorzinaCard>(korzinaName);
    return box;
  }

  /// barchasini ko'rish
  Future<List<KorzinaCard>> getFullNote() async {
    final box = await korzinaBox();
    List<KorzinaCard> cards = box.values.toList() as List<KorzinaCard>;
    return cards;
  }

  /// qo'shish
  Future<void> addElement(KorzinaCard korzinaCard) async {
    final box = await korzinaBox();
    await box.add(KorzinaCard);
  }

  /// korzinadan  o'chirish
  Future<void> deleteElement(int index) async {
    final box = await korzinaBox();
    await box.deleteAt(index);
  }

  /// korzinani barchasini o'chirish
  Future<void> deleteAllElement() async {
    final box = await korzinaBox();
    await box.clear();
  }

  /// korzinani yangilash
  Future<void> updateElement(int index, KorzinaCard card) async {
    final box = await korzinaBox();
    await box.putAt(index, card);
  }
}
