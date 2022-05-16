import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';
import 'package:savdo_agnet_client/core/usescases/usecase.dart';
import 'package:savdo_agnet_client/features/foto_xisobot/domain/repositories/foto_repository.dart';

class FotoUsesCase extends UseCase<dynamic, FotoParams>{
  FotoRepository fotoRepository;

  FotoUsesCase({required this.fotoRepository});

  @override
  Future<Either<Failure, dynamic>> call(FotoParams params) {
    return fotoRepository.sendFoto();
  }

}

class FotoParams extends Equatable{
 @override
  List<Object?> get props => [];
}