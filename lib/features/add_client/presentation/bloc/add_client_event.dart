part of 'add_client_bloc.dart';

@immutable
abstract class AddClientEvent {}

class ValidateNameClientEvent extends AddClientEvent {
  final String validateNameModel;

  ValidateNameClientEvent({required this.validateNameModel});
}

class ValidatePhoneClientEvent extends AddClientEvent {
  final String validatePhoneModel;

  ValidatePhoneClientEvent({required this.validatePhoneModel});
}

class FilterEvent extends AddClientEvent {
  final String filterName;

  FilterEvent({required this.filterName});
}

class AddClientSendDataEvent extends AddClientEvent {
  final AddClientModel clientDataList;

  AddClientSendDataEvent({required this.clientDataList});
}
