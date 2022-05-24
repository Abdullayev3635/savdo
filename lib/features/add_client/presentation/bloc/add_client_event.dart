part of 'add_client_bloc.dart';

@immutable
abstract class AddClientEvent {}

class GetAllDataEvent extends AddClientEvent {}
class FilterEvent extends AddClientEvent {
  final String filterName;

  FilterEvent({required this.filterName});
}

class AddClientSendDataEvent extends AddClientEvent {
  final AddClientModel clientDataList;
  AddClientSendDataEvent({required this.clientDataList});
}
