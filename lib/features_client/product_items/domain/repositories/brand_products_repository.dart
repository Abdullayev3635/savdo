import 'package:dartz/dartz.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';

abstract class BrandProductsRepository {
  Future<Either<Failure, dynamic>> getBrandProduct(
      int salesAgentId, int priceTypeId, int? brandId, int page, String name);
}
