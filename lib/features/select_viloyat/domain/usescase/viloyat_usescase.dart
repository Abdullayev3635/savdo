import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';
import 'package:savdo_agnet_client/core/usescases/usecase.dart';
import 'package:savdo_agnet_client/features/select_viloyat/domain/repositories/viloyat_repository.dart';

class UsesSelectViloyat extends UseCase<dynamic, GetViloyatParams> {
  final SelectViloyatRepository clientRepository;

  UsesSelectViloyat({required this.clientRepository});

  @override
  Future<Either<Failure, dynamic>> call(GetViloyatParams params) {
    return clientRepository.getViloyat();
  }
}

class GetViloyatParams extends Equatable {
  @override
  List<Object?> get props => [];
}
