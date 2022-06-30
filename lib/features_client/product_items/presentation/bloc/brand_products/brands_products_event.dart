part of 'brands_products_bloc.dart';

@immutable
abstract class BrandsProductsEvent {}

class GetBrandsProductsEvent extends BrandsProductsEvent {
  final int? priceTypeId;
  final int? brandId;
  final int? salesAgentId;
 final int? page;
  final String? name;

  GetBrandsProductsEvent(
      {required this.priceTypeId,
      required this.brandId,
      required this.page,
      required this.name,
      required this.salesAgentId});
}

// class GetBrandsAllProductsEvent extends BrandsProductsEvent {
//   final int? salesAgentId;
//
//   GetBrandsAllProductsEvent({required this.salesAgentId});
// }

class GetSearchProductEvent extends BrandsProductsEvent {
  final String txt;

  GetSearchProductEvent({required this.txt});
}
