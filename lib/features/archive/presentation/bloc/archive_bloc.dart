import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:meta/meta.dart';
import 'package:savdo_agnet_client/features/archive/data/model/archive_model.dart';
import 'package:savdo_agnet_client/features/archive/domain/usescase/archive_usescase.dart';

part 'archive_event.dart';

part 'archive_state.dart';

class ArchiveBloc extends Bloc<ArchiveEvent, ArchiveState> {
  final ArchiveUsescase archiveUsescase;

  ArchiveBloc({required this.archiveUsescase}) : super(ArchiveInitial()) {
    on<GetArchiveEvent>(getArchiveData, transformer: sequential());
  }

  FutureOr<void> getArchiveData(
      GetArchiveEvent event, Emitter<ArchiveState> emit) async {
    final result = await archiveUsescase(ArchiveParams());
    result.fold(
      (failure) => {},
      (r) => {
        if (r.isEmpty)
          emit(ArchiveLoadedFailureState(message: 'Sizda arxivlar yo`q!'))
        else
          emit(ArchiveLoadedState(list: r))
      },
    );
  }
}
