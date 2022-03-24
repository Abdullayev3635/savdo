import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/cupertino.dart';

import '../usescases/u_lock.dart';

part 'pass_event.dart';

part 'pass_state.dart';

class PassBloc extends Bloc<PassEvent, PassState> {
  final Pass _pass;

  PassBloc({required Pass pass})
      : _pass = pass,
        super(const PassInitial("Махфий паролни киритинг")) {
    on<PassCompileEvent>(
      _nextPage,
      transformer: sequential(),
    );
  }

  FutureOr<void> _nextPage(
      PassCompileEvent event, Emitter<PassState> emit) async {
    emit(const PassLoading(""));
    final result = await _pass(PasswordParams(event.passController.text));
    result.fold(
        (f) => {
              emit(const PassError(
                  message:
                      "Киритилган пароль нотўғри илтимос қайтадан ҳаракат қилинг",
                  errorMessage: "error"))
            },
        (s) => {emit(const PassSuccess(""))});

    event.passController.clear();
  }
}
