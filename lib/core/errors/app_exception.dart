sealed class AppException {
  const AppException();
}

final class NetworkException extends AppException {
  const NetworkException();
}

final class TimeoutException extends AppException {
  const TimeoutException();
}

final class UnauthorizedException extends AppException {
  const UnauthorizedException();
}

final class ServerException extends AppException {
  const ServerException({this.message});

  final String? message;
}

final class BaseUrlNotConfiguredException extends AppException {
  const BaseUrlNotConfiguredException();
}

final class UnknownException extends AppException {
  const UnknownException({this.message});

  final String? message;
}
