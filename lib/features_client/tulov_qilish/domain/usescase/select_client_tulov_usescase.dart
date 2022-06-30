import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';
import 'package:savdo_agnet_client/core/usescases/usecase.dart';
import 'package:savdo_agnet_client/features/tulov_qilish/domain/repositories/tulov_repository.dart';

class OnSelectClientTulov
    extends UseCase<dynamic, OnSelectedClientTulovParams> {
  final TulovRepository tulovRepository;

  OnSelectClientTulov({required this.tulovRepository});

  @override
  Future<Either<Failure, dynamic>> call(OnSelectedClientTulovParams params) {
    return tulovRepository.getClientDebitCredit(
        params.customerId!, params.salesAgentId!);
  }
}

class OnSelectedClientTulovParams extends Equatable {
  final int? customerId;
  final int? salesAgentId;

  const OnSelectedClientTulovParams({
    required this.customerId,
    required this.salesAgentId,
  });

  @override
  List<Object?> get props => [customerId, salesAgentId];
}
