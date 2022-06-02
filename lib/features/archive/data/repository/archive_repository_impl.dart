import 'package:dartz/dartz.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';
import 'package:savdo_agnet_client/core/network/network_info.dart';
import 'package:savdo_agnet_client/features/archive/data/datasource/archive_remote_datasource.dart';
import 'package:savdo_agnet_client/features/archive/domain/repository/archive_repository.dart';

class ArchiveRepositoryImpl extends ArchiveRepository {
  final ArchiveRemoteDatasourceImpl remoteDatasourceImpl;
  final NetworkInfo networkInfo;

  ArchiveRepositoryImpl(
      {required this.remoteDatasourceImpl, required this.networkInfo});

  @override
  Future<Either<Failure, dynamic>> getArchive() async {
    try {
      final result = await remoteDatasourceImpl.getArchiveData();
      return Right(result);
    } on ServerFailure {
      return const Left(ServerFailure("Маълумот юкланишда хатолик бўлди"));
    }
  }
}
