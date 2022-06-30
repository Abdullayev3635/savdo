import 'package:dartz/dartz.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';

abstract class BuyurtmaRepository {
  Future<Either<Failure, dynamic>> getBuyurtma();

  Future<Either<Failure, dynamic>> getBuyurtmaLocal();

  Future<Either<Failure, dynamic>> getClientDebitCredit(
      int customerId, int salesAgentId);
}
