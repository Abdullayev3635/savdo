part of 'select_client_bloc.dart';

@immutable
abstract class SelectPartEvent {}

class GetSelectClientEvent extends SelectPartEvent {}

class OnSelectedClient extends SelectPartEvent {
  final int salesAgentId;
  final int customerId;

  OnSelectedClient({required this.salesAgentId, required this.customerId});
}

class FilterSelectPartEvent extends SelectPartEvent {
  final List<ClientModel> list;
  final String text;

  FilterSelectPartEvent({required this.list, required this.text});
}
