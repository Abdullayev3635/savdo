import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'tulov_qilish_event.dart';
part 'tulov_qilish_state.dart';

class TulovQilishBloc extends Bloc<TulovQilishEvent, TulovQilishState> {
  TulovQilishBloc() : super(TulovQilishInitial()) {
    on<TulovQilishEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
