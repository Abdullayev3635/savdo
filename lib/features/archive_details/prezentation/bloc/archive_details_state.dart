part of 'archive_details_bloc.dart';

@immutable
abstract class ArchiveDetailsState {}

class ArchiveDetailsInitial extends ArchiveDetailsState {}

class ArchiveDetailsLoadingState extends ArchiveDetailsState {}

class ArchiveDetailsLoadedState extends ArchiveDetailsState {
  final List<ArchiveDetailsModel> list;

  ArchiveDetailsLoadedState({required this.list});
}

class ArchiveDetailsFailureState extends ArchiveDetailsState {
  final String message;

  ArchiveDetailsFailureState({required this.message});
}
