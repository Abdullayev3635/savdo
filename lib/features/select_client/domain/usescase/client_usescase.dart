import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';
import 'package:savdo_agnet_client/core/usescases/usecase.dart';
import 'package:savdo_agnet_client/features/select_client/domain/repositories/client_repository.dart';

class UsesSelectClient extends UseCase<dynamic, SelectCaAParams> {
  final SelectCaARepository repository;

  UsesSelectClient({required this.repository});

  @override
  Future<Either<Failure, dynamic>> call(SelectCaAParams params) {
    return repository.getSelectClient(params.userId);
  }
}

class SelectCaAParams extends Equatable {
  final int? userId;
  final String? agentId;

  const SelectCaAParams({
    this.userId,
    this.agentId,
  });

  @override
  List<Object?> get props => [userId, agentId];
}
