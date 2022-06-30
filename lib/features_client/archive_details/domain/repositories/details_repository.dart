import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';

abstract class DetailsRepository {
  Future<Either<Failure, dynamic>> getDetails(int? orderId);
}
