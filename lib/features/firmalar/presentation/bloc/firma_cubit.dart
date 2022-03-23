import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:savdo_agnet_client/features/firmalar/data/model/firma_model.dart';

part 'firma_state.dart';

class SearchFirmaItemsCubit extends Cubit<SearchFirmaItemsState> {
  List<FirmaModel> maxsulotlarBulimiCubit;
  String? title;
  int? id;
  String? image;
  TextEditingController? filter = TextEditingController();

  SearchFirmaItemsCubit(
      {required this.maxsulotlarBulimiCubit,
      this.image,
      this.title,
      this.id})
      : super(SearchFirmaItemsState(
            firma: maxsulotlarBulimiCubit, id: id, title: title));

  void searchMaxsulot(String query) => emit(SearchFirmaItemsState(
      firma: firma_list.where((brand) {
        // if (query.isNotEmpty) {
          final titleLower = brand.title?.toLowerCase();
          final searchLower = query.toLowerCase();
          return titleLower!.contains(searchLower);
        // } else {
        //   return false;
        // }
      }).toList(),
      filter: filter));
}
