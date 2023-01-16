part of 'yuk_bloc.dart';

@immutable
abstract class ViloyatEvent {}

class GetSelectViloyatEvent extends ViloyatEvent {}


class FilterViloyatEvent extends ViloyatEvent {
  final List<YukBeruvchi> list;
  final String text;

  FilterViloyatEvent({required this.list, required this.text});
}
