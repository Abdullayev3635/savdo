part of 'viloyat_bloc.dart';

@immutable
abstract class ViloyatEvent {}

class GetSelectViloyatEvent extends ViloyatEvent {}

class GetSelectViloyatLocalEvent extends ViloyatEvent {}

class FilterViloyatEvent extends ViloyatEvent {
  final List<ViloyatModel> list;
  final String text;

  FilterViloyatEvent({required this.list, required this.text});
}
