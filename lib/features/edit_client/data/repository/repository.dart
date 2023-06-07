import 'package:dartz/dartz.dart';
import 'package:savdo_agnet_client/core/errors/failures.dart';
import 'package:savdo_agnet_client/features/edit_client/data/datasource/edit_client_remotedatasource.dart';
import 'package:savdo_agnet_client/features/edit_client/domain/repository/repository.dart';

import '../../../../core/network/network_info.dart';

class EditClientRepositoryImpl extends EditClientRepository {
  final EditClientRemoteDatasourceImpl remoteDatasourceImpl;
  final NetworkInfo networkInfo;

  EditClientRepositoryImpl(
      {required this.networkInfo, required this.remoteDatasourceImpl});

  @override
  Future<Either<Failure, dynamic>> getEditClient(
      String phone1, String coordinate, int id) async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await remoteDatasourceImpl.getEditClient(phone1, coordinate, id);
        if(result){
          return Right(result);
        } else {
          return const Left(ServerFailure("Маълумот юкланишда хатолик бўлди"));
        }
      } on ServerFailure {
        return const Left(ServerFailure("Маълумот юкланишда хатолик бўлди"));
      }
    } else {
      return const Left(
          NoConnectionFailure("Интернет билан алоқани қайта текширинг"));
    }
  }
}
