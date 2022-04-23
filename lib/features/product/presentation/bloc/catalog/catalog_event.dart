part of 'catalog_bloc.dart';

@immutable
abstract class CatalogEvent {}

class GetCategory extends CatalogEvent {}


class ChangeColor extends CatalogEvent {
  final List<CatalogModel> list;
  final int index;
  final int count;
  final bool isLarge;

  ChangeColor(this.list, this.index, this.count, this.isLarge);
}
