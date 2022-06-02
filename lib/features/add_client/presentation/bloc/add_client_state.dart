part of 'add_client_bloc.dart';

@immutable
abstract class AddClientState {
  final bool isAvailableName;
  final bool isAvailablePhone;

  const AddClientState(
      {required this.isAvailablePhone, required this.isAvailableName});
}

class AddClientInitial extends AddClientState {
  const AddClientInitial(
      {required bool isAvailablePhone, required bool isAvailableName})
      : super(
            isAvailablePhone: isAvailablePhone,
            isAvailableName: isAvailableName);
}

class AddClientLoadingState extends AddClientState {
  const AddClientLoadingState(
      {required bool isAvailablePhone, required bool isAvailableName})
      : super(
            isAvailablePhone: isAvailablePhone,
            isAvailableName: isAvailableName);
}

class ValidateNameState extends AddClientState {
  const ValidateNameState(
      {required bool isAvailablePhone, required bool isAvailableName})
      : super(
            isAvailablePhone: isAvailablePhone,
            isAvailableName: isAvailableName);
}

class ValidateNameLoadingState extends AddClientState {
  const ValidateNameLoadingState(
      {required bool isAvailablePhone, required bool isAvailableName})
      : super(
            isAvailablePhone: isAvailablePhone,
            isAvailableName: isAvailableName);
}

class ValidatePhoneLoadingState extends AddClientState {
  const ValidatePhoneLoadingState(
      {required bool isAvailablePhone, required bool isAvailableName})
      : super(
            isAvailablePhone: isAvailablePhone,
            isAvailableName: isAvailableName);
}

class ValidatePhoneState extends AddClientState {
  const ValidatePhoneState(
      {required bool isAvailablePhone, required bool isAvailableName})
      : super(
            isAvailablePhone: isAvailablePhone,
            isAvailableName: isAvailableName);
}

class AddClientErrorState extends AddClientState {
  final bool isSuccessAdded;

  const AddClientErrorState(
      {required this.isSuccessAdded,
      required bool isAvailablePhone,
      required bool isAvailableName})
      : super(
            isAvailablePhone: isAvailablePhone,
            isAvailableName: isAvailableName);
}

class AddClientNoInternetState extends AddClientState {
  final String message;

  const AddClientNoInternetState(
      {required this.message,
      required bool isAvailablePhone,
      required bool isAvailableName})
      : super(
            isAvailablePhone: isAvailablePhone,
            isAvailableName: isAvailableName);
}

class AddClientFailureState extends AddClientState {
  final String message;

  const AddClientFailureState(
      {required this.message,
      required bool isAvailablePhone,
      required bool isAvailableName})
      : super(
            isAvailablePhone: isAvailablePhone,
            isAvailableName: isAvailableName);
}
