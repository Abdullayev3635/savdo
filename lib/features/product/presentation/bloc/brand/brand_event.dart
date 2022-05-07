part of 'brand_bloc.dart';

@immutable
abstract class BrandEvent {}

class BrandInitialEvent extends BrandEvent {}

class GetBrandEvent extends BrandEvent {
  final int priceTypeId;
  final int productTypeId;

  GetBrandEvent({required this.productTypeId, required this.priceTypeId});
}
