part of 'category_bloc.dart';

@immutable
abstract class ClientCategoryEvent {}

class GetClientCategory extends ClientCategoryEvent {}

class ClientChangeColor extends ClientCategoryEvent {
  final List<ClientCategoryModel> list;
  final int index;
  final int count;
  final bool isLarge;

  ClientChangeColor(this.list, this.index, this.count, this.isLarge);
}
