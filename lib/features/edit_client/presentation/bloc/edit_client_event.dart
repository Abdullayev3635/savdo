part of 'edit_client_bloc.dart';

@immutable
abstract class EditClientEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetEditClientEvent extends EditClientEvent {
  final int id;
  final String coordinate;
  final String phone1;

  GetEditClientEvent({
    required this.phone1,
    required this.coordinate,
    required this.id,
  });
}
