import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';

abstract class FotoRepository{
  Future<Either<Failure, dynamic>> sendFoto();
}