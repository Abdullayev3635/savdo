import 'package:dartz/dartz.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';
import 'package:savdo_agnet_client/core/network/network_info.dart';
import 'package:savdo_agnet_client/features/tulov_turi_dialog/data/datasources/tt_remote_datasource.dart';
import 'package:savdo_agnet_client/features/tulov_turi_dialog/domain/repositories/tulov_turi_repository.dart';

import '../datasources/tt_local_datasource.dart';

class SelectTulovTuriRepositoryImpl extends SelectTulovTuriRepository {
  final SelectTulovTuriLocalDataSourceImpl localDataSourceImpl;
  final SelectTulovTuriRemoteDataSourceImpl remoteDataSourceImpl;
  final NetworkInfo networkInfo;

  SelectTulovTuriRepositoryImpl({
    required this.localDataSourceImpl,
    required this.networkInfo,
    required this.remoteDataSourceImpl,
  });

  @override
  Future<Either<Failure, dynamic>> getTulovTuri() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSourceImpl.getTulovTuri();
        localDataSourceImpl.setSelectTulovTuri(result);
        return Right(result);
      } on ServerFailure {
        return const Left(ServerFailure("Маълумот юкланишда хатолик бўлди"));
      }
    } else {
      try {
        final result = await localDataSourceImpl.getSelectTulovTuri();
        return Right(result);
      } on LocalFailure {
        return const Left(LocalFailure("Маълумот юкланишда хатолик бўлди"));
      }
    }
  }

  @override
  Future<Either<Failure, dynamic>> getTulovTuriLocal() async {
    try {
      final result = await localDataSourceImpl.getSelectTulovTuri();
      return Right(result);
    } on LocalFailure {
      return const Left(LocalFailure("Маълумот юкланишда хатолик бўлди"));
    }
  }
}
