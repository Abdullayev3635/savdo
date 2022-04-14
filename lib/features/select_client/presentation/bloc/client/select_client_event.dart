part of 'select_client_bloc.dart';

@immutable
abstract class SelectPartEvent {}

class GetSelectClientEvent extends SelectPartEvent {}

class FilterSelectPartEvent extends SelectPartEvent {
  final List<ClientModel> list;
  final String text;

  FilterSelectPartEvent({required this.list, required this.text});
}
