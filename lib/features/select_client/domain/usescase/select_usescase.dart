import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';
import 'package:savdo_agnet_client/core/usescases/usecase.dart';
import 'package:savdo_agnet_client/features/select_client/domain/repositories/client_repository.dart';

class OnSelectClient extends UseCase<dynamic, OnSelectedClientParams> {
  final SelectCaARepository clientRepository;

  OnSelectClient({required this.clientRepository});

  @override
  Future<Either<Failure, dynamic>> call(OnSelectedClientParams params) {
    return clientRepository.selectClient(params.customerId!, params.salesAgentId!);
  }
}

class OnSelectedClientParams extends Equatable {
  final int? customerId;
  final int? salesAgentId;

  const OnSelectedClientParams({required this.customerId, required this.salesAgentId});

  @override
  List<Object?> get props => [customerId, salesAgentId];
}
