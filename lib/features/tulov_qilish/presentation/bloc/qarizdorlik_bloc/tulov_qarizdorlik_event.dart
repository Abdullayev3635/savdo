part of 'tulov_qarizdorlik_bloc.dart';

@immutable
abstract class TulovQarizdorlikEvent {}

class TulovClientSelectedEvent extends TulovQarizdorlikEvent {
  final int salesAgentId;
  final int customerId;

  TulovClientSelectedEvent(
      {required this.salesAgentId, required this.customerId});
}

class TulovQilishEvent extends TulovQarizdorlikEvent {
  final int customerId;
  final int currencyId;
  final int salesAgentId;
  final int branchId;
  final int currencyValue;
  final int paymentTypeId;
  final double summa;
  final double paymentAmount;
  final String description;

  TulovQilishEvent({
    required this.salesAgentId,
    required this.customerId,
    required this.currencyId,
    required this.branchId,
    required this.currencyValue,
    required this.paymentTypeId,
    required this.summa,
    required this.paymentAmount,
    required this.description,
  });
}
