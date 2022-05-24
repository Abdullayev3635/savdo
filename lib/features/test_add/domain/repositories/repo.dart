import 'package:dartz/dartz.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';

abstract class TestRepository {
  Future<Either<Failure, dynamic>> getTest();
}
