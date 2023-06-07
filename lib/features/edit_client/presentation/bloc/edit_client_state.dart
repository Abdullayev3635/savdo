part of 'edit_client_bloc.dart';

@immutable
abstract class EditClientState {}

class EditClientInitial extends EditClientState {}

class EditClientLoadingState extends EditClientState {}

class EditClientSuccess extends EditClientState {
  final String message;

  EditClientSuccess({required this.message});
}
class EditClientConnectionFailureState extends EditClientState {
  final String message;

  EditClientConnectionFailureState({required this.message});
}

