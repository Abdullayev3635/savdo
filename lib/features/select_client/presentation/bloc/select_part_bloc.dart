import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';
import 'package:meta/meta.dart';
import 'package:savdo_agnet_client/features/select_client/data/model/agent_model.dart';
import 'package:savdo_agnet_client/features/select_client/data/model/client_model.dart';
import 'package:savdo_agnet_client/features/select_client/domain/usescase/client_usescase.dart';

part 'select_part_event.dart';

part 'select_part_state.dart';

class SelectPartBloc extends Bloc<SelectPartEvent, SelectPartState> {
  final UsesSelectClient usesSelectClient;
  late List<ClientModel> listOld;

  late List<AgentModel> listAgentOld;

  SelectPartBloc({required this.usesSelectClient})
      : super(SelectPartInitial()) {
    on<GetSelectClientEvent>(getClient, transformer: sequential());
    on<GetSelectAgentEvent>(getAgent, transformer: sequential());
    on<FilterSelectPartEvent>(getFilterPart, transformer: sequential());
    on<FilterSelectSubPartEvent>(getFilterSubPart, transformer: sequential());
  }

  List<AgentModel> agentList = [];

  FutureOr<void> getClient(
      GetSelectClientEvent event, Emitter<SelectPartState> emit) async {
    emit(SelectPartLoading());
    final result = await usesSelectClient(
      const SelectCaAParams(userId: 0),
    );
    result.fold(
        (failure) => {
              if (failure is NoConnectionFailure)
                {emit(SelectPartNoInternetState())}
              else if (failure is ServerFailure)
                {emit(SelectPartFailureState(message: failure.message))}
            },
        (r) => {
              emit(SelectPartSuccess(list: r)),
              listOld = r,
            });
  }

  FutureOr<void> getAgent(
      GetSelectAgentEvent event, Emitter<SelectPartState> emit) async {
    emit(SelectPartLoading());
    agentList.clear();
    final result = await usesSelectClient(
      SelectCaAParams(agentId: event.agentId),
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

  FutureOr<void> getFilterPart(
      FilterSelectPartEvent event, Emitter<SelectPartState> emit) async {
    if (event.text.isEmpty) {
      emit(SelectPartSuccess(list: listOld));
    } else {
      emit(SelectPartSuccess(
          list: listOld.where((element) {
        final titleLower = element.name!.toLowerCase();
        final searchLower = event.text.toLowerCase();
        return titleLower.contains(searchLower);
      }).toList()));
    }
  }

  FutureOr<void> getFilterSubPart(
      FilterSelectSubPartEvent event, Emitter<SelectPartState> emit) async {
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
