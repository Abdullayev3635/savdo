part of 'buyurtma_dialog_bloc.dart';

@immutable
abstract class BuyurtmaDialogEvent {}

class ClientSelectedEvent extends BuyurtmaDialogEvent {
  final int id;

  ClientSelectedEvent({required this.id});
}
