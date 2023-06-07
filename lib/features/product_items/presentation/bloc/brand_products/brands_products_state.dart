part of 'brands_products_bloc.dart';

@immutable
abstract class BrandsProductsState {}

class BrandsProductsInitial extends BrandsProductsState {}

class BrandsProductsLoadingState extends BrandsProductsState {
  final List<BrandProductModel> oldProductsList;
  final List<ProductsNew> oldProductsListNew;
  final bool isFirstFetch;

  BrandsProductsLoadingState(
      { this.oldProductsList= const [], required this.isFirstFetch, this.oldProductsListNew = const []});
}

class BrandsProductsSuccessState extends BrandsProductsState {
  final List<BrandProductModel> list;
  final List<ProductsNew> listNew;
  final List<BrandProductModel> rList;
  final List<ProductsNew> rListNew;

  BrandsProductsSuccessState({required this.list, required this.rList,  this.listNew = const [],  this.rListNew = const []});
}

class BrandsProductsNoInternetState extends BrandsProductsState {}

// ignore: must_be_immutable
class BrandsProductsSearchState extends BrandsProductsState {
  late List<BrandProductModel> productList;
  late String? title;
  late int? id;
  TextEditingController? filter = TextEditingController();

  BrandsProductsSearchState({
    this.id,
    this.title,
    required this.productList,
    this.filter,
  });
}

class BrandsProductsFailureState extends BrandsProductsState {
  final String message;

  BrandsProductsFailureState({required this.message});
}
