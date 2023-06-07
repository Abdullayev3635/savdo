part of 'brands_products_bloc.dart';

@immutable
abstract class BrandsProductsEvent {}

class GetBrandsProductsEvent extends BrandsProductsEvent {
  final int? priceTypeId;
  final int? brandId;
  final int? salesAgentId;
  final int? page;
  final String? name;
  final String? turi;

  GetBrandsProductsEvent(
      {required this.priceTypeId,
      required this.brandId,
      required this.page,
      required this.name,
      required this.salesAgentId,
      required this.turi});
}

class GetBrandsProductsEventNew extends BrandsProductsEvent {
  final int? priceTypeId;
  final int? brandId;
  final int? salesAgentId;
  final int? page;
  final String? name;
  final String? turi;

  GetBrandsProductsEventNew(
      {required this.priceTypeId,
      required this.brandId,
      required this.page,
      required this.name,
      required this.salesAgentId,
      required this.turi});
}

class GetBrandsProductsEventFilter extends BrandsProductsEvent {
  final String name;

  GetBrandsProductsEventFilter({
    required this.name,
  });
}

class SendNewProducts extends BrandsProductsEvent {
  final VoidCallback onSuccess;
  final ProductsNew json;


  SendNewProducts({
    required this.json,
    required this.onSuccess,
  });
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
