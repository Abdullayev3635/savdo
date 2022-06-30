part of 'brand_bloc.dart';

@immutable
abstract class ClientBrandState {}

class ClientBrandInitial extends ClientBrandState {}

class ClientBrandLoadingState extends ClientBrandState {}

class ClientBrandSuccessState extends ClientBrandState {
  final List<ClientBrandModel> list;

  ClientBrandSuccessState({required this.list});
}

class ClientBrandNoInternetState extends ClientBrandState {}

class ClientBrandFailureState extends ClientBrandState {
  final String message;

  ClientBrandFailureState({required this.message});
}
