base class ApiBaseModel {
  final int statusCode;
  final String? message;

  const ApiBaseModel({
    this.message,
    required this.statusCode,
  });
}
