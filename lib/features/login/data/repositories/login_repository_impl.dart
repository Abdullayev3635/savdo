import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/login_repository.dart';
import '../datasources/login_locat_datasources.dart';
import '../datasources/login_remote_datasources.dart';

class LoginRepositoryImpl extends LoginRepository {
  final LoginRemoteDatasourceImpl loginRemoteDatasource;
  final LoginLocalDataSourceImpl loginLocalDatasource;
  final NetworkInfo networkInfo;

  LoginRepositoryImpl(
      {required this.loginRemoteDatasource,
      required this.loginLocalDatasource,
      required this.networkInfo});

  @override
  Future<Either<Failure, dynamic>> sendLogin(
      String tel, String password) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await loginRemoteDatasource.setData(tel, password);
        if (result == "1") {
          return Right(result);
        } else if (result == "0") {
          return Right(result);
        } else {
          try {
            final resultLocal = await loginLocalDatasource.setDataLocal(result);
            return Right(resultLocal);
          } on LocalFailure {
            return const Left(LocalFailure("маълумотлар нотўғри"));
          }
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
