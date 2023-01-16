import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';
import 'package:savdo_agnet_client/core/usescases/usecase.dart';
import 'package:savdo_agnet_client/features/select_yuk_beruvchi/domain/repositories/yuk_repository.dart';

class UsesSelectYukBeruvchi extends UseCase<dynamic, GetViloyatParams> {
  final SelectYukBeruvchiRepository clientRepository;

  UsesSelectYukBeruvchi({required this.clientRepository});

  @override
  Future<Either<Failure, dynamic>> call(GetViloyatParams params) {
    return clientRepository.getViloyat();
  }
}

class GetViloyatParams extends Equatable {
  @override
  List<Object?> get props => [];
}
