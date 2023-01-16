part of 'yuk_bloc.dart';

@immutable
abstract class ViloyatState {}

class SelectViloyatInitial extends ViloyatState {}

class SelectViloyatLoading extends ViloyatState {}

class SelectViloyatSuccess extends ViloyatState {
  final List<YukBeruvchi> list;

  SelectViloyatSuccess({required this.list});
}

class SelectViloyatNoInternetState extends ViloyatState {
  final String message;

  SelectViloyatNoInternetState({required this.message});

}

class SelectViloyatFailureState extends ViloyatState {
  final String message;

  SelectViloyatFailureState({required this.message});
}
