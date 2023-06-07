import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usescases/usecase.dart';
import '../repositories/login_repository.dart';

class LoginData extends UseCase<dynamic, LoginParams> {
  final LoginRepository loginRepository;

  LoginData({required this.loginRepository});

  @override
  Future<Either<Failure, dynamic>> call(LoginParams params) {
    return loginRepository.sendLogin(params.tel, params.password);
  }
}

class LoginParams extends Equatable {
  final String tel;
  final String password;

  @override
  List<Object?> get props => [tel, password];

  const LoginParams(this.tel, this.password);
}
