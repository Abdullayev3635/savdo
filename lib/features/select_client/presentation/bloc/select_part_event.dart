part of 'select_part_bloc.dart';

@immutable
abstract class SelectPartEvent {}

class GetSelectClientEvent extends SelectPartEvent {}

class GetSelectAgentEvent extends SelectPartEvent {
  final String agentId;

  GetSelectAgentEvent(this.agentId);
}

class FilterSelectPartEvent extends SelectPartEvent {
  final List<ClientModel> list;
  final String text;

  FilterSelectPartEvent({required this.list, required this.text});
}

class FilterSelectSubPartEvent extends SelectPartEvent {
  final List<AgentModel> list;
  final String text;

  FilterSelectSubPartEvent({required this.list, required this.text});
}
