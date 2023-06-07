import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:savdo_agnet_client/features/product/data/datasource/product_local_datasources.dart';
import 'package:savdo_agnet_client/features/product/data/datasource/product_remote_datasources.dart';
import 'package:savdo_agnet_client/features/product/domain/repositories/catalog_repository.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';

class CategoryRepositoryImpl extends CatalogRepository {
  final CategoryRemoteDatasourceImpl categoryRemoteDatasourceImpl;
  // final CategoryLocalDataSourceImpl categoryLocalDatasourceImpl;
  final NetworkInfo networkInfo;

  CategoryRepositoryImpl(
      {required this.categoryRemoteDatasourceImpl,
      // required this.categoryLocalDatasourceImpl,
      required this.networkInfo});

  @override
  Future<Either<Failure, dynamic>> getCategory() async {
    try {
      final result = await categoryRemoteDatasourceImpl.getCategory();
      // categoryLocalDatasourceImpl.setCategory(result);
      //   log(result.toString());
      return Right(result);
    } on ServerFailure {
      return const Left(ServerFailure("Маълумот юкланишда хатолик бўлди"));
    }
    // if (await networkInfo.isConnected) {
    //
    // }
    // else {
    //   Future.delayed(const Duration(milliseconds: 2000), () {
    //     getCategory();
    //   });
    // }
    // return const Left(NoConnectionFailure("Маълумот юкланишда хатолик бўлди"));
  }

  @override
  Future<Either<Failure, dynamic>> getBrand(
      int productTypeId, int priceTypeId) async {
    try {
      final result = await categoryRemoteDatasourceImpl.getBrand(
          productTypeId: productTypeId, priceTypeId: priceTypeId);
      // categoryLocalDatasourceImpl.setBrand(result);
      return Right(result);
    } on ServerFailure {
      return const Left(ServerFailure("Маълумот юкланишда хатолик бўлди"));
    }
    // if (await networkInfo.isConnected) {
    //
    // }
    // else {
    //   await Future.delayed(const Duration(milliseconds: 2000), () {
    //     getBrand(productTypeId, priceTypeId);
    //   });
    // }
    // return const Left(NoConnectionFailure("Маълумот юкланишда хатолик бўлди"));
  }

  @override
  Future<Either<Failure, dynamic>> getBrandProducts(
      int salesAgentId, int priceTypeId, int brandId, int currency_id) async {
    try {
      final result = await categoryRemoteDatasourceImpl.getBrandProducts(
          salesAgentId: salesAgentId,
          priceTypeId: priceTypeId,
          brandId: brandId,
          currency_id: currency_id);
      // categoryLocalDatasourceImpl.setBrandProducts(result);
      return Right(result);
    } on ServerFailure {
      return const Left(ServerFailure("Маълумот юкланишда хатолик бўлди"));
    }
    // if (await networkInfo.isConnected) {
    //
    // }
    // else {
    //   Future.delayed(const Duration(milliseconds: 2000), () {
    //     getBrandProducts(salesAgentId, priceTypeId, brandId);
    //   });
    //   // try {
    //   //   final result = await categoryLocalDatasourceImpl.getBrandProducts();
    //   //   return Right(result);
    //   // } on LocalFailure {
    //   //   return const Left(LocalFailure("Маълумот юкланишда хатолик бўлди"));
    //   // }
    // }
    // return const Left(NoConnectionFailure("Маълумот юкланишда хатолик бўлди"));
  }
}
