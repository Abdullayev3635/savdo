import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';
import 'package:savdo_agnet_client/core/usescases/usecase.dart';
import 'package:savdo_agnet_client/features/select_client/domain/repositories/client_repository.dart';

class UsesSelectClient extends UseCase<dynamic, GetClientParams> {
  final SelectCaARepository clientRepository;

  UsesSelectClient({required this.clientRepository});

  @override
  Future<Either<Failure, dynamic>> call(GetClientParams params) {
    return clientRepository.getClient();
  }
}

class GetClientParams extends Equatable {
  @override
  List<Object?> get props => [];
}
