import 'package:dartz/dartz.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';

abstract class SelectViloyatRepository {
  Future<Either<Failure, dynamic>> getViloyat();
  Future<Either<Failure, dynamic>> getViloyatLocal();
}
