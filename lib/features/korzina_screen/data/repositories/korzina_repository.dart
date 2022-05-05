import 'package:dartz/dartz.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';
import 'package:savdo_agnet_client/core/network/network_info.dart';
import 'package:savdo_agnet_client/features/korzina_screen/data/datasources/korzina_remote_datasources.dart';
import 'package:savdo_agnet_client/features/korzina_screen/data/korzina_hive/korzina_hive.dart';
import 'package:savdo_agnet_client/features/korzina_screen/domain/repositories/i_korzina_repository.dart';

import '../korzina_hive/error_model.dart';

class KorzinaRepositoryImpl extends KorzinaRepository {
  final KorzinaOrderRemoteDatasource remoteDatasource;
  final NetworkInfo networkInfo;

  KorzinaRepositoryImpl({
    required this.remoteDatasource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, dynamic>> sendKorzinaData(
      List<KorzinaCard> card) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDatasource.sendKorzinaData(card: card);
        return Right(result);
      } on ServerFailure {
        return const Left(ServerFailure("Маълумот юкланишда хатолик бўлди"));
      }
    } else {
      return const Left(
          NoConnectionFailure("Интернет билан алоқани қайта текширинг"));
    }
  }
}
