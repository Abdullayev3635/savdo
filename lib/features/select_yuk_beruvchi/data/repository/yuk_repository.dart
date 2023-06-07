import 'package:dartz/dartz.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';
import 'package:savdo_agnet_client/core/network/network_info.dart';
import 'package:savdo_agnet_client/features/select_yuk_beruvchi/data/datasources/yuk_remote_datasource.dart';
import 'package:savdo_agnet_client/features/select_yuk_beruvchi/domain/repositories/yuk_repository.dart';


class YukBeruvchiRepositoryImpl extends SelectYukBeruvchiRepository {
  final YukRemoteDataSourceImpl remoteDataSourceImpl;
  final NetworkInfo networkInfo;

  YukBeruvchiRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSourceImpl,
  });

  @override
  Future<Either<Failure, dynamic>> getViloyat() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSourceImpl.getViloyat();

        return Right(result);
      } on ServerFailure {
        return const Left(ServerFailure("Маълумот юкланишда хатолик бўлди"));
      }
    } else {
      return const Left(LocalFailure("Маълумот юкланишда хатолик бўлди"));
    }
  }

  @override
  Future<Either<Failure, dynamic>> getViloyatLocal() async {
    try {
      return const Left(LocalFailure("Маълумот юкланишда хатолик бўлди"));
    } on LocalFailure {
      return const Left(LocalFailure("Маълумот юкланишда хатолик бўлди"));
    }
  }
}
