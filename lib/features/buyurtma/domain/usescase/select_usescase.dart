import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';
import 'package:savdo_agnet_client/core/usescases/usecase.dart';
import 'package:savdo_agnet_client/features/buyurtma/domain/repositories/buyurtma_repository.dart';


class OnSelectClientUsescase extends UseCase<dynamic, OnSelectedClientParams> {
  final BuyurtmaRepository clientRepository;

  OnSelectClientUsescase({required this.clientRepository});

  @override
  Future<Either<Failure, dynamic>> call(OnSelectedClientParams params) {
    return clientRepository.getClientDebitCredit(params.customerId!, params.salesAgentId!);
  }
}

class OnSelectedClientParams extends Equatable {
  final int? customerId;
  final int? salesAgentId;

  const OnSelectedClientParams({required this.customerId, required this.salesAgentId});

  @override
  List<Object?> get props => [customerId, salesAgentId];
}
