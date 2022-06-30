import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';
import 'package:savdo_agnet_client/core/usescases/usecase.dart';
import 'package:savdo_agnet_client/features/select_region/domain/repositories/region_repository.dart';

class UsesSelectRegion extends UseCase<dynamic, GetRegionParams> {
  final SelectRegionRepository regionRepository;

  UsesSelectRegion({required this.regionRepository});

  @override
  Future<Either<Failure, dynamic>> call(GetRegionParams params) {
    return regionRepository.getRegion();
  }
}

class GetRegionParams extends Equatable {
  @override
  List<Object?> get props => [];
}
