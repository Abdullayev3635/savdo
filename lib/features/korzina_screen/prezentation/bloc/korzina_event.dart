part of 'korzina_bloc.dart';

@immutable
abstract class KorzinaEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class KorzinaInitialEvent extends KorzinaEvent {}

class KorzinaSendDataEvent extends KorzinaEvent {
  final List<KorzinaCard> card;
  final dynamic json;

  KorzinaSendDataEvent({required this.card, required this.json});
}
