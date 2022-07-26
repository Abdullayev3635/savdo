
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:savdo_agnet_client/features_client/product/domain/repositories/catalog_repository.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usescases/usecase.dart';

class ClientProductCatalog extends UseCase<dynamic, GetCatalogParams> {
  final ClientCatalogRepository catalogRepository;

  ClientProductCatalog({required this.catalogRepository});

  @override
  Future<Either<Failure, dynamic>> call(GetCatalogParams params) {
    return catalogRepository.getClientCategory();
  }
}

class GetCatalogParams extends Equatable {
  @override
  List<Object?> get props => [];
}
