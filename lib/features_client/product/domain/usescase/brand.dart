import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:savdo_agnet_client/features_client/product/domain/repositories/catalog_repository.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usescases/usecase.dart';

class ClientBrandCatalog extends UseCase<dynamic, GetBrandParams> {
  final ClientCatalogRepository catalogRepository;

  ClientBrandCatalog({required this.catalogRepository});

  @override
  Future<Either<Failure, dynamic>> call(GetBrandParams params) {
    return catalogRepository.getClientBrand(
        params.productTypeId!, params.priceTypeId!);
  }
}

class GetBrandParams extends Equatable {
  final int? priceTypeId;
  final int? productTypeId;

  const GetBrandParams(
      {required this.priceTypeId, required this.productTypeId});

  @override
  List<Object?> get props => [priceTypeId, productTypeId];
}
