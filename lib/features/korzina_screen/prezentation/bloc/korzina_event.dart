part of 'korzina_bloc.dart';

@immutable
abstract class KorzinaEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class KorzinaInitialEvent extends KorzinaEvent {}

class KorzinaAddEvent extends KorzinaEvent {
  final int id;
  final String name;
  final String category;
  final int currencyId;
  final String currencyName;
  final String price;
  final int residue;
  final String size;
  final String image;
  final String dona;
  final String blok;

  KorzinaAddEvent(
      {required this.id,
      required this.name,
      required this.category,
      required this.currencyId,
      required this.currencyName,
      required this.price,
      required this.residue,
      required this.size,
      required this.image,
      required this.dona,
      required this.blok});
}

class KorzinaEditEvent extends KorzinaEvent {
  final int id;
  final String name;
  final String category;
  final int currencyId;
  final String currencyName;
  final String price;
  final int residue;
  final String size;
  final String image;
  final String dona;
  final String blok;

  KorzinaEditEvent({
    required this.id,
    required this.name,
    required this.category,
    required this.currencyId,
    required this.currencyName,
    required this.price,
    required this.residue,
    required this.size,
    required this.image,
    required this.dona,
    required this.blok
  });
}

class KorzinaDeleteEvent extends KorzinaEvent {
  final int index;

  KorzinaDeleteEvent({required this.index});
}
