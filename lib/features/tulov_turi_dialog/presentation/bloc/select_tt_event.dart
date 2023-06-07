part of 'select_tt_bloc.dart';

@immutable
abstract class SelectTulovTuriEvent {}

class GetSelectTulovTuriEvent extends SelectTulovTuriEvent {}

class GetSelectTulovTuriLocalEvent extends SelectTulovTuriEvent {}

class FilterSelectTulovTuriEvent extends SelectTulovTuriEvent {
  final List<TulovTuriModel> list;
  final String text;

  FilterSelectTulovTuriEvent({required this.list, required this.text});
}
