part of 'category_bloc.dart';

@immutable
abstract class ClientCatalogState {
  final bool isLarge;

  const ClientCatalogState({required this.isLarge});
}

class ClientCatalogInitialState extends ClientCatalogState {
  const ClientCatalogInitialState({required bool isLarge}) : super(isLarge: isLarge);
}

class CatalogLoadingState extends ClientCatalogState {
  const CatalogLoadingState({required bool isLarge}) : super(isLarge: isLarge);
}

class ClientCatalogSuccessState extends ClientCatalogState {
  final List<ClientCategoryModel> list;
  final int selected;
  final int count;

  const ClientCatalogSuccessState({
    required this.list,
    required this.count,
    required this.selected,
    required bool isLarge,
  }) : super(isLarge: isLarge);
}
// class CatalogNoInternetState extends CatalogState{
//   const CatalogNoInternetState({required bool isLarge}) : super(isLarge: isLarge);
// }
class ClientCatalogFailureState extends ClientCatalogState {
  final String message;

  const ClientCatalogFailureState({required bool isLarge, required this.message})
      : super(isLarge: isLarge);
}
