import 'package:ai_chat_bot/data/models/api_error_model.dart';

class AppException implements Exception {
  final String message;
  const AppException(this.message);
}

String friendlyMessage(ApiErrorModel e) {
  return switch (e.code) {
    400 => 'Invalid request. Please try again.',
    401 => 'Unauthorized. Check your API key.',
    403 => 'Access denied.',
    404 => 'AI model not found. Contact support.',
    429 => 'Too many requests. Slow down a bit.',
    500 || 503 => 'Server error. Try again later.',
    _ => 'Something went wrong. Please try again.',
  };
}
