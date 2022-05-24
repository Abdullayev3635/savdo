import 'package:dartz/dartz.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';
import 'package:savdo_agnet_client/core/network/network_info.dart';
import 'package:savdo_agnet_client/features/buyurtma/data/datasources/buyurtma_locale_datasource.dart';
import 'package:savdo_agnet_client/features/buyurtma/domain/repositories/buyurtma_repository.dart';
import 'package:savdo_agnet_client/features/test_add/data/data_sources/remote.dart';
import 'package:savdo_agnet_client/features/test_add/domain/repositories/repo.dart';

class TestRepositoryImpl extends TestRepository {
  final TestRemoteDataSourceImpl remoteDataSourceImpl;
  final NetworkInfo networkInfo;

  TestRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSourceImpl,
  });

  @override
  Future<Either<Failure, dynamic>> getTest() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSourceImpl.getTest();
        return Right(result);
      } on ServerFailure {
        return const Left(ServerFailure("Маълумот юкланишда хатолик бўлди"));
      }
    } else {
      return const Left(LocalFailure("Маълумот юкланишда хатолик бўлди"));
    }
  }
}