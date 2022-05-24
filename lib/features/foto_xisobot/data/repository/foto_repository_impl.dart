import 'package:dartz/dartz.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';
import 'package:savdo_agnet_client/core/network/network_info.dart';
import 'package:savdo_agnet_client/features/foto_xisobot/data/datasources/foto_remote_datasource.dart';
import 'package:savdo_agnet_client/features/foto_xisobot/domain/repositories/foto_repository.dart';

class FotoRepositoryImpl extends FotoRepository {
  FotoRemoteDataSourceImpl fotoRemoteDataSourceImpl;
  NetworkInfo networkInfo;

  FotoRepositoryImpl({
    required this.fotoRemoteDataSourceImpl,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, dynamic>> sendFoto(
    String? image1,
    String? image2,
    String? image3,
    int customerId,
    int salesAgentId,
    int regionId,
  ) async {
    try {
      final result = await fotoRemoteDataSourceImpl.sendFoto(
        image1 ?? "",
        image2 ?? '',
        image3 ?? '',
        customerId,
        salesAgentId,
        regionId,
      );
      return Right(result);
    } on ServerFailure {
      return const Left(ServerFailure("Маълумот юкланишда хатолик бўлди"));
    }
  }
}
