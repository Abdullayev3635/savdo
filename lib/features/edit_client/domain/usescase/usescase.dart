import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';
import 'package:savdo_agnet_client/core/usescases/usecase.dart';
import 'package:savdo_agnet_client/features/edit_client/domain/repository/repository.dart';

class EditClientUsescase extends UseCase<dynamic, EditClientParams> {
  final EditClientRepository repository;

  EditClientUsescase({required this.repository});

  @override
  Future<Either<Failure, dynamic>> call(EditClientParams params) {
    return repository.getEditClient(
        params.phone1!, params.coordinate!, params.id!);
  }
}

class EditClientParams extends Equatable {
  final String? phone1;
  final String? coordinate;
  final int? id;

  const EditClientParams(
      {required this.phone1, required this.coordinate, required this.id});

  @override
  List<Object?> get props => [];
}
