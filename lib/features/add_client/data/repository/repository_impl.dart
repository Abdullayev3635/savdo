import 'package:dartz/dartz.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';
import 'package:savdo_agnet_client/core/network/network_info.dart';
import 'package:savdo_agnet_client/features/add_client/data/datasource/add_client_remote_datasource.dart';
import 'package:savdo_agnet_client/features/add_client/domain/repository/client_repository.dart';

import '../model/add_client_model.dart';

class AddClientRepositoryImpl extends AddClientRepository {
  final AddClientRemoteDatasourceImpl remoteDatasource;
  final NetworkInfo networkInfo;

  AddClientRepositoryImpl({
    required this.networkInfo,
    required this.remoteDatasource,
  });

  @override
  Future<Either<Failure, dynamic>> getClient(
      List<AddClientModel> clientDataList) async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            remoteDatasource.addClient(clientDataList: clientDataList);
        return Right(result);
      } on ServerFailure {
        return const Left(ServerFailure("Маълумот юкланишда хатолик бўлди"));
      }
    } else {
      return const Left(
          NoConnectionFailure("Интернет билан алоқани қайта текширинг"));
    }
  }

  @override
  Future<Either<Failure, dynamic>> getAllData() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDatasource.getAllData();
        return Right(result);
      } on ServerFailure {
        return const Left(ServerFailure("Маълумот юкланишда хатолик бўлди"));
      }
    } else {
      return const Left(LocalFailure("Маълумот юкланишда хатолик бўлди"));
    }
  }
}
