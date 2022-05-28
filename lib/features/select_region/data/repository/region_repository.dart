import 'package:dartz/dartz.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';
import 'package:savdo_agnet_client/core/network/network_info.dart';
import 'package:savdo_agnet_client/features/select_region/data/datasources/region_remote_datasource.dart';
import 'package:savdo_agnet_client/features/select_region/domain/repositories/region_repository.dart';

import '../datasources/region_local_datasource.dart';

class RegionRepositoryImpl extends SelectRegionRepository {
  final RegionRemoteDatasourceImpl regionRemoteDatasourceImpl;
  final RegionLocalDataSourceImpl localDataSourceImpl;
  final NetworkInfo networkInfo;

  RegionRepositoryImpl(
      {required this.regionRemoteDatasourceImpl,
      required this.localDataSourceImpl,
      required this.networkInfo});

  @override
  Future<Either<Failure, dynamic>> getRegion() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await regionRemoteDatasourceImpl.getRegion();
        localDataSourceImpl.setSelectRegion(result);
        return Right(result);
      } on ServerFailure {
        return const Left(ServerFailure("Маълумот юкланишда хатолик бўлди"));
      }
    } else {
      try {
        final result = await localDataSourceImpl.getSelectRegion();
        return Right(result);
      } on LocalFailure {
        return const Left(LocalFailure("Маълумот юкланишда хатолик бўлди"));
      }
    }
  }

  @override
  Future<Either<Failure, dynamic>> getRegionLocal() async {
    try {
      final result = await localDataSourceImpl.getSelectRegion();
      return Right(result);
    } on LocalFailure {
      return const Left(LocalFailure("Маълумот юкланишда хатолик бўлди"));
    }
  }
}
