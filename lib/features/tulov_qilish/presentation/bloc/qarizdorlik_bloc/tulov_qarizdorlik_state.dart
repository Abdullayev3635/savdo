part of 'tulov_qarizdorlik_bloc.dart';

@immutable
abstract class TulovQarizdorlikState {}

class TulovQarizdorlikInitial extends TulovQarizdorlikState {}

class TulovQarizdorlikLoading extends TulovQarizdorlikState {}

class TulovQarizdorlikLoaded extends TulovQarizdorlikState {
  final List<TulovClientDebitCreditModel> debitList;

  TulovQarizdorlikLoaded({required this.debitList});
}

class TulovQarizdorlikFail extends TulovQarizdorlikState {
  final String message;

  TulovQarizdorlikFail({required this.message});
}
