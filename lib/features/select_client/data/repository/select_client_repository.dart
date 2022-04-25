import 'package:dartz/dartz.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';
import 'package:savdo_agnet_client/core/network/network_info.dart';
import 'package:savdo_agnet_client/features/select_client/data/datasources/client_remote_datasource.dart';
import 'package:savdo_agnet_client/features/select_client/domain/repositories/client_repository.dart';

import '../datasources/client_local_datasource.dart';

class SelectCaARepositoryImpl extends SelectCaARepository {
  final SelectClientLocalDataSourceImpl localDataSourceImpl;
  final SelectClientRemoteDataSourceImpl remoteDataSourceImpl;
  final NetworkInfo networkInfo;

  SelectCaARepositoryImpl({
    required this.localDataSourceImpl,
    required this.networkInfo,
    required this.remoteDataSourceImpl,
  });

  @override
  Future<Either<Failure, dynamic>> getSelectAgent(String agentId) async {
    try {
      final result = localDataSourceImpl.getSelectAgent(agentId);
      return Right(result);
    } on ServerFailure {
      return const Left(ServerFailure("Маълумот юкланишда хатолик бўлди"));
    }
  }

  @override
  Future<Either<Failure, dynamic>> getSelectClient() async {
    try {
      final result = remoteDataSourceImpl.getSelectClient();
      return Right(result);
    } on ServerFailure {
      return const Left(ServerFailure("Маълумот юкланишда хатолик бўлди"));
    }
  }

// @override
// Future<Either<Failure, dynamic>> getSelectClient() async {
//   if (await networkInfo.isConnected) {
//     try {
//       final result = await remoteDataSourceImpl.getClient();
//       localDataSourceImpl.setClientLocal(result);
//       return Right(result);
//     } on ServerFailure {
//       return const Left(ServerFailure("Маълумот юкланишда хатолик бўлди"));
//     }
//   } else {
//     final result = localDataSourceImpl.setClientLocal(list)
//   }
// }
}
