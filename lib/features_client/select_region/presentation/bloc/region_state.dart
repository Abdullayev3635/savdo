part of 'region_bloc.dart';

@immutable
abstract class RegionState {}

class SelectRegionInitial extends RegionState {}

class SelectRegionLoading extends RegionState {}

class SelectRegionSuccess extends RegionState {
  final List<RegionModel> list;

  SelectRegionSuccess({required this.list});
}

class SelectRegionNoInternetState extends RegionState {
  final String message;

  SelectRegionNoInternetState({required this.message});
}

class SelectRegionFailureState extends RegionState {
  final String message;

  SelectRegionFailureState({required this.message});
}
