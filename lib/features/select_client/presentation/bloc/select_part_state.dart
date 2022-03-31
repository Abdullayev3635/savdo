part of 'select_part_bloc.dart';

@immutable
abstract class SelectPartState {}

class SelectPartInitial extends SelectPartState {}

class SelectPartLoading extends SelectPartState {}

class SelectPartSuccess extends SelectPartState {
  final List<ClientModel> list;

  SelectPartSuccess({required this.list});
}

class SelectAgentPartSuccess extends SelectPartState {
  final List<AgentModel> list;

  SelectAgentPartSuccess({required this.list});
}

class SelectPartNoInternetState extends SelectPartState {}

class SelectPartFailureState extends SelectPartState {
  final String message;

  SelectPartFailureState({required this.message});
}
