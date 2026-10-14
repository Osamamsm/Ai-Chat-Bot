import 'package:ai_chat_bot/features/chat/model/models/chat_message_model.dart';

abstract class MessageRepository {
  Future<ChatMessageModel> sendMessage(List<ChatMessageModel> messages);
}
