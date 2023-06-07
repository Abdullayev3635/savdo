import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:savdo_agnet_client/features/product_items/domain/repositories/brand_products_repository.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usescases/usecase.dart';

class BrandProductsUsescase extends UseCase<dynamic, GetBrandProductsParams> {
  final BrandProductsRepository brandProducRepository;

  BrandProductsUsescase({required this.brandProducRepository});

  @override
  Future<Either<Failure, dynamic>> call(GetBrandProductsParams params) {
    return brandProducRepository.getBrandProduct(params.salesAgentId!,
        params.priceTypeId!, params.brandId, params.page!, params.name!, params.turi!);
  }
}

class GetBrandProductsParams extends Equatable {
  final int? salesAgentId;
  final int? priceTypeId;
  final int? brandId;
  final int? page;
  final String? name;
  final String? turi;

  const GetBrandProductsParams(
      {required this.priceTypeId,
      required this.salesAgentId,
      required this.page,
      required this.name,
      required this.brandId,
      required this.turi,});

  @override
  List<Object?> get props => [priceTypeId, brandId, salesAgentId];
}
