import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:meta/meta.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';
import 'package:savdo_agnet_client/features/buyurtma/data/model/buyurtma_model.dart';
import 'package:savdo_agnet_client/features/buyurtma/domain/usescase/buyurtma_usescase.dart';

part 'buyurtma_dialog_event.dart';

part 'buyurtma_dialog_state.dart';

class BuyurtmaDialogBloc
    extends Bloc<BuyurtmaDialogEvent, BuyurtmaDialogState> {
  final UsesBuyurtma usesBuyurtma;

  BuyurtmaDialogBloc({
    required this.usesBuyurtma,
  }) : super(BuyurtmaDialogInitialState()) {
    on<BuyurtmaInitialEvent>(getBuyurtma, transformer: sequential());
  }

  FutureOr<void> getBuyurtma(
      BuyurtmaInitialEvent event, Emitter<BuyurtmaDialogState> emit) async {
    emit(BuyurtmaDialogLoadingState());
    final result = await usesBuyurtma(BuyurtmaParams());
    result.fold(
        (failure) => {
              if (failure is NoConnectionFailure)
                {emit(BuyurtmaDialogNoInternetState())}
              else if (failure is ServerFailure)
                {emit(BuyurtmaDialogFailureState(message: failure.message))}
            },
        (r) => {emit(BuyurtmaDialogSelectedSuccessState(buyurtmaList: r))});
  }
}
