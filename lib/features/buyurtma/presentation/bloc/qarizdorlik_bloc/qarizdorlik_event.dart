part of 'qarizdorlik_bloc.dart';

@immutable
abstract class QarizdorlikEvent {}

class ClientSelectedEvent extends QarizdorlikEvent {
  final int salesAgentId;
  final int customerId;

  ClientSelectedEvent({required this.salesAgentId, required this.customerId});
}