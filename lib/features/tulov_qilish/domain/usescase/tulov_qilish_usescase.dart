import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';
import 'package:savdo_agnet_client/core/usescases/usecase.dart';
import 'package:savdo_agnet_client/features/tulov_qilish/domain/repositories/tulov_repository.dart';

class OnTulovQilishUsescase extends UseCase<dynamic, OnTulovQilishParams> {
  final TulovRepository tulovRepository;

  OnTulovQilishUsescase({required this.tulovRepository});

  @override
  Future<Either<Failure, dynamic>> call(OnTulovQilishParams params) {
    return tulovRepository.getPayments(
      params.customerId!,
      params.currencyId!,
      params.salesAgentId!,
      params.branchId!,
      params.currencyValue!,
      params.paymentTypeId!,
      params.summa!,
      params.paymentAmount!,
      params.description!,
    );
  }
}

class OnTulovQilishParams extends Equatable {
  final int? customerId;
  final int? salesAgentId;
  final int? branchId;
  final int? currencyValue;
  final int? currencyId;
  final int? paymentTypeId;
  final double? summa;
  final double? paymentAmount;
  final String? description;

  const OnTulovQilishParams({
    required this.customerId,
    required this.currencyId,
    required this.salesAgentId,
    required this.description,
    required this.paymentAmount,
    required this.summa,
    required this.paymentTypeId,
    required this.currencyValue,
    required this.branchId,
  });

  @override
  List<Object?> get props => [
        customerId,
        salesAgentId,
        description,
        paymentAmount,
        summa,
        paymentTypeId,
        currencyValue,
        branchId
      ];
}
