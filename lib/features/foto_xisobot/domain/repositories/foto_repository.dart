import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';

abstract class FotoRepository {
  Future<Either<Failure, dynamic>> sendFoto(
    String image1,
    String image2,
    String image3,
    int customerId,
    int salesAgentId,
    int regionId,
  );
}
