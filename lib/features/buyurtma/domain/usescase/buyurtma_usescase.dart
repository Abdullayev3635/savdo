import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';
import 'package:savdo_agnet_client/core/usescases/usecase.dart';

import '../repositories/buyurtma_repository.dart';

class UsesBuyurtma extends UseCase<dynamic, BuyurtmaParams> {
  BuyurtmaRepository repository;

  UsesBuyurtma({required this.repository});

  @override
  Future<Either<Failure, dynamic>> call(BuyurtmaParams params) {
    return repository.getBuyurtma(params.workerId!);
  }
}

class BuyurtmaParams extends Equatable {

  final int? workerId;
  const BuyurtmaParams({required this.workerId});
  @override
  List<Object?> get props => [];
}
