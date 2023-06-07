import 'package:dartz/dartz.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';
import 'package:savdo_agnet_client/core/network/network_info.dart';
import 'package:savdo_agnet_client/features/archive_details/data/datasources/details_remote_datasources.dart';

import '../../domain/repositories/details_repository.dart';

class DetailsRepositoryImpl extends DetailsRepository {
  final ArchiveDetailsRemoteDatasource remoteDatasource;
  final NetworkInfo networkInfo;

  DetailsRepositoryImpl({
    required this.remoteDatasource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, dynamic>> getDetails(int? orderId) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDatasource.getDetails(orderId: orderId);
        return Right(result);
      } on ServerFailure {
        return const Left(ServerFailure("Маълумот юкланишда хатолик бўлди"));
      }
    } else {
      return const Left(
          NoConnectionFailure("Интернет билан алоқани қайта текширинг"));
    }
  }
}
