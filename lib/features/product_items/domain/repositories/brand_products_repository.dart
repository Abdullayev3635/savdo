import 'package:dartz/dartz.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';
import 'package:savdo_agnet_client/features/product/data/model/product_model_new.dart';

abstract class BrandProductsRepository {
  Future<Either<Failure, dynamic>> getBrandProduct(
      int salesAgentId, int priceTypeId, int? brandId, int page, String name, String turi);
  Future<Either<Failure, dynamic>> sendChangedProduct(ProductsNew json);
}
