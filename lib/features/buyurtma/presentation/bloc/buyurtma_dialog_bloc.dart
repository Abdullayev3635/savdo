import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'buyurtma_dialog_event.dart';
part 'buyurtma_dialog_state.dart';

class BuyurtmaDialogBloc
    extends Bloc<BuyurtmaDialogEvent, BuyurtmaDialogState> {
  BuyurtmaDialogBloc() : super(BuyurtmaDialogInitialState(qarzdorlik: 10)) {
    on<ClientSelectedEvent>((event, emit) {
      emit(BuyurtmaDialogSelectedSuccessState(qarzdorlik: 1232323230000,kurs: 100));
    });
  }
}
