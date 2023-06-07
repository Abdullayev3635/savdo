import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:meta/meta.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';
import 'package:savdo_agnet_client/features/select_yuk_beruvchi/data/model/yuk_model.dart';
import 'package:savdo_agnet_client/features/select_yuk_beruvchi/domain/usescase/yuk_usescase.dart';


part 'yuk_event.dart';
part 'yuk_state.dart';

class YukBeruvchiBloc extends Bloc<ViloyatEvent, ViloyatState> {
  final UsesSelectYukBeruvchi usesSelectViloyat;
  late List<YukBeruvchi> listOld;

  YukBeruvchiBloc({
    required this.usesSelectViloyat,
  }) : super(SelectViloyatInitial()) {
    on<GetSelectViloyatEvent>(getViloyat, transformer: sequential());
    on<FilterViloyatEvent>(getFilterPart, transformer: sequential());
  }

  FutureOr<void> getViloyat(
      GetSelectViloyatEvent event, Emitter<ViloyatState> emit) async {
    emit(SelectViloyatLoading());
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
                  emit(SelectViloyatLoading())
                  // emit(SelectViloyatSuccess(list: const [])),
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
