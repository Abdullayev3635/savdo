import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'mijoz_event.dart';
part 'mijoz_state.dart';

class MijozBloc extends Bloc<MijozEvent, MijozState> {
  MijozBloc() : super(MijozInitial()) {
    on<MijozEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
