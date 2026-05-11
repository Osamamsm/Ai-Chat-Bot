import 'package:ai_chat_bot/models/chat_message_model.dart';
import 'package:ai_chat_bot/services/api_client.dart';

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

    return ChatMessageModel.fromJson(response.data);
  }
}
