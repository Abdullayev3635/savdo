import 'package:dartz/dartz.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';

import '../../data/model/add_client_model.dart';

abstract class AddClientRepository {
  Future<Either<Failure, dynamic>> getClient(List<AddClientModel> clientDataList);
  Future<Either<Failure,dynamic>> getAllData();
}
