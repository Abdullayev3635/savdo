part of 'buyurtma_dialog_bloc.dart';

@immutable
abstract class BuyurtmaDialogState {}

class BuyurtmaDialogInitialState extends BuyurtmaDialogState {
  final int qarzdorlik;

  BuyurtmaDialogInitialState({required this.qarzdorlik});
}

class BuyurtmaDialogLoadingState extends BuyurtmaDialogState {}

class BuyurtmaDialogFailureState extends BuyurtmaDialogState {
  final String message;

  BuyurtmaDialogFailureState({required this.message});
}

class BuyurtmaDialogSelectedSuccessState extends BuyurtmaDialogState {
  final int qarzdorlik;
  final int kurs;

  BuyurtmaDialogSelectedSuccessState(
      {required this.qarzdorlik, required this.kurs});
}
