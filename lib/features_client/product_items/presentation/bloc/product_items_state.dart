// ignore_for_file: must_be_immutable

part of 'product_items_cubit.dart';

@immutable
class ProductItemsState {
  late List<Maxsulotlar> maxsulot;
  TextEditingController? filter = TextEditingController();

  // late List<OshxonaNomiModel> oshxonaNomi;
  late String? title;
  late int? id;

  ProductItemsState({
    this.id,
    this.title,
    required this.maxsulot,
    this.filter,
  });
}
