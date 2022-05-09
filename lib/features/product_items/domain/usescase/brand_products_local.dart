import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:savdo_agnet_client/features/product/domain/repositories/catalog_repository.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usescases/usecase.dart';

class BrandProductsCatalogLocal extends UseCase<dynamic, GetBrandProductsLocalParams> {
  final CatalogRepository catalogRepository;

  BrandProductsCatalogLocal({required this.catalogRepository});

  @override
  Future<Either<Failure, dynamic>> call(GetBrandProductsLocalParams params) {
    return catalogRepository.getBrandProducts(
        params.salesAgentId!, params.priceTypeId!, params.brandId!);
  }
}

class GetBrandProductsLocalParams extends Equatable {
  final int? salesAgentId;
  final int? priceTypeId;
  final int? brandId;

  const GetBrandProductsLocalParams(
      {required this.priceTypeId,
      required this.salesAgentId,
      required this.brandId});

  @override
  List<Object?> get props => [priceTypeId, brandId, salesAgentId];
}
