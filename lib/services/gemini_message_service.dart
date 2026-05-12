import 'dart:convert';

import 'package:ai_chat_bot/data/models/app_exception.dart';
import 'package:ai_chat_bot/data/models/chat_message_model.dart';
import 'package:ai_chat_bot/services/api_client.dart';

import '../data/models/api_error_model.dart';

class GeminiMessageService {
  final ApiClient _apiClient;
  final String _apiKey;

  GeminiMessageService({required ApiClient apiClient, required String apiKey})
    : _apiClient = apiClient,
      _apiKey = apiKey;

  Future<ChatMessageModel> sendMessage(List<ChatMessageModel> messages) async {
    final response = await _apiClient.post(
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-3-flash-preview:generateContent',
      queryParameters: {'key': _apiKey},
      data: {
        'contents': messages.map((m) => m.toJson()).toList(),
        'generationConfig': {
          'thinkingConfig': {'thinkingLevel': 'low'},
        },
      },
    );
    if (response.statusCode != 200) {
      final error = ApiErrorModel.fromJson(jsonDecode(response.data));
      throw AppException(friendlyMessage(error));
    }

    final candidates = response.data['candidates'] as List;

    return ChatMessageModel.fromJson(candidates.first);
  }
}
