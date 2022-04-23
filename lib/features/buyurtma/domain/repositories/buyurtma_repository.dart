import 'package:dartz/dartz.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';
import 'package:savdo_agnet_client/features/buyurtma/data/model/buyurtma_model.dart';


abstract class BuyurtmaRepository {
  Future<Either<Failure, List<BuyurtmaModel>>> getBuyurtma();
}
