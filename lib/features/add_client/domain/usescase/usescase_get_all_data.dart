import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';
import 'package:savdo_agnet_client/core/usescases/usecase.dart';
import 'package:savdo_agnet_client/features/add_client/domain/repository/client_repository.dart';

import '../../data/model/add_client_model.dart';

class UsesGetAllData extends UseCase<dynamic, GetAllDataParams> {
  final AddClientRepository clientRepository;

  UsesGetAllData({required this.clientRepository});

  @override
  Future<Either<Failure, dynamic>> call(GetAllDataParams params) {
    return clientRepository.getAllData();
  }
}

class GetAllDataParams extends Equatable {

  @override
  List<Object?> get props => [];
}
