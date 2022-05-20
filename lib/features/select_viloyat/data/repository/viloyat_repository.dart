import 'package:dartz/dartz.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';
import 'package:savdo_agnet_client/core/network/network_info.dart';
import 'package:savdo_agnet_client/features/select_viloyat/data/datasources/viloyat_remote_datasource.dart';
import 'package:savdo_agnet_client/features/select_viloyat/domain/repositories/viloyat_repository.dart';

import '../datasources/viloyat_local_datasource.dart';

class ViloyatRepositoryImpl extends SelectViloyatRepository {
  final ViloyatLocalDataSourceImpl localDataSourceImpl;
  final ViloyatRemoteDataSourceImpl remoteDataSourceImpl;
  final NetworkInfo networkInfo;

  ViloyatRepositoryImpl({
    required this.localDataSourceImpl,
    required this.networkInfo,
    required this.remoteDataSourceImpl,
  });

  @override
  Future<Either<Failure, dynamic>> getViloyat() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSourceImpl.getViloyat();
        localDataSourceImpl.setSelectViloyat(result);
        return Right(result);
      } on ServerFailure {
        return const Left(ServerFailure("Маълумот юкланишда хатолик бўлди"));
      }
    } else {
      try {
        final result = await localDataSourceImpl.getSelectViloyat();
        return Right(result);
      } on LocalFailure {
        return const Left(LocalFailure("Маълумот юкланишда хатолик бўлди"));
      }
    }
  }

  @override
  Future<Either<Failure, dynamic>> getViloyatLocal() async {
    try {
      final result = await localDataSourceImpl.getSelectViloyat();
      return Right(result);
    } on LocalFailure {
      return const Left(LocalFailure("Маълумот юкланишда хатолик бўлди"));
    }
  }
}
