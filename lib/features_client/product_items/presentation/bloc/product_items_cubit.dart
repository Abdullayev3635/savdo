import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../widgets/product_model.dart';


part 'product_items_state.dart';

class ProductItemsCubit extends Cubit<ProductItemsState> {
  // List<OshxonaNomiModel> oshxonaNomiCubit;
  List<Maxsulotlar> maxsulotlarBulimiCubit;
  String? title;
  int? id;
  int? price;
  int? number;
  String? image;
  TextEditingController? filter = TextEditingController();

  ProductItemsCubit(
      {required this.maxsulotlarBulimiCubit,
      // required this.oshxonaNomiCubit,
      this.image,
      this.number,
      this.title,
      this.id})
      : super(ProductItemsState(
          // oshxonaNomi: oshxonaNomiCubit,
          maxsulot: maxsulotlarBulimiCubit,
          id: id,
          title: title,
        ));
  void searchMaxsulot(String query) => emit(ProductItemsState(
      maxsulot: maxsulot_list.where((brand) {
        if (query.isNotEmpty) {
          final titleLower = brand.title.toLowerCase();
          // final oshxonaLower = brand.oshxonaNomi.toLowerCase();
          final searchLower = query.toLowerCase();
          return titleLower.contains(searchLower);
        } else {
          return false;
        }
      }).toList(),
      filter: filter));
}
