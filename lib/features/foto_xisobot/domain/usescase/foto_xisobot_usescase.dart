import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';
import 'package:savdo_agnet_client/core/usescases/usecase.dart';
import 'package:savdo_agnet_client/features/foto_xisobot/domain/repositories/foto_repository.dart';

class FotoUsesCase extends UseCase<dynamic, FotoParams> {
  FotoRepository fotoRepository;

  FotoUsesCase({required this.fotoRepository});

  @override
  Future<Either<Failure, dynamic>> call(FotoParams params) {
    return fotoRepository.sendFoto(
      params.image1!,
      params.image2!,
      params.image3!,
      params.customerId!,
      params.salesAgentId!,
      params.regionId!,
    );
  }
}

class FotoParams extends Equatable {
  final String? image1;
  final String? image2;
  final String? image3;
  final int? customerId;
  final int? salesAgentId;
  final int? regionId;

  const FotoParams(
    this.image1,
    this.image2,
    this.image3,
    this.customerId,
    this.salesAgentId,
    this.regionId,
  );

  @override
  List<Object?> get props => [
        image1,
        image2,
        image3,
        customerId,
        salesAgentId,
        regionId,
      ];
}
