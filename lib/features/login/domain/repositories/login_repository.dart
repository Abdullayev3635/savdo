import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';

abstract class LoginRepository {
  Future<Either<Failure, dynamic>> sendLogin(String tel, String password);
}
