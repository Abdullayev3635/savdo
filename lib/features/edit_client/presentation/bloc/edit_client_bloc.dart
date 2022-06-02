import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:meta/meta.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';
import 'package:savdo_agnet_client/features/edit_client/domain/usescase/usescase.dart';

part 'edit_client_event.dart';

part 'edit_client_state.dart';

class EditClientBloc extends Bloc<EditClientEvent, EditClientState> {
  final EditClientUsescase editClientUsescase;

  EditClientBloc({required this.editClientUsescase})
      : super(EditClientInitial()) {
    on<GetEditClientEvent>(getEditClient, transformer: sequential());
  }

  FutureOr<void> getEditClient(
      GetEditClientEvent event, Emitter<EditClientState> emit) async {
    emit(EditClientLoadingState());
    final result = await editClientUsescase(EditClientParams(
        phone1: event.phone1, coordinate: event.coordinate, id: event.id));
    result.fold(
        (failure) => {
              if (failure is NoConnectionFailure)
                {
                  emit(EditClientConnectionFailureState(
                      message: 'Internet bilan aloqa mavjud emas!'))
                }
              else if (failure is ServerFailure)
                {
                  emit(EditClientConnectionFailureState(
                      message: failure.message))
                }
            },
        (r) => {emit(EditClientSuccess(message: ''))});
  }
}
