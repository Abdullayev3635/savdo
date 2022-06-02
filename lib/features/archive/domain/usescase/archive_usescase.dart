import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';
import 'package:savdo_agnet_client/core/usescases/usecase.dart';
import 'package:savdo_agnet_client/features/archive/domain/repository/archive_repository.dart';

class ArchiveUsescase extends UseCase<dynamic, ArchiveParams> {
  final ArchiveRepository archiveRepository;

  ArchiveUsescase({required this.archiveRepository});

  @override
  Future<Either<Failure, dynamic>> call(ArchiveParams params) {
    return archiveRepository.getArchive();
  }
}

class ArchiveParams extends Equatable {
  @override
  List<Object?> get props => [];
}
