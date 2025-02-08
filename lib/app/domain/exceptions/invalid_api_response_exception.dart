class InvalidApiResponseException implements Exception {
  final String message;
  final int? statusCode;

  InvalidApiResponseException(this.message, {this.statusCode});

  @override
  String toString() {
    return "InvalidApiResponseException: $message${statusCode != null ? " (Status Code: $statusCode)" : ""}";
  }
}
