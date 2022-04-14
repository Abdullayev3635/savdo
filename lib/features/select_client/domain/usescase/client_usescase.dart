import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';
import 'package:savdo_agnet_client/core/usescases/usecase.dart';
import 'package:savdo_agnet_client/features/select_client/domain/repositories/client_repository.dart';

class UsesSelectClient extends UseCase<dynamic, SelectClientParams> {
  final SelectCaARepository clientRepository;

  UsesSelectClient({required this.clientRepository});

  @override
  Future<Either<Failure, dynamic>> call(SelectClientParams params) {
    return clientRepository.getSelectClient(params.clientId);
  }
}

class SelectClientParams extends Equatable {
  final int clientId;

  const SelectClientParams({required this.clientId});

  @override
  List<Object?> get props => [clientId];
}
