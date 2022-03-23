// ignore_for_file: must_be_immutable

part of 'firma_cubit.dart';

@immutable
class SearchFirmaItemsState {
  late List<FirmaModel> firma;
  late String? title;
  late int? id;
  TextEditingController? filter = TextEditingController();

  SearchFirmaItemsState({
    this.id,
    this.title,
    required this.firma,
    this.filter,
  });
}
