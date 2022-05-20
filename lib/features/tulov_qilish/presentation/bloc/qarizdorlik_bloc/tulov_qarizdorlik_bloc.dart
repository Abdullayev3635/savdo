import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:meta/meta.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';
import 'package:savdo_agnet_client/features/tulov_qilish/data/model/tulov_client_debit_credit.dart';
import 'package:savdo_agnet_client/features/tulov_qilish/domain/usescase/select_client_tulov_usescase.dart';
import 'package:savdo_agnet_client/features/tulov_qilish/domain/usescase/tulov_qilish_usescase.dart';

part 'tulov_qarizdorlik_event.dart';

part 'tulov_qarizdorlik_state.dart';

class TulovQarizdorlikBloc
    extends Bloc<TulovQarizdorlikEvent, TulovQarizdorlikState> {
  final OnSelectClientTulov onSelectClientTulov;
  final OnTulovQilishUsescase tulovQilishUsescase;

  TulovQarizdorlikBloc({
    required this.onSelectClientTulov,
    required this.tulovQilishUsescase,
  }) : super(TulovQarizdorlikInitial()) {
    on<TulovClientSelectedEvent>(getClientDebitCredit,
        transformer: sequential());
    on<TulovQilishEvent>(getTulov, transformer: sequential());
  }

  FutureOr<void> getTulov(
      TulovQilishEvent event, Emitter<TulovQarizdorlikState> emit) async {
    final result = await tulovQilishUsescase(OnTulovQilishParams(
        customerId: event.customerId,
        salesAgentId: event.salesAgentId,
        description: event.description,
        paymentAmount: event.paymentAmount,
        summa: event.summa,
        paymentTypeId: event.paymentTypeId,
        currencyValue: event.currencyValue,
        currencyId: event.currencyId,
        branchId: event.branchId));
    result.fold(
      (failure) => {
        if (failure is NoConnectionFailure)
          {emit(TulovQarizdorlikFail(message: ''))}
        else if (failure is ServerFailure)
          {emit(TulovQarizdorlikFail(message: failure.message))}
      },
      (r) => {
        if (r == "Created!")
          {emit(TulovCreatedState(message: 'Created!'))}
        else
          {emit(TulovCreatedState(message: 'Error!'))}
      },
    );
  }

  FutureOr<void> getClientDebitCredit(TulovClientSelectedEvent event,
      Emitter<TulovQarizdorlikState> emit) async {
    emit(TulovQarizdorlikLoading());
    final result = await onSelectClientTulov(
      OnSelectedClientTulovParams(
          salesAgentId: event.salesAgentId, customerId: event.customerId),
    );
    result.fold(
        (failure) => {
              if (failure is NoConnectionFailure)
                {emit(TulovQarizdorlikFail(message: ''))}
              else if (failure is ServerFailure)
                {emit(TulovQarizdorlikFail(message: failure.message))}
            },
        (r) => {
              if (r.isEmpty)
                {emit(TulovQarizdorlikFail(message: "hech narsa yo'q ekan"))}
              else
                {emit(TulovQarizdorlikLoadedState(debitList: r))}
            });
  }
}
