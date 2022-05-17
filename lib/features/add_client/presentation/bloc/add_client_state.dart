part of 'add_client_bloc.dart';

@immutable
abstract class AddClientState {}

class AddClientInitial extends AddClientState {}

class AddClientLoadingState extends AddClientState {}

class AddClientErrorState extends AddClientState {
  final List<AddClientErrorModel> list;

  AddClientErrorState({required this.list});
}

class AddClientNoInternetState extends AddClientState {
  final String message;

  AddClientNoInternetState({required this.message});
}
class AddClientFailureState extends AddClientState {
  final String message;

  AddClientFailureState({required this.message});
}
