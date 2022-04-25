import 'package:dartz/dartz.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';

abstract class SelectCaARepository {
  Future<Either<Failure, dynamic>> getSelectClient();

  Future<Either<Failure, dynamic>> getSelectAgent(String agentId);
}
