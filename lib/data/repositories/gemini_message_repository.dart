import 'package:ai_chat_bot/data/models/chat_message_model.dart';
import 'package:ai_chat_bot/data/repositories/message_repository.dart';
import 'package:ai_chat_bot/services/gemini_message_service.dart';

class GeminiMessageRepository implements IMessageRepository {
  final GeminiMessageService _geminiService;

  GeminiMessageRepository({required GeminiMessageService geminiService})
      : _geminiService = geminiService;

  @override
  Future<ChatMessageModel> sendMessage(List<ChatMessageModel> messages) async {
    return await _geminiService.sendMessage(messages);
  }
}
