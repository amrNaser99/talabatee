
class ServerException implements Exception {
  final String message;

  const ServerException(this.message);

  @override
  String toString() {
    return message;
  }
}

class NetworkException implements Exception {
  final String message;
  final int code;

  NetworkException({required this.message, required this.code});

  @override
  String toString() {
    return 'NetworkException{message: $message, code: $code}';
  }
}

class InternetException implements Exception {
  final String message;

  InternetException({
    required this.message,
  });

  @override
  String toString() {
    return 'NetworkException{message: $message}';
  }
}

class DBException implements Exception {
  final String message;

  const DBException(this.message);

  @override
  String toString() {
    return message;
  }
}

class ValidationException implements Exception {
  final String field;
  final String message;

  ValidationException({required this.field, required this.message});

  @override
  String toString() {
    return 'ValidationException{field: $field, message: $message}';
  }
}

class LoginException implements Exception {
  final String message;
  final int code;

  LoginException({required this.message, required this.code});

  @override
  String toString() {
    return 'LoginException{message: $message, code: $code}';
  }
}

class FileException implements Exception {
  final String message;

  FileException({required this.message});

  @override
  String toString() {
    return 'FileException{message: $message}';
  }
}

class SyncException implements Exception {
  final String message;

  SyncException({required this.message});

  @override
  String toString() {
    return 'SyncException{message: $message}';
  }
}

class DataException implements Exception {
  final String message;

  DataException({required this.message});

  @override
  String toString() {
    return 'DataException{message: $message}';
  }
}

class FireBaseException implements Exception {
  final String message;

  FireBaseException({required this.message});

  @override
  String toString() {
    return 'FireBaseException{message: $message}';
  }
}

class PickCameraException implements Exception {
  final String message;

  PickCameraException({required this.message});

  @override
  String toString() {
    return 'PickCameraException{message: $message}';
  }
}

class RedirectAppSettingsException implements Exception {
  final String message;

  RedirectAppSettingsException({required this.message});

  @override
  String toString() {
    return 'RedirectAppSettingsException{message: $message}';
  }
}

class GeneralException implements Exception {
  final String message;

  GeneralException({required this.message});

  @override
  String toString() {
    return 'GeneralException{message: $message}';
  }
}


class CartException implements Exception {
  final String message;
  CartException(this.message);

  @override
  String toString() => message;
}

class ItemNotFoundException extends CartException {
  ItemNotFoundException(String productId)
      : super("Item with ID $productId not found in cart.");
}

class QuantityUpdateException extends CartException {
  QuantityUpdateException(String message) : super(message);
}
