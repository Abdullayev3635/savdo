import 'package:dartz/dartz.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';

abstract class SelectRegionRepository {
  Future<Either<Failure, dynamic>> getRegion();
  Future<Either<Failure, dynamic>> getRegionLocal();
}
