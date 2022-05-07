import 'package:dartz/dartz.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';
import 'package:savdo_agnet_client/core/network/network_info.dart';
import 'package:savdo_agnet_client/features/buyurtma/data/datasources/buyurtma_locale_datasource.dart';
import 'package:savdo_agnet_client/features/buyurtma/domain/repositories/buyurtma_repository.dart';

import '../datasources/buyurtma_remote_datasource.dart';

class BuyurtmaRepositoryImpl extends BuyurtmaRepository {
  final BuyurtmaRemoteDataSourceImpl remoteDataSourceImpl;
  final BuyurtmaLocaleDatasourceImpl localeDatasourceImpl;
  final NetworkInfo networkInfo;

  BuyurtmaRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSourceImpl,
    required this.localeDatasourceImpl,
  });

  @override
  Future<Either<Failure, dynamic>> getBuyurtma() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSourceImpl.getBuyurtma();
        await localeDatasourceImpl.setBuyurtma(result);
        return Right(result);
      } on ServerFailure {
        return const Left(ServerFailure("Маълумот юкланишда хатолик бўлди"));
      }
    } else {
      try {
        final result = await localeDatasourceImpl.getBuyurtma();
        return Right(result);
      } on LocalFailure {
        return const Left(LocalFailure("Маълумот юкланишда хатолик бўлди"));
      }
    }
  }

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

  @override
  Future<Either<Failure, dynamic>> getBuyurtmaLocal() async {
    try {
      final result = await localeDatasourceImpl.getBuyurtma();
      return Right(result);
    } on LocalFailure {
      return const Left(LocalFailure("Маълумот юкланишда хатолик бўлди"));
    }
  }
}
