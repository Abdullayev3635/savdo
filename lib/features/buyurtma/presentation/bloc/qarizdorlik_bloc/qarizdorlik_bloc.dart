import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:meta/meta.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';
import 'package:savdo_agnet_client/features/buyurtma/data/model/client_debit_credit.dart';
import 'package:savdo_agnet_client/features/buyurtma/domain/usescase/select_usescase.dart';

part 'qarizdorlik_event.dart';

part 'qarizdorlik_state.dart';

class QarizdorlikBloc extends Bloc<QarizdorlikEvent, QarizdorlikState> {
  final OnSelectClientUsescase onSelectClient;

  QarizdorlikBloc({
    required this.onSelectClient,
  }) : super(QarizdorlikInitial()) {
    on<ClientSelectedEvent>(getClientDebitCredit, transformer: sequential());
  }

  FutureOr<void> getClientDebitCredit(
      ClientSelectedEvent event, Emitter<QarizdorlikState> emit) async {
    emit(QarizdorlikLoading());
    final result = await onSelectClient(
      OnSelectedClientParams(
          salesAgentId: event.salesAgentId, customerId: event.customerId),
    );
    result.fold(
        (failure) => {
              if (failure is NoConnectionFailure)
                {emit(QarizdorlikFail(message: ''))}
              else if (failure is ServerFailure)
                {emit(QarizdorlikFail(message: failure.message))}
            },
        (r) => {
              if (r.isEmpty)
                {emit(QarizdorlikFail(message: "hech narsa yo'q ekan"))}
              else
                {emit(QarizdorlikLoaded(debitList: r))}
            });
  }
}
