import 'package:dartz/dartz.dart';
import 'package:savdo_agnet_client/features/product/data/datasource/product_local_datasources.dart';
import 'package:savdo_agnet_client/features/product/data/datasource/product_remote_datasources.dart';
import 'package:savdo_agnet_client/features/product/domain/repositories/catalog_repository.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';

class CatalogRepositoryImpl extends CatalogRepository {
  final CatalogRemoteDatasourceImpl homeRemoteDatasourceImpl;
  final CatalogLocalDataSourceImpl homeLocalDatasourceImpl;
  final NetworkInfo networkInfo;

  CatalogRepositoryImpl(
      {required this.homeRemoteDatasourceImpl,
      required this.homeLocalDatasourceImpl,
      required this.networkInfo});

  @override
  Future<Either<Failure, dynamic>> getCatalog() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await homeRemoteDatasourceImpl.getCatalog();
        homeLocalDatasourceImpl.setCatalog(result);
        return Right(result);
      } on ServerFailure {
        return const Left(ServerFailure("Маълумот юкланишда хатолик бўлди"));
      }
    } else {
      try {
        final result = await homeLocalDatasourceImpl.getCatalog();
        return Right(result);
      } on LocalFailure {
        return const Left(ServerFailure("Маълумот юкланишда хатолик бўлди"));
      }
    }
  }
}
