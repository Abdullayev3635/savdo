import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';
import 'package:savdo_agnet_client/core/usescases/usecase.dart';
import 'package:savdo_agnet_client/features/tulov_turi_dialog/domain/repositories/tulov_turi_repository.dart';

class UsesTulovTuri extends UseCase<dynamic, GetTulovTuriParams> {
  final SelectTulovTuriRepository tulovTuriRepository;

  UsesTulovTuri({required this.tulovTuriRepository});

  @override
  Future<Either<Failure, dynamic>> call(GetTulovTuriParams params) {
    return tulovTuriRepository.getTulovTuri();
  }
}

class GetTulovTuriParams extends Equatable {
  @override
  List<Object?> get props => [];
}
