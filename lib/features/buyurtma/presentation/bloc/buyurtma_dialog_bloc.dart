import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:meta/meta.dart';
import 'package:savdo_agnet_client/features/buyurtma/data/model/buyurtma_model.dart';
import 'package:savdo_agnet_client/features/main/presentation/bloc/buyurtma_bloc.dart';

import '../../domain/usescase/buyurtma_usescase.dart';

part 'buyurtma_dialog_event.dart';

part 'buyurtma_dialog_state.dart';

class BuyurtmaDialogBloc
    extends Bloc<BuyurtmaDialogEvent, BuyurtmaDialogState> {
  final UsesBuyurtma usesBuyurtma;

  BuyurtmaDialogBloc({
    required this.usesBuyurtma,
  }) : super(BuyurtmaDialogInitialState()) {
    on<BuyurtmaDialogEvent>(getBuyurtma, transformer: sequential());
  }

  FutureOr<void> getBuyurtma(BuyurtmaDialogEvent event,
      Emitter<BuyurtmaDialogState> emit) async {
    emit(BuyurtmaDialogLoadingState());
    final result = await usesBuyurtma(
      BuyurtmaParams(),
    );
    // result.fold(
    //     (failure) => {
    //           if (failure is NoConnectionFailure)
    //             {emit(NewHistoryFailure(message: failure.message))}
    //           else if (failure is ServerFailure)
    //             {emit(NewHistoryFailure(message: failure.message))}
    //         },
    //     (r) => {emit(NewHistorySuccess(list: r))});
  }
}