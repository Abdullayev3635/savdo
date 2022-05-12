import 'package:dartz/dartz.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';
import 'package:savdo_agnet_client/core/network/network_info.dart';
import 'package:savdo_agnet_client/features/tulov_qilish/data/datasources/tulov_remote_datasource.dart';
import 'package:savdo_agnet_client/features/tulov_qilish/domain/repositories/tulov_repository.dart';

class TulovRepositoryImpl extends TulovRepository {
  final TulovRemoteDataSourceImpl remoteDataSourceImpl;
  final NetworkInfo networkInfo;

  TulovRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSourceImpl,
  });

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
}
