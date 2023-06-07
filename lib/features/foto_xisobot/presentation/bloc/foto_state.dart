part of 'foto_bloc.dart';

@immutable
abstract class FotoState {}

class FotoInitial extends FotoState {}

class FotoLoading extends FotoState {}

class FotoLoaded extends FotoState {
  final String message;

  FotoLoaded({required this.message});
}

class FotoFail extends FotoState {
  final String message;

  FotoFail({required this.message});
}
