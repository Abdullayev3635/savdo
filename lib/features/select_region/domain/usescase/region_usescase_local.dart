import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';
import 'package:savdo_agnet_client/core/usescases/usecase.dart';

import '../repositories/region_repository.dart';

class UsesRegionLocal extends UseCase<dynamic, RegionLocalParams> {
  final SelectRegionRepository regionRepository;

  UsesRegionLocal({required this.regionRepository});

  @override
  Future<Either<Failure, dynamic>> call(RegionLocalParams params) {
    return regionRepository.getRegionLocal();
  }
}

class RegionLocalParams extends Equatable {
  @override
  List<Object?> get props => [];
}
