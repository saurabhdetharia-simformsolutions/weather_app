class ServerFailuresException {

  ServerFailuresException({
    required this.error,
  });

  final Error? error;

  factory ServerFailuresException.parsingException(String errorMessage) {
    return ServerFailuresException(
        error: Error(code: -1, message: errorMessage));
  }
}

class CancelApiException implements Exception {
  Error error;

  CancelApiException({required this.error});
}

class Error implements Exception {
  final int code;
  final String message;
  final String name;

  Error({required this.code, required this.message, this.name = ""});
}
