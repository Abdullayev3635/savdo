part of 'korzina_bloc.dart';

abstract class KorzinaState extends Equatable {
  @override
  List<Object> get props => [];

  const KorzinaState();
}

class KorzinaInitial extends KorzinaState {}

class KorzinaLoadingState extends KorzinaState {}

class KorzinaSuccessState extends KorzinaState {
  final List<BuyurtmaModel> buyurtmaList;

  const KorzinaSuccessState({required this.buyurtmaList});
}

class KorzinaFailureState extends KorzinaState {
  final String message;

  const KorzinaFailureState({required this.message});
}
