part of 'edit_client_bloc.dart';

@immutable
abstract class EditClientEvent {}

class GetEditClientEvent extends EditClientEvent {
  int id;
  String coordinate;
  String phone1;

  GetEditClientEvent({
    required this.phone1,
    required this.coordinate,
    required this.id,
  });
}
