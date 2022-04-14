import 'package:dartz/dartz.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';
import 'package:savdo_agnet_client/core/network/network_info.dart';
import 'package:savdo_agnet_client/features/buyurtma/data/datasources/buyurtma_local_datasource.dart';
import 'package:savdo_agnet_client/features/buyurtma/domain/entity/buyurtma_entity.dart';
import 'package:savdo_agnet_client/features/buyurtma/domain/repositories/buyurtma_repository.dart';

class BuyurtmaRepositoryImpl extends BuyurtmaRepository {
  final BuyurtmaLocalDataSourceImpl localDataSourceImpl;

  // final BuyurtmaRemoteDataSourceImpl remoteDataSourceImpl;
  final NetworkInfo networkInfo;

  BuyurtmaRepositoryImpl({
    required this.localDataSourceImpl,
    required this.networkInfo,
    // required this.remoteDataSourceImpl,
  });

  @override
  Future<Either<Failure, List<BuyurtmaEntity>>> getBuyurtma(int buyurtmaId) {
    // TODO: implement getBuyurtma
    throw UnimplementedError();
  }
//
// @override
// Future<Either<Failure, dynamic>> getBuyurtma(int buyurtmaId) async {
//
//   try {
//     final result = localDataSourceImpl.getBuyurtma(buyurtmaId);
//     return Right(result);
//   } on ServerFailure {
//     return const Left(ServerFailure("Маълумот юкланишда хатолик бўлди"));
//   }
// }
}
