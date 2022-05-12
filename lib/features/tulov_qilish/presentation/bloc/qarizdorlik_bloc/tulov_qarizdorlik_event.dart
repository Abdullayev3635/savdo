part of 'tulov_qarizdorlik_bloc.dart';

@immutable
abstract class TulovQarizdorlikEvent {}

  class TulovClientSelectedEvent extends TulovQarizdorlikEvent {
  final int salesAgentId;
  final int customerId;

  TulovClientSelectedEvent({required this.salesAgentId, required this.customerId});
}