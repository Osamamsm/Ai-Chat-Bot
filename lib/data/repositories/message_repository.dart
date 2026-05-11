import 'package:ai_chat_bot/data/models/chat_message_model.dart';

abstract class IMessageRepository {
  Future<ChatMessageModel> sendMessage(List<ChatMessageModel> messages);
}
