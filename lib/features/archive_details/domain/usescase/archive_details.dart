import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';
import 'package:savdo_agnet_client/core/usescases/usecase.dart';

import '../repositories/details_repository.dart';

class ArchiveDetailsUsescase extends UseCase<dynamic, GetDetailsParams> {
  final DetailsRepository repository;

  ArchiveDetailsUsescase({required this.repository});

  @override
  Future<Either<Failure, dynamic>> call(GetDetailsParams params) {
    return repository.getDetails(params.details);
  }
}

class GetDetailsParams extends Equatable {
  final int? details;

  const GetDetailsParams({required this.details});

  @override
  List<Object?> get props => [details];
}
