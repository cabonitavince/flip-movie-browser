class ImplException implements Exception {
  final String message;
  final int? statusCode;

  ImplException(this.message, {this.statusCode});

  @override
  String toString() {
    return "ImplException: $message${statusCode != null ? " (Status Code: $statusCode)" : ""}";
  }
}