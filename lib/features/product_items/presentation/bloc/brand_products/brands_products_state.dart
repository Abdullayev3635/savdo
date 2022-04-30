part of 'brands_products_bloc.dart';

@immutable
abstract class BrandsProductsState {}

class BrandsProductsInitial extends BrandsProductsState {}

class BrandsProductsLoadingState extends BrandsProductsState {}

class BrandsProductsSuccessState extends BrandsProductsState {
  final List<BrandProductModel> list;

  BrandsProductsSuccessState({required this.list});
}

class BrandsProductsNoInternetState extends BrandsProductsState {}

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
