part of 'catalog_bloc.dart';

@immutable
abstract class CatalogEvent {}

class GetCatalog extends CatalogEvent {}

class ChangeColor extends CatalogEvent {
  final List<CatalogModel> list;
  final int index;
  final bool isLarge;

  ChangeColor(this.list, this.index, this.isLarge);
}
