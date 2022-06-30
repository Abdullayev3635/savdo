import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:meta/meta.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';
import 'package:savdo_agnet_client/features/buyurtma/data/model/buyurtma_model.dart';
import 'package:savdo_agnet_client/features/buyurtma/domain/usescase/buyurtma_usescase.dart';
import 'package:savdo_agnet_client/features/buyurtma/domain/usescase/buyurtma_usescase_local.dart';

part 'buyurtma_dialog_event.dart';

part 'buyurtma_dialog_state.dart';

class BuyurtmaDialogBloc
    extends Bloc<BuyurtmaDialogEvent, BuyurtmaDialogState> {
  final UsesBuyurtma usesBuyurtma;
  final UsesBuyurtmaLocal usesBuyurtmaLocal;

  BuyurtmaDialogBloc({
    required this.usesBuyurtma,
    required this.usesBuyurtmaLocal,
  }) : super(BuyurtmaDialogInitialState()) {
    on<BuyurtmaInitialLocalEvent>(getBuyurtmaLocal, transformer: sequential());
    on<BuyurtmaInitialEvent>(getBuyurtma, transformer: sequential());
  }

  FutureOr<void> getBuyurtmaLocal(BuyurtmaInitialLocalEvent event,
      Emitter<BuyurtmaDialogState> emit) async {
    final result = await usesBuyurtmaLocal(BuyurtmaParamsLocal());
    result.fold(
        (failure) => {
              if (failure is NoConnectionFailure)
                {emit(BuyurtmaDialogNoInternetState())}
              else if (failure is ServerFailure)
                {emit(BuyurtmaDialogFailureState(message: failure.message))}
            },
        (r) => {
              if (r.isNotEmpty)
                {
                  emit(BuyurtmaDialogSelectedSuccessState(buyurtmaList: r)),
                }
              else
                {
                  emit(BuyurtmaDialogFailureState(
                      message: 'Internet bilan aloqani tekshiring!'))
                }
            });
  }

  FutureOr<void> getBuyurtma(
      BuyurtmaInitialEvent event, Emitter<BuyurtmaDialogState> emit) async {
    final result = await usesBuyurtma(BuyurtmaParams());
    result.fold(
        (failure) => {
              if (failure is NoConnectionFailure)
                {emit(BuyurtmaDialogNoInternetState())}
              else if (failure is ServerFailure)
                {emit(BuyurtmaDialogFailureState(message: failure.message))}
            },
        (r) => {
              if (r.isNotEmpty)
                {
                  emit(BuyurtmaDialogSelectedSuccessState(buyurtmaList: r)),
                }
              else
                {
                  emit(BuyurtmaDialogFailureState(
                      message: 'Internet bilan aloqani tekshiring!'))
                }
            });
  }
}
