part of 'select_tulov_turi_bloc.dart';

@immutable
abstract class SelectPartEvent {}

class GetSelectClientEvent extends SelectPartEvent {}

class GetSelectClientLocalEvent extends SelectPartEvent {}

class FilterSelectPartEvent extends SelectPartEvent {
  final List<ClientModel> list;
  final String text;

  FilterSelectPartEvent({required this.list, required this.text});
}
