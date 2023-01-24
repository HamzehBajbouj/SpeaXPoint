class Failure {
  final String code;
  final String message;
  final String location; // e.g. the class and method where the error occured

  const Failure(
      {required this.code, required this.message, required this.location});

  @override
  String toString() =>
      'Code: $code\n\nMessage: $message\n\nLocation: $location';
}
