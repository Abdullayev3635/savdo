import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/widgets/costum_toast.dart';

part 'pin_event.dart';

part 'pin_state.dart';

class PinBloc extends Bloc<PinEvent, PinState> {
  final SharedPreferences sharedPreferences;

  PinBloc({required this.sharedPreferences}) : super(PinInitial()) {
    on<IsSharedPinEmpty>((event, emit) async {
      (sharedPreferences.get('pin_code') != null)
          ? emit(PinIsEmptyState(isEmpty: true))
          : emit(PinIsEmptyState(isEmpty: false));
    });
    on<OnPressedEvent>((event, emit) {
      if (sharedPreferences.get('pin_code') != null) {
        _sharedIsNotEmpty(event, emit);
      } else {
        _sharedIsEmpty(event, emit);
      }
    });
  }

  Future saveShared({required TextEditingController pinPutController}) async {
    sharedPreferences.setString('pin_code', pinPutController.text);
    debugPrint('SHARED ${sharedPreferences.get('pin_code')}');
  }

  _sharedIsEmpty(OnPressedEvent event, Emitter<PinState> emit) {
    if (event.confirmPassword.text.length == 4 &&
        event.newPassword.text.length == 4) {
      if (event.newPassword.text == event.confirmPassword.text) {
        saveShared(pinPutController: event.confirmPassword);
        emit(PinSuccessState());
      } else {
        event.confirmPassword.clear();
        emit(PinConfirmFailureState(message: 'Parol mos kelmadi'));
      }
    } else {
      CustomToast.showToast(
          'Belgilar soni to`rttadan kam kiritilmasligi kerak');
    }
  }

  _sharedIsNotEmpty(OnPressedEvent event, Emitter<PinState> emit) {
    if (sharedPreferences.get('pin_code') == event.oldPassword.text) {
      if (event.confirmPassword.text.length == 4 &&
          event.newPassword.text.length == 4) {
        if (event.newPassword.text == event.confirmPassword.text) {
          emit(PinSuccessState());
          saveShared(pinPutController: event.confirmPassword);
        } else {
          event.confirmPassword.clear();
          emit(PinConfirmFailureState(message: "Parol mos kelmadi"));
        }
      } else {
        emit(PinConfirmFailureState(
            message: 'Belgilar soni to`rttadan kam kiritilmasligi kerak'));
      }
    } else if (event.oldPassword.text.isNotEmpty) {
      event.oldPassword.clear();
      emit(PinConfirmFailureState(message: 'Eski parol noto`g`ri kiritilgan'));
    } else {
      emit(PinConfirmFailureState(
          message: 'Belgilar soni to`rttadan kam kiritilmasligi kerak'));
    }
  }
}
