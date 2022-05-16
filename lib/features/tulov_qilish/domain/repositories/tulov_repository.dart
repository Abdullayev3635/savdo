import 'package:dartz/dartz.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';

abstract class TulovRepository {
  Future<Either<Failure, dynamic>> getClientDebitCredit(
      int customerId, int salesAgentId);
}
