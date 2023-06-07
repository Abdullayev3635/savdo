part of 'region_bloc.dart';

@immutable
abstract class RegionEvent {}

class GetSelectRegionEvent extends RegionEvent {}

class GetSelectRegionLocalEvent extends RegionEvent {}

class FilterRegionEvent extends RegionEvent {
  final List<RegionModel> list;
  final String text;

  FilterRegionEvent({required this.list, required this.text});
}
