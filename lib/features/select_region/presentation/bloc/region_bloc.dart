import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:meta/meta.dart';
import 'package:savdo_agnet_client/features/select_region/data/model/region_model.dart';
import 'package:savdo_agnet_client/features/select_region/domain/usescase/region_usescase.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/usescase/region_usescase_local.dart';

part 'region_event.dart';

part 'region_state.dart';

class RegionBloc extends Bloc<RegionEvent, RegionState> {
  final UsesSelectRegion usesSelectRegion;
  final UsesRegionLocal usesRegionLocal;
  late List<RegionModel> listOld;

  RegionBloc({
    required this.usesSelectRegion,
    required this.usesRegionLocal,
  }) : super(SelectRegionInitial()) {
    on<GetSelectRegionEvent>(getRegion, transformer: sequential());
    on<GetSelectRegionLocalEvent>(getRegionLocal, transformer: sequential());
    on<FilterRegionEvent>(getFilterRegion, transformer: sequential());
  }

  FutureOr<void> getRegion(
      GetSelectRegionEvent event, Emitter<RegionState> emit) async {
    emit(SelectRegionLoading());
    // final result = await usesRegionLocal(RegionLocalParams());
    final result = await usesSelectRegion(GetRegionParams());
    result.fold(
        (failure) => {
              if (failure is NoConnectionFailure)
                {emit(SelectRegionNoInternetState(message: ''))}
              else if (failure is ServerFailure)
                {emit(SelectRegionFailureState(message: failure.message))}
            },
        (r) => {
              if (r.isEmpty)
                {
                  emit(SelectRegionLoading())
                  // emit(SelectRegionSuccess(list: const [])),
                }
              else
                {
                  emit(SelectRegionSuccess(list: r)),
                  listOld = r,
                  // log(listOld.length.toString()),
                }
            });
  }

  FutureOr<void> getRegionLocal(
      GetSelectRegionLocalEvent event, Emitter<RegionState> emit) async {
    final result = await usesRegionLocal(RegionLocalParams());
    // final result = await usesSelectRegion(GetRegionParams());
    result.fold(
        (failure) => {
              if (failure is NoConnectionFailure)
                {emit(SelectRegionNoInternetState(message: ''))}
              else if (failure is ServerFailure)
                {emit(SelectRegionFailureState(message: failure.message))}
            },
        (r) => {
              if (r.isEmpty)
                {
                  emit(
                      SelectRegionFailureState(message: "hech narsa yo'q ekan"))
                }
              else
                {
                  emit(SelectRegionSuccess(list: r)),
                  listOld = r,
                  // log(listOld.length.toString()),
                }
            });
  }

  FutureOr<void> getFilterRegion(
      FilterRegionEvent event, Emitter<RegionState> emit) async {
    if (event.text.isEmpty) {
      emit(SelectRegionSuccess(list: listOld));
    } else {
      emit(SelectRegionSuccess(
          list: listOld.where((element) {
        final titleLower = element.name!.toLowerCase();
        final searchLower = event.text.toLowerCase();
        return titleLower.contains(searchLower);
      }).toList()));
    }
  }
}
