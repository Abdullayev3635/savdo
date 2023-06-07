import 'package:dartz/dartz.dart';
import 'package:savdo_agnet_client/features/product/data/model/product_model_new.dart';
import 'package:savdo_agnet_client/features/product_items/data/datasource/product_remote_datasources.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/brand_products_repository.dart';

class BrandProductsRepositoryImpl extends BrandProductsRepository {
  final BrandProductsRemoteDatasource remoteDatasource;
  final NetworkInfo networkInfo;

  BrandProductsRepositoryImpl(
      {required this.remoteDatasource, required this.networkInfo});

  @override
  Future<Either<Failure, dynamic>> getBrandProduct(int salesAgentId,
      int priceTypeId, int? brandId, int page, String name, String turi) async {
    if (await networkInfo.isConnected) {
      try {
        if (turi == "100") {
          final result = await remoteDatasource.getAllProducts(
              salesAgentId: salesAgentId,
              priceTypeId: priceTypeId,
              page: page,
              name: name,
              brandId: brandId);
          return Right(result);
        } else {
          final result = await remoteDatasource.getBrandProducts(
              salesAgentId: salesAgentId,
              priceTypeId: priceTypeId,
              page: page,
              name: name,
              brandId: brandId);
          return Right(result);
        }
      } on ServerFailure {
        return const Left(ServerFailure("Маълумот юкланишда хатолик бўлди"));
      }
    } else {
      return const Left(
          NoConnectionFailure("Интернет билан алоқани қайта текширинг"));
    }
  }

  @override
  Future<Either<Failure, dynamic>> sendChangedProduct(ProductsNew json) async {
    if (await networkInfo.isConnected) {
      final result = await remoteDatasource.sendChangedProduct(json: json);
      return Right(result);
    } else {
      return const Left(
          NoConnectionFailure("Интернет билан алоқани қайта текширинг"));
    }
  }
}
