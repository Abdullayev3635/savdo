import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';
import 'package:savdo_agnet_client/core/usescases/usecase.dart';

import '../repositories/tulov_turi_repository.dart';

class UsesTulovTuriLocal extends UseCase<dynamic, TulovTuriParamsLocal> {
  final SelectTulovTuriRepository repository;

  UsesTulovTuriLocal({required this.repository});

  @override
  Future<Either<Failure, dynamic>> call(TulovTuriParamsLocal params) {
    return repository.getTulovTuriLocal();
  }
}

class TulovTuriParamsLocal extends Equatable {
  @override
  List<Object?> get props => [];
}
