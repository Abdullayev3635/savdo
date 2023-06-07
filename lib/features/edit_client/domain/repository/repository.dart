import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';

abstract class EditClientRepository {
  Future<Either<Failure, dynamic>> getEditClient(
      String phone1, String coordinate, int id);
}
