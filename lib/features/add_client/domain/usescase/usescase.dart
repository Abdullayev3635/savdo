import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';
import 'package:savdo_agnet_client/core/usescases/usecase.dart';
import 'package:savdo_agnet_client/features/add_client/domain/repository/client_repository.dart';

import '../../data/model/add_client_model.dart';

class UsesAddClient extends UseCase<dynamic, AddClientParams> {
  final AddClientRepository clientRepository;

  UsesAddClient({required this.clientRepository});

  @override
  Future<Either<Failure, dynamic>> call(AddClientParams params) {
    return clientRepository.getClient(params.clientDataList);
  }
}

class AddClientParams extends Equatable {
  final AddClientModel clientDataList;

  const AddClientParams({required this.clientDataList});

  @override
  List<Object?> get props => [];
}
