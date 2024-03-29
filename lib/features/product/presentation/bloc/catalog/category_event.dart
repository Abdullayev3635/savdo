part of 'category_bloc.dart';

@immutable
abstract class CategoryEvent {}

class GetCategory extends CategoryEvent {}

class ChangeColor extends CategoryEvent {
  final List<CategoryModel> list;
  final int index;
  final bool isLarge;

  ChangeColor(this.list, this.index, this.isLarge);
}
