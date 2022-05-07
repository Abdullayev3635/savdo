part of 'korzina_bloc.dart';

@immutable
abstract class KorzinaEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

  class KorzinaInitialEvent extends KorzinaEvent {}

class KorzinaSendDataEvent extends KorzinaEvent {
  final List<KorzinaCard> card;

  KorzinaSendDataEvent({required this.card});
}
