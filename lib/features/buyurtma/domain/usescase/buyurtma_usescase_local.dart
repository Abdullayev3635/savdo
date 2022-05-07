import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';
import 'package:savdo_agnet_client/core/usescases/usecase.dart';

import '../repositories/buyurtma_repository.dart';

class UsesBuyurtmaLocal extends UseCase<dynamic, BuyurtmaParamsLocal> {
  BuyurtmaRepository repository;

  UsesBuyurtmaLocal({required this.repository});

  @override
  Future<Either<Failure, dynamic>> call(BuyurtmaParamsLocal params) {
    return repository.getBuyurtmaLocal();
  }
}

class BuyurtmaParamsLocal extends Equatable {
  @override
  List<Object?> get props => [];
}
