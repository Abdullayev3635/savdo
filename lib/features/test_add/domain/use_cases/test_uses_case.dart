import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';
import 'package:savdo_agnet_client/core/usescases/usecase.dart';
import 'package:savdo_agnet_client/features/test_add/domain/repositories/repo.dart';


class TestBuyurtma extends UseCase<dynamic, TestParams> {
  TestRepository repository;

  TestBuyurtma({required this.repository});

  @override
  Future<Either<Failure, dynamic>> call(TestParams params) {
    return repository.getTest();
  }
}

class TestParams extends Equatable {

  @override
  List<Object?> get props => [];
}
