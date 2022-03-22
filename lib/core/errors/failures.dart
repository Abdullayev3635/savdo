abstract class Failure {
  final String message;

  const Failure(this.message);
}

class LocalFailure extends Failure {
  const LocalFailure(String message) : super(message);
}

class ServerFailure extends Failure {
  const ServerFailure(String message) : super(message);
}

class NoConnectionFailure extends Failure {
  const NoConnectionFailure(String message) : super(message);
}

class InputFormatterFailure extends Failure {
  const InputFormatterFailure(String message) : super(message);
}
