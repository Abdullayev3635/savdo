part of 'select_agent_bloc.dart';

@immutable
abstract class SelectAgentState {}

class SelectAgentInitial extends SelectAgentState {}

class SelectAgentLoading extends SelectAgentState {}

class SelectAgentPartSuccess extends SelectAgentState {
  final List<AgentModel> list;

  SelectAgentPartSuccess({required this.list});
}

class SelectPartNoInternetState extends SelectAgentState {}

class SelectPartFailureState extends SelectAgentState {
  final String message;

  SelectPartFailureState({required this.message});
}
