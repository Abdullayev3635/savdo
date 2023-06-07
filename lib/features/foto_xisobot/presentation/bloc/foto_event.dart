part of 'foto_bloc.dart';

@immutable
abstract class FotoEvent {}

class SendFotoEvent extends FotoEvent {
  final String? image1;
  final String? image2;
  final String? image3;
  final int customerId;
  final int salesAgentId;
  final int regionId;

  SendFotoEvent(
      {required this.image1,
      required this.image2,
      required this.image3,
      required this.customerId,
      required this.salesAgentId,
      required this.regionId});
}
