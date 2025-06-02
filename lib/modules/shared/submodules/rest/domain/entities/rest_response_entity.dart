abstract class RestResponseEntity<T> {
  final T? data;
  final int? statusCode;
  final String? statusMessage;

  RestResponseEntity({
    required this.data,
    required this.statusCode,
    required this.statusMessage,
  });
}
