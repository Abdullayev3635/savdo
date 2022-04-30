part of 'korzina_bloc.dart';

abstract class KorzinaState extends Equatable {
  @override
  List<Object> get props => [];

  const KorzinaState();
}

class KorzinaInitial extends KorzinaState {}

class KorzinaLoadingState extends KorzinaState {}

class KorzinaEditState extends KorzinaState {
  final KorzinaCard card;

  const KorzinaEditState({required this.card});

}
class YourKorzinaState extends KorzinaState {
  final List<KorzinaCard> cards;

  const YourKorzinaState({required this.cards});

}

class KorzinaNewCardState extends KorzinaState {}