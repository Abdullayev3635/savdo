import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/repositories/lock_repositories.dart';
import '../datasources/lock_local_datasources.dart';

class PassRepositoryImpl implements PassRepository {
  final PassLocalDataSourceImpl passLocalDataSource;

  PassRepositoryImpl({required this.passLocalDataSource});

  @override
  Future<Either<Failure, bool>> setCompile(String pass) async {
    try {
      final result = await passLocalDataSource.setCompile(pass);
      return Right(result);
    } on LocalFailure {
      return const Left(ServerFailure("Киритилган пароль нотўғри"));
    }
  }
}
