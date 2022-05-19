import 'package:dartz/dartz.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';

abstract class TulovRepository {
  Future<Either<Failure, dynamic>> getClientDebitCredit(
      int customerId, int salesAgentId);

  Future<Either<Failure, dynamic>> getPayments(
      int customerId,
      int salesAgentId,
      int branchId,
      int currencyValue,
      int paymentTypeId,
      double summa,
      double paymentAmount,
      String description);
}
