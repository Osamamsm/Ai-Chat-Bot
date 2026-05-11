import 'package:ai_chat_bot/data/models/chat_message_model.dart';
import 'package:ai_chat_bot/views/widgets/bot_bubble.dart';
import 'package:ai_chat_bot/views/widgets/loading_bubble.dart';
import 'package:ai_chat_bot/views/widgets/user_bubble.dart';
import 'package:flutter/material.dart';

class LoadingChatMessagesListView extends StatelessWidget {
  const LoadingChatMessagesListView({
    super.key,
    required ScrollController scrollController,
    required this.messages,
  }) : _scrollController = scrollController;

  final ScrollController _scrollController;
  final List<ChatMessageModel> messages;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      itemCount: messages.length + 1,
      itemBuilder: (context, index) {
        if (index == messages.length) {
          return LoadingBubble();
        }
        final msg = messages[index];
        return msg.role == MessageRole.user
            ? UserBubble(message: msg)
            : BotBubble(message: msg);
      },
    );
  }
}
