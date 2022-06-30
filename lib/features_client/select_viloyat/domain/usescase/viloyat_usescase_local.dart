import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';
import 'package:savdo_agnet_client/core/usescases/usecase.dart';

import '../repositories/viloyat_repository.dart';

class UsesViloyatLocal extends UseCase<dynamic, ViloyatLocalParams> {
  final SelectViloyatRepository repository;

  UsesViloyatLocal({required this.repository});

  @override
  Future<Either<Failure, dynamic>> call(ViloyatLocalParams params) {
    return repository.getViloyatLocal();
  }
}

class ViloyatLocalParams extends Equatable {
  @override
  List<Object?> get props => [];
}
