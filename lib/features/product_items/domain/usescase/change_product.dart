import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:savdo_agnet_client/features/product/data/model/product_model_new.dart';
import 'package:savdo_agnet_client/features/product_items/domain/repositories/brand_products_repository.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usescases/usecase.dart';

  class SendChangedProduct extends UseCase<dynamic, ChangedProductsParams> {
  final BrandProductsRepository brandProducRepository;

  SendChangedProduct({required this.brandProducRepository});

  @override
  Future<Either<Failure, dynamic>> call(ChangedProductsParams params) {
    return brandProducRepository.sendChangedProduct(params.productsNew!);
  }
}

class ChangedProductsParams extends Equatable {
  final ProductsNew? productsNew;

  const ChangedProductsParams(
      {required this.productsNew});

  @override
  List<Object?> get props => [productsNew];
}
