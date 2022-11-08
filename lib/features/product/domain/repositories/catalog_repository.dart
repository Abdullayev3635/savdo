import 'package:dartz/dartz.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';

abstract class CatalogRepository {
  Future<Either<Failure, dynamic>> getCategory();

  Future<Either<Failure, dynamic>> getBrand(int productTypeId, int priceTypeId);

  Future<Either<Failure, dynamic>> getBrandProducts(
      int salesAgentId, int priceTypeId, int brandId, int currency_id);
}
