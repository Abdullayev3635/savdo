part of 'brand_bloc.dart';

@immutable
abstract class ClientBrandEvent {}

class BrandInitialEvent extends ClientBrandEvent {}

class GetClientBrandEvent extends ClientBrandEvent {
  final int priceTypeId;
  final int productTypeId;

  GetClientBrandEvent({required this.productTypeId, required this.priceTypeId});
}
