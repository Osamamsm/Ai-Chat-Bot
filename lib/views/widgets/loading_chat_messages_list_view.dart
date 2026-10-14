import 'package:ai_chat_bot/data/models/chat_message_model.dart';
import 'package:ai_chat_bot/views/widgets/bot_bubble.dart';
import 'package:ai_chat_bot/views/widgets/loading_bubble.dart';
import 'package:ai_chat_bot/views/widgets/user_bubble.dart';
import 'package:material_ui/material_ui.dart';

class LoadingChatMessagesListView extends StatelessWidget {
  const LoadingChatMessagesListView({super.key, required this.messages});

  final List<ChatMessageModel> messages;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      itemCount: messages.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return LoadingBubble();
        } else {
          final newIndex = messages.length - index;
          final msg = messages[newIndex];
          return msg.role == MessageRole.user
              ? UserBubble(message: msg)
              : BotBubble(message: msg);
        }
      },
    );
  }
}
