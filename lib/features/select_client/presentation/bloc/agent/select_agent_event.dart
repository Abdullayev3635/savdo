part of 'select_agent_bloc.dart';

@immutable
abstract class SelectAgentEvent {}


class GetSelectAgentEvent extends SelectAgentEvent {
  final String agentId;

  GetSelectAgentEvent(this.agentId);
}

class FilterSelectSubPartEvent extends SelectAgentEvent {
  final List<AgentModel> list;
  final String text;

  FilterSelectSubPartEvent({required this.list, required this.text});
}
