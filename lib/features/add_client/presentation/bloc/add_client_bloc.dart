import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:meta/meta.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';
import 'package:savdo_agnet_client/features/add_client/data/model/add_client_model.dart';
import 'package:savdo_agnet_client/features/add_client/data/model/error_model.dart';

import '../../domain/usescase/usescase.dart';

part 'add_client_event.dart';

part 'add_client_state.dart';

class AddClientBloc extends Bloc<AddClientEvent, AddClientState> {
  final UsesAddClient usesClient;

  AddClientBloc({required this.usesClient}) : super(AddClientInitial()) {
    on<AddClientSendDataEvent>(getAddClientData, transformer: sequential());
  }

  FutureOr<void> getAddClientData(
      AddClientSendDataEvent event, Emitter<AddClientState> emit) async {
    emit(AddClientLoadingState());
    final result =
        await usesClient(AddClientParams(clientDataList: event.clientDataList));
    result.fold(
        (failure) => {
              if (failure is NoConnectionFailure)
                {emit(AddClientNoInternetState(message: failure.message))}
              else if (failure is ServerFailure)
                {emit(AddClientNoInternetState(message: failure.message))}
            },
        (r) => {
              if (r.isNotEmpty)
                {emit(AddClientErrorState(list: r))}
              else{}
                // {emit(const KorzinaErrorMessageState(korzinaErrorList: []))}
            });
  }
}