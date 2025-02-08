class ServiceException implements Exception {
  final String message;
  final int? statusCode;

  ServiceException(this.message, {this.statusCode});

  @override
  String toString() {
    return "ServiceException: $message${statusCode != null ? " (Status Code: $statusCode)" : ""}";
  }
}