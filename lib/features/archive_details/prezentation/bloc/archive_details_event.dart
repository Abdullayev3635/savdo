part of 'archive_details_bloc.dart';

@immutable
abstract class ArchiveDetailsEvent {}

class GetArchiveDetailsData extends ArchiveDetailsEvent {
  final int? orderId;

  GetArchiveDetailsData({required this.orderId});
}
