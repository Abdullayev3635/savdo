import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';
import 'package:savdo_agnet_client/core/usescases/usecase.dart';
import 'package:savdo_agnet_client/features/add_client/domain/repository/client_repository.dart';

class UsesValidateName extends UseCase<dynamic, ValidateNameParams> {
  final AddClientRepository clientRepository;

  UsesValidateName({required this.clientRepository});

  @override
  Future<Either<Failure, dynamic>> call(ValidateNameParams params) {
    return clientRepository.getValidateName(params.validateName);
  }
}

class ValidateNameParams extends Equatable {
  final String validateName;

  const ValidateNameParams({required this.validateName});

  @override
  List<Object?> get props => [];
}
