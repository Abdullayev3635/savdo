import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:meta/meta.dart';
import 'package:savdo_agnet_client/features/foto_xisobot/domain/usescase/foto_xisobot_usescase.dart';

part 'foto_event.dart';

part 'foto_state.dart';

class FotoBloc extends Bloc<FotoEvent, FotoState> {
  FotoUsesCase fotoUsesCase;

  FotoBloc({required this.fotoUsesCase}) : super(FotoInitial()) {
    on<SendFotoEvent>(getResult, transformer: sequential());
  }

  FutureOr<void> getResult(SendFotoEvent event, Emitter<FotoState> emit) async {
    emit(FotoLoading());
    final result = await fotoUsesCase(FotoParams(
      event.image1,
      event.image2,
      event.image3,
      event.customerId,
      event.salesAgentId,
      event.regionId,
    ));

    result.fold(
      (l) => emit(FotoFail(message: l.message)),
      (r) => emit(FotoLoaded(message: r)),
    );
  }
}
