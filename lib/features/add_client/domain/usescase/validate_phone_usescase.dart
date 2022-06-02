import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';
import 'package:savdo_agnet_client/core/usescases/usecase.dart';
import 'package:savdo_agnet_client/features/add_client/domain/repository/client_repository.dart';

class UsesValidatePhone extends UseCase<dynamic, ValidatePhoneParams> {
  final AddClientRepository clientRepository;

  UsesValidatePhone({required this.clientRepository});

  @override
  Future<Either<Failure, dynamic>> call(ValidatePhoneParams params) {
    return clientRepository.getValidatePhone(params.validatePhone);
  }
}

class ValidatePhoneParams extends Equatable {
  final String validatePhone;

  const ValidatePhoneParams({required this.validatePhone});

  @override
  List<Object?> get props => [];
}
