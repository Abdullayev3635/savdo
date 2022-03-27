part of 'korzina_bloc.dart';

@immutable
abstract class KorzinaEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class KorzinaInitialEvent extends KorzinaEvent {}

class KorzinaAddEvent extends KorzinaEvent {
  final int id;
  final int price;
  final String hajmi;
  final int number;
  final String carType;
  final int rating;
  final List izoh;
  final String title;
  final String image;
  final String valyuta;

  KorzinaAddEvent({
    required this.id,
    required this.izoh,
    required this.price,
    required this.hajmi,
    required this.title,
    required this.image,
    required this.number,
    required this.valyuta,
    required this.rating,
    required this.carType,
  });
}

class KorzinaEditEvent extends KorzinaEvent {
  final int id;
  final int price;
  final String hajmi;
  final int number;
  final String carType;
  final int rating;
  final List izoh;
  final String title;
  final String image;
  final String valyuta;

  KorzinaEditEvent({
    required this.id,
    required this.izoh,
    required this.price,
    required this.hajmi,
    required this.title,
    required this.image,
    required this.number,
    required this.valyuta,
    required this.rating,
    required this.carType,
  });
}

class KorzinaDeleteEvent extends KorzinaEvent {
  final int index;

  KorzinaDeleteEvent({required this.index});
}
