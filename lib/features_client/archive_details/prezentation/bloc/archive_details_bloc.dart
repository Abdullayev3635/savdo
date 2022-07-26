import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:meta/meta.dart';
import 'package:savdo_agnet_client/features/archive_details/data/model/archive_details_model.dart';
import 'package:savdo_agnet_client/features/archive_details/domain/usescase/archive_details.dart';

import '../../../../core/errors/failures.dart';

part 'archive_details_event.dart';

part 'archive_details_state.dart';

class ArchiveDetailsBloc
    extends Bloc<ArchiveDetailsEvent, ArchiveDetailsState> {
  final ArchiveDetailsUsescase detailsUsescase;

  ArchiveDetailsBloc({required this.detailsUsescase})
      : super(ArchiveDetailsInitial()) {
    on<GetArchiveDetailsData>(getArchiveDetailsData, transformer: sequential());
  }

  FutureOr<void> getArchiveDetailsData(
      GetArchiveDetailsData event, Emitter<ArchiveDetailsState> emit) async {
    emit(ArchiveDetailsLoadingState());
    final result =
        await detailsUsescase(GetDetailsParams(details: event.orderId));

    result.fold(
        (failure) => {
              if (failure is NoConnectionFailure)
                {emit(ArchiveDetailsFailureState(message: failure.message))}
              else if (failure is ServerFailure)
                {emit(ArchiveDetailsFailureState(message: failure.message))}
            },
        (r) => {emit(ArchiveDetailsLoadedState(list: r))});
  }
}
