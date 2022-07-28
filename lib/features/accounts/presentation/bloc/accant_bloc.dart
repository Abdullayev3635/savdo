import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'accant_event.dart';
part 'accant_state.dart';

class AccantBloc extends Bloc<AccantEvent, AccantState> {
  AccantBloc() : super(AccantInitial()) {
    on<AccantEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
