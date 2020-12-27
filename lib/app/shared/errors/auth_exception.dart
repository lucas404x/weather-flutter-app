abstract class AuthException implements Exception {
  String code;
  String description;

  AuthException(this.code, this.description);
}

class UserNotFoundException extends AuthException {
  UserNotFoundException(String code, String description)
      : super(code, description);
}

class ConnectionErrorException extends AuthException {
  ConnectionErrorException(String code, String description)
      : super(code, description);
}

class WrongCredentialsException extends AuthException {
  WrongCredentialsException(String code, String description)
      : super(code, description);
}
