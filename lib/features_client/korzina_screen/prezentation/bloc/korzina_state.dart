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
  final List<KorzinaCard> korzinaSaveList;

  const KorzinaSuccessState({
    required this.korzinaSaveList,
    required this.buyurtmaList,
  });
}

class KorzinaErrorMessageState extends KorzinaState {
  final List<ErrorModel> korzinaErrorList;

  const KorzinaErrorMessageState({required this.korzinaErrorList});
}

class KorzinaNoInternetState extends KorzinaState {
  final String message;

  const KorzinaNoInternetState({required this.message});
}

class KorzinaFailureState extends KorzinaState {
  final String message;

  const KorzinaFailureState({required this.message});
}
