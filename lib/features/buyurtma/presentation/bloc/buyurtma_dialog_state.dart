part of 'buyurtma_dialog_bloc.dart';

@immutable
abstract class BuyurtmaDialogState {}

class BuyurtmaDialogInitialState extends BuyurtmaDialogState {}

class BuyurtmaDialogLoadingState extends BuyurtmaDialogState {}

class BuyurtmaDialogFailureState extends BuyurtmaDialogState {
  final String message;

  BuyurtmaDialogFailureState({required this.message});
}

class BuyurtmaDialogSelectedSuccessState extends BuyurtmaDialogState {
  final BuyurtmaModel buyurtmaList;

  BuyurtmaDialogSelectedSuccessState(
      {required this.buyurtmaList});
}
