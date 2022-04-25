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
    try {
      final result = await remoteDataSourceImpl.getClient();
      return Right(result);
    } on ServerFailure {
      return const Left(ServerFailure("Маълумот юкланишда хатолик бўлди"));
    }
  }
}
