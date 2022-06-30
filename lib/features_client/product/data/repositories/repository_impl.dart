import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:savdo_agnet_client/features/product/data/datasource/product_local_datasources.dart';
import 'package:savdo_agnet_client/features/product/data/datasource/product_remote_datasources.dart';
import 'package:savdo_agnet_client/features/product/domain/repositories/catalog_repository.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';

class CategoryRepositoryImpl extends CatalogRepository {
  final CategoryRemoteDatasourceImpl categoryRemoteDatasourceImpl;
  final CategoryLocalDataSourceImpl categoryLocalDatasourceImpl;
  final NetworkInfo networkInfo;

  CategoryRepositoryImpl(
      {required this.categoryRemoteDatasourceImpl,
      required this.categoryLocalDatasourceImpl,
      required this.networkInfo});

  @override
  Future<Either<Failure, dynamic>> getCategory() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await categoryRemoteDatasourceImpl.getCategory();
        categoryLocalDatasourceImpl.setCategory(result);
     //   log(result.toString());
        return Right(result);
      } on ServerFailure {
        return const Left(ServerFailure("Маълумот юкланишда хатолик бўлди"));
      }
    } else {
      try {
        final result = await categoryLocalDatasourceImpl.getCategory();
        return Right(result);
      } on LocalFailure {
        return const Left(LocalFailure("Маълумот юкланишда хатолик бўлди"));
      }
    }
  }

  @override
  Future<Either<Failure, dynamic>> getBrand(
      int productTypeId, int priceTypeId) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await categoryRemoteDatasourceImpl.getBrand(
            productTypeId: productTypeId, priceTypeId: priceTypeId);
        categoryLocalDatasourceImpl.setBrand(result);
        return Right(result);
      } on ServerFailure {
        return const Left(ServerFailure("Маълумот юкланишда хатолик бўлди"));
      }
    } else {
      try {
        final result = await categoryLocalDatasourceImpl.getBrand();
        return Right(result);
      } on LocalFailure {
        return const Left(LocalFailure("Маълумот юкланишда хатолик бўлди"));
      }
    }
  }

  @override
  Future<Either<Failure, dynamic>> getBrandProducts(
      int salesAgentId, int priceTypeId, int brandId) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await categoryRemoteDatasourceImpl.getBrandProducts(
            salesAgentId: salesAgentId,
            priceTypeId: priceTypeId,
            brandId: brandId);
        categoryLocalDatasourceImpl.setBrandProducts(result);
        return Right(result);
      } on ServerFailure {
        return const Left(ServerFailure("Маълумот юкланишда хатолик бўлди"));
      }
    } else {
      try {
        final result = await categoryLocalDatasourceImpl.getBrandProducts();
        return Right(result);
      } on LocalFailure {
        return const Left(LocalFailure("Маълумот юкланишда хатолик бўлди"));
      }
    }
  }
}
