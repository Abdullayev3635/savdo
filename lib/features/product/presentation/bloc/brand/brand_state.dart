part of 'brand_bloc.dart';

@immutable
abstract class BrandState {}

class BrandInitial extends BrandState {}

class BrandLoadingState extends BrandState {}

class BrandSuccessState extends BrandState {
  final List<BrandModel> list;

  BrandSuccessState({required this.list});
}

class BrandNoInternetState extends BrandState {}

class BrandFailureState extends BrandState {
  final String message;

  BrandFailureState({required this.message});
}
