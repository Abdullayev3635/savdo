part of 'catalog_bloc.dart';


@immutable
abstract class CatalogState {
  final bool isLarge;

  const CatalogState({required this.isLarge});

}

class CatalogInitialState extends CatalogState {
  const CatalogInitialState({required bool isLarge}) : super(isLarge: isLarge);
}

class CatalogLoadingState extends CatalogState {
  const CatalogLoadingState({required bool isLarge}) : super(isLarge: isLarge);
}

class CatalogSuccessState extends CatalogState {
  final List<CatalogModel> list;
  final int selected;


  const CatalogSuccessState(
      {required this.list,
        required this.selected,
        required bool isLarge,
  })
      : super(isLarge: isLarge);
}

class CatalogFailureState extends CatalogState {
  final String message;
  const CatalogFailureState({required bool isLarge, required this.message}) : super(isLarge: isLarge);
}

