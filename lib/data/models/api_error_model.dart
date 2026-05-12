class ApiErrorModel {
  final int code;
  final String message;
  final String status;

  const ApiErrorModel({
    required this.code,
    required this.message,
    required this.status,
  });

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) {
    final error = json['error'] as Map<String, dynamic>;
    return ApiErrorModel(
      code: error['code'] as int,
      message: error['message'] as String,
      status: error['status'] as String,
    );
  }
}