import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/widgets/costum_toast.dart';
import '../../../../di/dependency_injection.dart';

part 'pin_event.dart';

part 'pin_state.dart';

SharedPreferences sharedPreferences = di.get();

class PinBloc extends Bloc<PinEvent, PinState> {
  // final SharedPreferences sharedPreferences;
  PinBloc() : super(PinInitial()) {
    on<IsSharedPinEmpty>((event, emit) async {
      (sharedPreferences.get('pin_code') != null)
          ? emit(PinIsEmptyState(isEmpty: true))
          : emit(PinIsEmptyState(isEmpty: false));
    });
    on<OnPressedEvent>((event, emit) {
      emit(PinSuccessState());
      if (sharedPreferences.get('pin_code') != null) {
        if (sharedPreferences.get('pin_code') == event.oldPassword.text) {
          if (event.confirmPassword.text.length == 4 &&
              event.newPassword.text.length == 4) {
            if (event.newPassword.text == event.confirmPassword.text) {
              emit(PinSuccessState());
              saveShared(pinPutController: event.confirmPassword);
              event.newPassword.clear();
              event.confirmPassword.clear();
              event.oldPassword.clear();
            } else {
              event.confirmPassword.clear();
              emit(PinConfirmFailureState(
                message: "Parol mos kelmadi"));
            }
          } else {
            emit(PinConfirmFailureState(message: 'Belgilar soni to`rttadan kam kiritilmasligi kerak'));
          }
        } else if (event.oldPassword.text.isNotEmpty) {
          event.oldPassword.clear();
          // CustomToast.showToast('Eski parol noto`g`ri kiritilgan');
        } else {
          // CustomToast.showToast(
          //     'Belgilar soni to`rttadan kam kiritilmasligi kerak');
        }
      } else {
        if (event.confirmPassword.text.length == 4 &&
            event.newPassword.text.length == 4) {
          if (event.newPassword.text == event.confirmPassword.text) {
            saveShared(pinPutController: event.confirmPassword);
            emit(PinSuccessState());
          } else {
            event.confirmPassword.clear();
            emit(PinConfirmFailureState(
                message: 'Parol mos kelmadi'));
          }
        } else {
          CustomToast.showToast(
              'Belgilar soni to`rttadan kam kiritilmasligi kerak');
        }
      }
    });
  }

  Future saveShared({required TextEditingController pinPutController}) async {
    sharedPreferences.setString('pin_code', pinPutController.text);
    debugPrint('SHARED ${sharedPreferences.get('pin_code')}');
  }
}
