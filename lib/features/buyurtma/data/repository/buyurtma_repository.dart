import 'package:dartz/dartz.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';
import 'package:savdo_agnet_client/core/network/network_info.dart';
import 'package:savdo_agnet_client/features/buyurtma/data/model/buyurtma_model.dart';
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
  Future<Either<Failure, List<BuyurtmaModel>>> getBuyurtma() {
    // TODO: implement getBuyurtma
    throw UnimplementedError();
  }

}
