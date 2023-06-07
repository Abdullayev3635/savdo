part of 'archive_bloc.dart';

@immutable
abstract class ArchiveState {}

class ArchiveInitial extends ArchiveState {}

class ArchiveLoadingState extends ArchiveState {}

class ArchiveLoadedState extends ArchiveState {
  final List<ArchiveModel> list;

  ArchiveLoadedState({required this.list});
}

class ArchiveLoadedFailureState extends ArchiveState {
  final String message;

  ArchiveLoadedFailureState({required this.message});
}
