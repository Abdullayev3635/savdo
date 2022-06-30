import 'package:dartz/dartz.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';

abstract class SelectTulovTuriRepository {
  Future<Either<Failure, dynamic>> getTulovTuri();

  Future<Either<Failure, dynamic>> getTulovTuriLocal();
}
