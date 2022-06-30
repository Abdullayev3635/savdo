part of 'pass_bloc.dart';

@immutable
abstract class PassState {
  final String message;

  const PassState({required this.message});
}

class PassInitial extends PassState {
  const PassInitial(String pass) : super(message: pass);
}

class PassSuccess extends PassState {
  const PassSuccess(String pass) : super(message: pass);
}

class PassLoading extends PassState {
  const PassLoading(String pass) : super(message: pass);
}

class PassError extends PassState {
  final String errorMessage;

  const PassError({required String message, required this.errorMessage})
      : super(message: message);
}
