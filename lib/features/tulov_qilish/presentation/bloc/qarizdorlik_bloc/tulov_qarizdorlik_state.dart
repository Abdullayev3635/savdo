part of 'tulov_qarizdorlik_bloc.dart';

@immutable
abstract class TulovQarizdorlikState {}

class TulovQarizdorlikInitial extends TulovQarizdorlikState {}

class TulovQarizdorlikLoading extends TulovQarizdorlikState {}

class TulovQarizdorlikLoadedState extends TulovQarizdorlikState {
  final List<TulovClientDebitCreditModel> debitList;

  TulovQarizdorlikLoadedState({required this.debitList});
}

class TulovQarizdorlikFail extends TulovQarizdorlikState {
  final String message;

  TulovQarizdorlikFail({required this.message});
}

class TulovCreatedState extends TulovQarizdorlikState {
  final String message;

  TulovCreatedState({required this.message});
}
