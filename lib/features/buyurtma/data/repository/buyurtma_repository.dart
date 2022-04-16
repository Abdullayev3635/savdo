import 'package:dartz/dartz.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';
import 'package:savdo_agnet_client/core/network/network_info.dart';
import 'package:savdo_agnet_client/features/buyurtma/data/datasources/buyurtma_local_datasource.dart';
import 'package:savdo_agnet_client/features/buyurtma/domain/entity/buyurtma_entity.dart';
import 'package:savdo_agnet_client/features/buyurtma/domain/repositories/buyurtma_repository.dart';

import '../datasources/buyurtma_remote_datasource.dart';

class BuyurtmaRepositoryImpl extends BuyurtmaRepository {
  final BuyurtmaLocalDataSourceImpl localDataSourceImpl;
  final BuyurtmaRemoteDataSourceImpl remoteDataSourceImpl;
  final NetworkInfo networkInfo;

  BuyurtmaRepositoryImpl({
    required this.localDataSourceImpl,
    required this.networkInfo,
    required this.remoteDataSourceImpl,
  });

  @override
  Future<Either<Failure, List<BuyurtmaEntity>>> getBuyurtma(int buyurtmaId) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSourceImpl.getBuyurtma(buyurtmaId);
        return Right(result);
      } on ServerFailure {
        return const Left(ServerFailure("Маълумот юкланишда хатолик бўлди"));
      }
    } else {
      try {
        final result = await localDataSourceImpl.getBuyurtma(buyurtmaId);
        return Right(result);
      } on LocalFailure {
        return const Left(ServerFailure("Маълумот юкланишда хатолик бўлди"));
      }
    }
  }
}
