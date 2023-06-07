import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:meta/meta.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';
import 'package:savdo_agnet_client/features/select_viloyat/data/model/viloyat_model.dart';
import 'package:savdo_agnet_client/features/select_viloyat/domain/usescase/viloyat_usescase.dart';
import 'package:savdo_agnet_client/features/select_viloyat/domain/usescase/viloyat_usescase_local.dart';

part 'viloyat_event.dart';
part 'viloyat_state.dart';

class ViloyatBloc extends Bloc<ViloyatEvent, ViloyatState> {
  final UsesSelectViloyat usesSelectViloyat;
  UsesViloyatLocal usesSelectViloyatLocal;
  late List<ViloyatModel> listOld;

  ViloyatBloc({
    required this.usesSelectViloyatLocal,
    required this.usesSelectViloyat,
  }) : super(SelectViloyatInitial()) {
    on<GetSelectViloyatEvent>(getViloyat, transformer: sequential());
    on<GetSelectViloyatLocalEvent>(getViloyatLocal, transformer: sequential());
    on<FilterViloyatEvent>(getFilterPart, transformer: sequential());
  }

    FutureOr<void> getViloyat(
        GetSelectViloyatEvent event, Emitter<ViloyatState> emit) async {
      emit(SelectViloyatLoading());
      final result = await usesSelectViloyatLocal(ViloyatLocalParams());
      // final box = Hive.box(clientBox);
      result.fold(
          (failure) => {
                if (failure is NoConnectionFailure)
                  {emit(SelectViloyatNoInternetState(message: ''))}
                else if (failure is ServerFailure)
                  {emit(SelectViloyatFailureState(message: failure.message))}
              },
          (r) => {
                if (r.isEmpty)
                  {
                    emit(SelectViloyatSuccess(list: const [])),
                  }
                else
                  {
                    emit(SelectViloyatSuccess(list: r)),
                    listOld = r,
                    // log(listOld.length.toString()),
                  }
              });
    }

    FutureOr<void> getViloyatLocal(
        GetSelectViloyatLocalEvent event, Emitter<ViloyatState> emit) async {
      final result = await usesSelectViloyat(GetViloyatParams());
      result.fold(
          (failure) => {
                if (failure is NoConnectionFailure)
                  {emit(SelectViloyatNoInternetState(message: ''))}
                else if (failure is ServerFailure)
                  {emit(SelectViloyatFailureState(message: failure.message))}
              },
          (r) => {
                if (r.isEmpty)
                  {
                    emit(SelectViloyatFailureState(
                        message: "hech narsa yo'q ekan"))
                  }
                else
                  {
                    emit(SelectViloyatSuccess(list: r)),
                    listOld = r,
                    // log(listOld.length.toString()),
                  }
              });
    }

    FutureOr<void> getFilterPart(
        FilterViloyatEvent event, Emitter<ViloyatState> emit) async {
      if (event.text.isEmpty) {
        emit(SelectViloyatSuccess(list: listOld));
      } else {
        emit(SelectViloyatSuccess(
            list: listOld.where((element) {
          final titleLower = element.name!.toLowerCase();
          final searchLower = event.text.toLowerCase();
          return titleLower.contains(searchLower);
        }).toList()));
      }
    }
}
