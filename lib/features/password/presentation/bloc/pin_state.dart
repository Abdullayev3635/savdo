// ignore_for_file: must_be_immutable

part of 'pin_bloc.dart';

@immutable
abstract class PinState {}

class PinInitial extends PinState {}

class PinIsEmptyState extends PinState {
  bool isEmpty;

  PinIsEmptyState({required this.isEmpty});
}

class PinSuccessState extends PinState {}

class PinConfirmFailureState extends PinState {
  String message = "";

  PinConfirmFailureState({required this.message});
}
