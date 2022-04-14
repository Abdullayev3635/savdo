import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:meta/meta.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';
import 'package:savdo_agnet_client/features/select_client/domain/usescase/agent_usescase.dart';

import '../../../data/model/agent_model.dart';

part 'select_agent_event.dart';

part 'select_agent_state.dart';

class SelectAgentBloc extends Bloc<SelectAgentEvent, SelectAgentState> {
  SelectAgentBloc({required this.usesSelectAgent})
      : super(SelectAgentInitial()) {
    on<FilterSelectSubPartEvent>(getFilterSubPart, transformer: sequential());
    on<GetSelectAgentEvent>(getAgent, transformer: sequential());
  }

  final UsesSelectAgent usesSelectAgent;
  late List<AgentModel> listAgentOld;
  List<AgentModel> agentList = [];

  FutureOr<void> getAgent(
      GetSelectAgentEvent event, Emitter<SelectAgentState> emit) async {
    emit(SelectAgentLoading());
    agentList.clear();
    final result = await usesSelectAgent(
      SelectAgentParams(agentId: event.agentId),
    );
    result.fold(
        (failure) => {
              if (failure is NoConnectionFailure)
                {emit(SelectPartNoInternetState())}
              else if (failure is ServerFailure)
                {emit(SelectPartFailureState(message: failure.message))}
            },
        (r) => {
              for (int i = 0; r.length > i; i++)
                {
                  if (event.agentId == r[i].categoryId.toString())
                    {agentList.add(r[i])}
                },
              emit(SelectAgentPartSuccess(list: agentList)),
              listAgentOld = r,
            });
  }

  FutureOr<void> getFilterSubPart(
      FilterSelectSubPartEvent event, Emitter<SelectAgentState> emit) async {
    if (event.text.isEmpty) {
      emit(SelectAgentPartSuccess(list: listAgentOld));
    } else {
      emit(SelectAgentPartSuccess(
          list: listAgentOld.where((element) {
        final titleLower = element.name!.toLowerCase();
        final searchLower = event.text.toLowerCase();
        return titleLower.contains(searchLower);
      }).toList()));
    }
  }
}
