import 'package:ai_chat_bot/features/chat/model/models/chat_message_model.dart';
import 'package:ai_chat_bot/features/chat/model/repositories/message_repository.dart';
import 'package:ai_chat_bot/core/services/gemini_message_service.dart';

class GeminiMessageRepository implements MessageRepository {
  final GeminiMessageService _geminiService;

  GeminiMessageRepository({required GeminiMessageService geminiService})
    : _geminiService = geminiService;

  @override
  Future<ChatMessageModel> sendMessage(List<ChatMessageModel> messages) async {
    return await _geminiService.sendMessage(messages);
  }
}
