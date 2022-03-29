part of 'catalog_bloc.dart';

@immutable
abstract class CatalogState {
  final bool isLarge;

  const CatalogState({required this.isLarge});
}

class ProductInitialState extends CatalogState {
  const ProductInitialState({required bool isLarge}) : super(isLarge: isLarge);
}

class ProductLoadingState extends CatalogState {
  const ProductLoadingState({required bool isLarge}) : super(isLarge: isLarge);
}

class ProductSuccessState extends CatalogState {
  final List<CatalogModel> list;
  final int selected;
  final int count;

  const ProductSuccessState(
      {required this.count,
      required this.list,
      required this.selected,
      required bool isLarge})
      : super(isLarge: isLarge);
}

class ProductSuccessStateLocal extends CatalogState {
  final List<CatalogModel> list;

  const ProductSuccessStateLocal({required this.list, required bool isLarge})
      : super(isLarge: isLarge);
}

class ProductFailureState extends CatalogState {
  const ProductFailureState({required bool isLarge}) : super(isLarge: isLarge);
}
