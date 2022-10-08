import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/usescases/u_login.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginData loginData;

  LoginBloc({required this.loginData}) : super(LoginInitial()) {
    on<SendLoginEvent>(_sendLogin, transformer: sequential());
  }

  FutureOr<void> _sendLogin(
      SendLoginEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    final result = await loginData(
      LoginParams(event.tel, event.pass),
    );
    result.fold(
        (failure) => {
              if (failure is NoConnectionFailure)
                emit(NoConnectionLogin())
              else if (failure is ServerFailure)
                emit(LoginFailure(failure.message))
            },
        (r) => {
              if (r == "0")
                {emit(LoginFailure("Internal Server!"))}
              else
                {emit(LoginSuccess("Success"))}
            });
  }
}
