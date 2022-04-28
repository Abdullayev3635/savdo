import 'package:dartz/dartz.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';
import 'package:savdo_agnet_client/core/network/network_info.dart';
import 'package:savdo_agnet_client/features/buyurtma/domain/repositories/buyurtma_repository.dart';

import '../datasources/buyurtma_remote_datasource.dart';

class BuyurtmaRepositoryImpl extends BuyurtmaRepository {
  final BuyurtmaRemoteDataSourceImpl remoteDataSourceImpl;
  final NetworkInfo networkInfo;

  BuyurtmaRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSourceImpl,
  });

  @override
  Future<Either<Failure, dynamic>> getBuyurtma() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSourceImpl.getBuyurtma();
        return Right(result);
      } on ServerFailure {
        return const Left(ServerFailure("Маълумот юкланишда хатолик бўлди"));
      }
    } else {
      return const Left(
          NoConnectionFailure("Интернет билан алоқани қайта текширинг"));
    }
  }

  @override
  @override
  Future<Either<Failure, dynamic>> getClientDebitCredit(
      int customerId, int salesAgentId) async {
    try {
      final result = await remoteDataSourceImpl.getClientDebitCredit(
          customerId: customerId, salesAgentId: salesAgentId);
      return Right(result);
    } on ServerFailure {
      return const Left(ServerFailure("Маълумот юкланишда хатолик бўлди"));
    }
  }
}
