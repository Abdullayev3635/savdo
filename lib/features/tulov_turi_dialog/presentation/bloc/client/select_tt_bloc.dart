import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:meta/meta.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';
import 'package:savdo_agnet_client/features/tulov_turi_dialog/data/model/tulov_turi_model.dart';
import 'package:savdo_agnet_client/features/tulov_turi_dialog/domain/usescase/tulov_turi_usescase.dart';
import 'package:savdo_agnet_client/features/tulov_turi_dialog/domain/usescase/tulov_turi_usescase_local.dart';

part 'select_tt_event.dart';

part 'select_tt_state.dart';

class SelectTulovTuriBloc
    extends Bloc<SelectTulovTuriEvent, SelectTulovTuriState> {
  final UsesTulovTuri usesTulovTuri;
  UsesTulovTuriLocal usesTulovTuriLocal;
  late List<TulovTuriModel> listOld;

  SelectTulovTuriBloc({
    required this.usesTulovTuriLocal,
    required this.usesTulovTuri,
  }) : super(SelectTulovTuriInitial()) {
    on<GetSelectTulovTuriEvent>(getClient, transformer: sequential());
    on<GetSelectTulovTuriLocalEvent>(getTulovTuriLocal,
        transformer: sequential());
    on<FilterSelectTulovTuriEvent>(getFilterPart, transformer: sequential());
  }

  FutureOr<void> getClient(
      GetSelectTulovTuriEvent event, Emitter<SelectTulovTuriState> emit) async {
    final result = await usesTulovTuri(GetTulovTuriParams());
    emit(SelectTulovTuriLoading());
    result.fold(
        (failure) => {
              if (failure is NoConnectionFailure)
                {emit(SelectTulovTuriNoInternetState(message: ''))}
              else if (failure is ServerFailure)
                {emit(SelectTulovTuriFailureState(message: failure.message))}
            },
        (r) => {
              if (r.isEmpty)
                {
                  emit(SelectTulovTuriSuccess(list: const [])),
                }
              else
                {
                  emit(SelectTulovTuriSuccess(list: r)),
                  listOld = r,
                  log(listOld.length.toString()),
                }
            });
  }

  FutureOr<void> getTulovTuriLocal(GetSelectTulovTuriLocalEvent event,
      Emitter<SelectTulovTuriState> emit) async {
    final result = await usesTulovTuriLocal(TulovTuriParamsLocal());
    result.fold(
        (failure) => {
              if (failure is NoConnectionFailure)
                {emit(SelectTulovTuriNoInternetState(message: ''))}
              else if (failure is ServerFailure)
                {emit(SelectTulovTuriFailureState(message: failure.message))}
            },
        (r) => {
              if (r.isEmpty)
                {
                  emit(SelectTulovTuriFailureState(
                      message: "hech narsa yo'q ekan"))
                }
              else
                {
                  emit(SelectTulovTuriSuccess(list: r)),
                  listOld = r,
                  log(listOld.length.toString()),
                }
            });
  }

  FutureOr<void> getFilterPart(FilterSelectTulovTuriEvent event,
      Emitter<SelectTulovTuriState> emit) async {
    if (event.text.isEmpty) {
      emit(SelectTulovTuriSuccess(list: listOld));
    } else {
      emit(SelectTulovTuriSuccess(
          list: listOld.where((element) {
        final titleLower = element.name!.toLowerCase();
        final searchLower = event.text.toLowerCase();
        return titleLower.contains(searchLower);
      }).toList()));
    }
  }
}
