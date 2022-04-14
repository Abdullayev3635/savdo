import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';
import 'package:savdo_agnet_client/core/usescases/usecase.dart';

import '../repositories/client_repository.dart';

class UsesSelectAgent extends UseCase<dynamic, SelectAgentParams> {
  final SelectCaARepository agentRepository;

  UsesSelectAgent({required this.agentRepository});

  @override
  Future<Either<Failure, dynamic>> call(SelectAgentParams params) {
    return agentRepository.getSelectAgent(params.agentId);
  }
}

class SelectAgentParams extends Equatable {
  final String agentId;

  const SelectAgentParams({required this.agentId});

  @override
  List<Object?> get props => [agentId];
}
