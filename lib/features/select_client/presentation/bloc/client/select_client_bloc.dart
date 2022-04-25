import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:meta/meta.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';
import 'package:savdo_agnet_client/features/select_client/data/model/client_model.dart';
import 'package:savdo_agnet_client/features/select_client/domain/usescase/client_usescase.dart';
import 'package:savdo_agnet_client/features/select_client/domain/usescase/select_usescase.dart';

part 'select_client_event.dart';

part 'select_client_state.dart';

class SelectClientBloc extends Bloc<SelectPartEvent, SelectClientState> {
  final UsesSelectClient usesSelectClient;
  final OnSelectClient onSelectClient;
  late List<ClientModel> listOld;

  SelectClientBloc({
    required this.usesSelectClient,
    required this.onSelectClient,
  }) : super(SelectClientInitial()) {
    on<GetSelectClientEvent>(getClient, transformer: sequential());
    on<FilterSelectPartEvent>(getFilterPart, transformer: sequential());
    on<OnSelectedClient>(onSelectedClient, transformer: sequential());
  }

  FutureOr<void> getClient(
      GetSelectClientEvent event, Emitter<SelectClientState> emit) async {
    emit(SelectClientLoading());
    final result = await usesSelectClient(
      GetClientParams(),
    );
    result.fold(
        (failure) => {
              if (failure is NoConnectionFailure)
                {emit(SelectClientNoInternetState(message: ''))}
              else if (failure is ServerFailure)
                {emit(SelectClientFailureState(message: failure.message))}
            },
        (r) => {
              if (r.isEmpty)
                {
                  emit(
                      SelectClientFailureState(message: "hech narsa yo'q ekan"))
                }
              else
                {emit(SelectClientSuccess(list: r))}
            });
  }

  FutureOr<void> onSelectedClient(
      OnSelectedClient event, Emitter<SelectClientState> emit) async {
    emit(SelectClientLoading());
    final result = await onSelectClient(
      OnSelectedClientParams(
          salesAgentId: event.salesAgentId, customerId: event.customerId),
    );
    result.fold(
        (failure) => {
              if (failure is NoConnectionFailure)
                {emit(SelectClientNoInternetState(message: ''))}
              else if (failure is ServerFailure)
                {emit(SelectClientFailureState(message: failure.message))}
            },
        (r) => {
              if (r.isEmpty)
                {
                  emit(
                      SelectClientFailureState(message: "hech narsa yo'q ekan"))
                }
              else
                {emit(SelectClientSuccess(list: r))}
            });
  }

  FutureOr<void> getFilterPart(
      FilterSelectPartEvent event, Emitter<SelectClientState> emit) async {
    if (event.text.isEmpty) {
      emit(SelectClientSuccess(list: listOld));
    } else {
      emit(SelectClientSuccess(
          list: listOld.where((element) {
        final titleLower = element.name!.toLowerCase();
        final searchLower = event.text.toLowerCase();
        return titleLower.contains(searchLower);
      }).toList()));
    }
  }
}
