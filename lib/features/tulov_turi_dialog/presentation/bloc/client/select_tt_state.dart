part of 'select_tt_bloc.dart';

@immutable
abstract class SelectTulovTuriState {}

class SelectTulovTuriInitial extends SelectTulovTuriState {}

class SelectTulovTuriLoading extends SelectTulovTuriState {}

class SelectTulovTuriSuccess extends SelectTulovTuriState {
  final List<TulovTuriModel> list;

  SelectTulovTuriSuccess({required this.list});
}

class SelectTulovTuriNoInternetState extends SelectTulovTuriState {
  final String message;

  SelectTulovTuriNoInternetState({required this.message});

}

class SelectTulovTuriFailureState extends SelectTulovTuriState {
  final String message;

  SelectTulovTuriFailureState({required this.message});
}
