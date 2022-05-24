import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:meta/meta.dart';
import 'package:savdo_agnet_client/features/test_add/data/models/test_model.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/use_cases/test_uses_case.dart';

part 'test_event.dart';
part 'test_state.dart';

class TestBloc extends Bloc<TestEvent, TestState> {
  TestBuyurtma testBuyurtma;
  TestBloc({required this.testBuyurtma}) : super(TestInitial()) {
    on<GetDataEvent>(getTest, transformer: sequential());
  }
  FutureOr<void> getTest(
      GetDataEvent event, Emitter<TestState> emit) async {
    final result = await testBuyurtma(TestParams());
    result.fold(
            (failure) => {
          if (failure is NoConnectionFailure)
            {emit(TestFail())}
          else if (failure is ServerFailure)
            {emit(TestFail())}
        },
            (r) => {
          if (r.isNotEmpty)
            {
              emit(TestLoaded(list: r)),
            }
          else
            {
              emit(TestFail())
            }
        });
  }
}
