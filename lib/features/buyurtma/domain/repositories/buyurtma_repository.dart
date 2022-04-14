import 'package:dartz/dartz.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';
import 'package:savdo_agnet_client/features/buyurtma/domain/entity/buyurtma_entity.dart';

abstract class BuyurtmaRepository {
  Future<Either<Failure, List<BuyurtmaEntity>>> getBuyurtma(int buyurtmaId);
}
