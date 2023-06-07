import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:meta/meta.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';
import 'package:savdo_agnet_client/features/add_client/data/model/add_client_model.dart';
import 'package:savdo_agnet_client/features/add_client/domain/usescase/validate_name_usescase.dart';
import 'package:savdo_agnet_client/features/add_client/domain/usescase/validate_phone_usescase.dart';
import '../../domain/usescase/usescase.dart';

part 'add_client_event.dart';

part 'add_client_state.dart';

class AddClientBloc extends Bloc<AddClientEvent, AddClientState> {
  final UsesAddClient usesClient;
  final UsesValidateName usesValidateName;
  final UsesValidatePhone usesValidatePhone;

  AddClientBloc(
      {required this.usesClient,
      required this.usesValidateName,
      required this.usesValidatePhone})
      : super(const AddClientInitial(
            isAvailableName: true, isAvailablePhone: true)) {
    on<AddClientSendDataEvent>(getAddClientData, transformer: sequential());
    on<ValidateNameClientEvent>(getNameData, transformer: sequential());
    on<ValidatePhoneClientEvent>(getPhoneData, transformer: sequential());
  }

  FutureOr<void> getAddClientData(
      AddClientSendDataEvent event, Emitter<AddClientState> emit) async {
    emit(const AddClientLoadingState(
        isAvailablePhone: true, isAvailableName: true));
    final result =
        await usesClient(AddClientParams(clientDataList: event.clientDataList));
    result.fold(
        (failure) => {
              if (failure is NoConnectionFailure)
                {
                  emit(AddClientNoInternetState(
                      message: failure.message,
                      isAvailablePhone: true,
                      isAvailableName: true))
                }
              else if (failure is ServerFailure)
                {
                  emit(AddClientNoInternetState(
                      message: failure.message,
                      isAvailableName: true,
                      isAvailablePhone: true))
                }
            },
        (r) => {
              if (r)
                {
                  emit(const AddClientErrorState(
                      isSuccessAdded: true,
                      isAvailablePhone: true,
                      isAvailableName: true))
                }
              else
                {
                  emit(const AddClientErrorState(
                      isSuccessAdded: false,
                      isAvailablePhone: true,
                      isAvailableName: true))
                }
            });
  }

  FutureOr<void> getNameData(
      ValidateNameClientEvent event, Emitter<AddClientState> emit) async {
    emit(const ValidateNameLoadingState(
        isAvailableName: true, isAvailablePhone: true));
    final result = await usesValidateName(
        ValidateNameParams(validateName: event.validateNameModel));
    result.fold(
      (failure) => {
        if (failure is NoConnectionFailure)
          {
            emit(AddClientNoInternetState(
                message: failure.message,
                isAvailableName: true,
                isAvailablePhone: true))
          }
        else if (failure is ServerFailure)
          {
            emit(AddClientNoInternetState(
                message: failure.message,
                isAvailablePhone: true,
                isAvailableName: true))
          }
      },
      (r) => {
        if (r == true)
          emit(const ValidateNameState(
              isAvailableName: true, isAvailablePhone: true))
        else
          emit(const ValidateNameState(
              isAvailableName: false, isAvailablePhone: true))
      },
    );
  }

  FutureOr<void> getPhoneData(
      ValidatePhoneClientEvent event, Emitter<AddClientState> emit) async {
    emit(const ValidatePhoneLoadingState(
        isAvailablePhone: true, isAvailableName: true));
    final result = await usesValidatePhone(
        ValidatePhoneParams(validatePhone: event.validatePhoneModel));
    result.fold(
      (failure) => {
        if (failure is NoConnectionFailure)
          {
            emit(AddClientNoInternetState(
                message: failure.message,
                isAvailableName: true,
                isAvailablePhone: true))
          }
        else if (failure is ServerFailure)
          {
            emit(AddClientNoInternetState(
                message: failure.message,
                isAvailableName: true,
                isAvailablePhone: true))
          }
      },
      (r) => {
        if (r == true)
          emit(const ValidatePhoneState(
              isAvailablePhone: true, isAvailableName: true))
        else
          emit(const ValidatePhoneState(
              isAvailablePhone: false, isAvailableName: true))
      },
    );
  }
}
