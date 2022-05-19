part of 'tulov_qilish_bloc.dart';

@immutable
abstract class TulovQilishEvent {}


class TulovQilishSuccessEvent extends TulovQilishEvent {
  final int customerId;
  final int salesAgentId;
  final int branchId;
  final int currencyValue;
  final int paymentTypeId;
  final int summa;
  final int paymentAmount;
  final String description;

  TulovQilishSuccessEvent({
    required this.salesAgentId,
    required this.customerId,
    required this.branchId,
    required this.currencyValue,
    required this.paymentTypeId,
    required this.summa,
    required this.paymentAmount,
    required this.description,
  });
}
