part of 'add_client_bloc.dart';

@immutable
abstract class AddClientEvent {}

class GetAllDataEvent extends AddClientEvent {}

class AddClientSendDataEvent extends AddClientEvent {
  final List<AddClientModel> clientDataList;
  AddClientSendDataEvent({required this.clientDataList});
}
