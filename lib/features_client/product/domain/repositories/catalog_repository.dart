import 'package:dartz/dartz.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';

abstract class ClientCatalogRepository {
  Future<Either<Failure, dynamic>> getClientCategory();

  Future<Either<Failure, dynamic>> getClientBrand(int productTypeId, int priceTypeId);

  Future<Either<Failure, dynamic>> getClientBrandProducts(
      int salesAgentId, int priceTypeId, int brandId);
}
