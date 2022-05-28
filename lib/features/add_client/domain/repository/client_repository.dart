import 'package:dartz/dartz.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';
import 'package:savdo_agnet_client/features/add_client/data/model/validate_model.dart';

import '../../data/model/add_client_model.dart';

abstract class AddClientRepository {
  Future<Either<Failure, dynamic>> getClient(AddClientModel clientDataList);

  Future<Either<Failure, dynamic>> getValidateName(String validateName);

  Future<Either<Failure, dynamic>> getValidatePhone(String validatePhone);
}
