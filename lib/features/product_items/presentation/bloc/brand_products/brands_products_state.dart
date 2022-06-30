part of 'brands_products_bloc.dart';

@immutable
abstract class BrandsProductsState {}

class BrandsProductsInitial extends BrandsProductsState {}

class BrandsProductsLoadingState extends BrandsProductsState {
  final List<BrandProductModel> oldProductsList;
  final bool isFirstFetch;

  BrandsProductsLoadingState(
      {required this.oldProductsList, required this.isFirstFetch});
}

class BrandsProductsSuccessState extends BrandsProductsState {
  final List<BrandProductModel> list;
  final List<BrandProductModel> rList;

  BrandsProductsSuccessState({required this.list, required this.rList});
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
