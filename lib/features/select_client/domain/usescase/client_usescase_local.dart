import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';
import 'package:savdo_agnet_client/core/usescases/usecase.dart';

import '../repositories/client_repository.dart';

class UsesClientLocal extends UseCase<dynamic, ClientParamsLocal> {
  SelectCaARepository repository;

  UsesClientLocal({required this.repository});

  @override
  Future<Either<Failure, dynamic>> call(ClientParamsLocal params) {
    return repository.getClientLocal();
  }
}

class ClientParamsLocal extends Equatable {
  @override
  List<Object?> get props => [];
}
