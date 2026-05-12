import 'package:ai_chat_bot/data/models/chat_message_model.dart';
import 'package:ai_chat_bot/logic/send_message_cubit/send_message_cubit.dart';
import 'package:ai_chat_bot/views/widgets/bot_bubble.dart';
import 'package:ai_chat_bot/views/widgets/failure_bubble.dart';
import 'package:ai_chat_bot/views/widgets/user_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FailedChatMessagesListView extends StatelessWidget {
  const FailedChatMessagesListView({
    super.key,
    required this.messages,
    required this.errMessage,
  });

  final List<ChatMessageModel> messages;
  final String errMessage;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final newIndex = messages.length - (index + 1);
        if (index == 0) {
          return FailureBubble(
            message: messages[newIndex].text,
            errorText: errMessage,
            onRetry: context.read<SendMessageCubit>().retry,
          );
        }
        final msg = messages[newIndex];
        return msg.role == MessageRole.user
            ? UserBubble(message: msg)
            : BotBubble(message: msg);
      },
    );
  }
}
