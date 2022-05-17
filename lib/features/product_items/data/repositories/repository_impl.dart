import 'package:dartz/dartz.dart';
import 'package:savdo_agnet_client/features/product_items/data/datasource/product_local_datasources.dart';
import 'package:savdo_agnet_client/features/product_items/data/datasource/product_remote_datasources.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/brand_products_repository.dart';

class BrandProductsRepositoryImpl extends BrandProductsRepository {
  final BrandProductsRemoteDatasource remoteDatasource;
  final BrandProductsLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  BrandProductsRepositoryImpl(
      {required this.remoteDatasource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, dynamic>> getBrandProducts(
      int salesAgentId, int priceTypeId, int brandId) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDatasource.getBrandProducts(
            salesAgentId: salesAgentId,
            priceTypeId: priceTypeId,
            brandId: brandId);
        return Right(result);
      } on ServerFailure {
        return const Left(ServerFailure("Маълумот юкланишда хатолик бўлди"));
      }
    } else {
      return const Left(
          NoConnectionFailure("Интернет билан алоқани қайта текширинг"));
    }
  }

  @override
  Future<Either<Failure, dynamic>> getBrandProductsLocal(
      int salesAgentId, int priceTypeId, int brandId) async {
    try {
      final result = await localDataSource.getCatalog();
      return Right(result);
    } on LocalFailure {
      return const Left(LocalFailure("Маълумот юкланишда хатолик бўлди"));
    }
  }
}
