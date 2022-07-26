import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:meta/meta.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';
import 'package:savdo_agnet_client/features/select_client/data/model/client_model.dart';
import 'package:savdo_agnet_client/features/select_client/domain/usescase/client_usescase.dart';
import 'package:savdo_agnet_client/features/select_client/domain/usescase/client_usescase_local.dart';

part 'select_tulov_turi_event.dart';

part 'select_tulov_turi_state.dart';

class SelectClientBloc extends Bloc<SelectPartEvent, SelectClientState> {
  final UsesSelectClient usesSelectClient;
  UsesClientLocal usesSelectClientLocal;
  late List<ClientModel> listOld;

  SelectClientBloc({
    required this.usesSelectClientLocal,
    required this.usesSelectClient,
  }) : super(SelectClientInitial()) {
    on<GetSelectClientEvent>(getClient, transformer: sequential());
    on<GetSelectClientLocalEvent>(getClientLocal, transformer: sequential());
    on<FilterSelectPartEvent>(getFilterPart, transformer: sequential());
  }

  FutureOr<void> getClient(
      GetSelectClientEvent event, Emitter<SelectClientState> emit) async {
    final result = await usesSelectClientLocal(ClientParamsLocal());
    // final box = Hive.box(clientBox);
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
                {
                  emit(SelectClientSuccess(list: r)),
                  listOld = r,
                  // log(listOld.length.toString()),
                }
            });
  }

  FutureOr<void> getClientLocal(
      GetSelectClientLocalEvent event, Emitter<SelectClientState> emit) async {
    final result = await usesSelectClient(GetClientParams());
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
                {
                  emit(SelectClientSuccess(list: r)),
                  listOld = r,
                  // log(listOld.length.toString()),
                }
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
