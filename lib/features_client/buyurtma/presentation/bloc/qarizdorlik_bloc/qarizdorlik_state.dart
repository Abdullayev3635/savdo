part of 'qarizdorlik_bloc.dart';

@immutable
abstract class QarizdorlikState {}

class QarizdorlikInitial extends QarizdorlikState {}

class QarizdorlikLoading extends QarizdorlikState {}

class QarizdorlikLoaded extends QarizdorlikState {
  final List<ClientDebitCreditModel> debitList;

  QarizdorlikLoaded({required this.debitList});
}

class QarizdorlikFail extends QarizdorlikState {
  final String message;

  QarizdorlikFail({required this.message});
}
