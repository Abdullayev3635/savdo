
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'buyurtma_event.dart';
part 'buyurtma_state.dart';

  class BuyurtmaBloc extends Bloc<BuyurtmaEvent, BuyurtmaState> {
  BuyurtmaBloc() : super(BuyurtmaInitial()) {
    on<BuyurtmaEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
