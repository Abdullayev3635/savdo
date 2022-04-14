part of 'select_client_bloc.dart';

@immutable
abstract class SelectClientState {}

class SelectClientInitial extends SelectClientState {}

class SelectClientLoading extends SelectClientState {}

class SelectClientSuccess extends SelectClientState {
  final List<ClientModel> list;

  SelectClientSuccess({required this.list});
}

class SelectClientNoInternetState extends SelectClientState {}

class SelectClientFailureState extends SelectClientState {
  final String message;

  SelectClientFailureState({required this.message});
}
