import 'package:dartz/dartz.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';
import 'package:savdo_agnet_client/core/network/network_info.dart';
import 'package:savdo_agnet_client/features/select_client/data/datasources/client_remote_datasource.dart';
import 'package:savdo_agnet_client/features/select_client/domain/repositories/client_repository.dart';

import '../datasources/client_local_datasource.dart';

class SelectClientRepositoryImpl extends SelectCaARepository {
  final SelectClientLocalDataSourceImpl localDataSourceImpl;
  final SelectClientRemoteDataSourceImpl remoteDataSourceImpl;
  final NetworkInfo networkInfo;

  SelectClientRepositoryImpl({
    required this.localDataSourceImpl,
    required this.networkInfo,
    required this.remoteDataSourceImpl,
  });

  @override
  Future<Either<Failure, dynamic>> getClient() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSourceImpl.getClient();
        localDataSourceImpl.setSelectClient(result);
        return Right(result);
      } on ServerFailure {
        return const Left(ServerFailure("Маълумот юкланишда хатолик бўлди"));
      }
    } else {
      try {
        final result = await localDataSourceImpl.getSelectClient();
        return Right(result);
      } on LocalFailure {
        return const Left(LocalFailure("Маълумот юкланишда хатолик бўлди"));
      }
    }
  }

  @override
  Future<Either<Failure, dynamic>> getClientLocal() async {
    try {
      final result = await localDataSourceImpl.getSelectClient();
      return Right(result);
    } on LocalFailure {
      return const Left(LocalFailure("Маълумот юкланишда хатолик бўлди"));
    }
  }
}
