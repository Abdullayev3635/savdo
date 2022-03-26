
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:savdo_agnet_client/features/product/domain/repositories/catalog_repository.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usescases/usecase.dart';

class ProductCatalog extends UseCase<dynamic, GetCategoryParams> {
  final CatalogRepository catalogRepository;

  ProductCatalog({required this.catalogRepository});

  @override
  Future<Either<Failure, dynamic>> call(GetCategoryParams params) {
    return catalogRepository.getCatalog();
  }
}

class GetCategoryParams extends Equatable {
  @override
  List<Object?> get props => [];
}
