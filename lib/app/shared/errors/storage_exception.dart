abstract class StorageException implements Exception {
  StorageException(String message);
}

class UserDoesNotExists extends StorageException {
  UserDoesNotExists(String message) : super(message);
}

