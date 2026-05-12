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
    required ScrollController scrollController,
    required this.messages,
    required this.errMessage,
  }) : _scrollController = scrollController;

  final ScrollController _scrollController;
  final List<ChatMessageModel> messages;
  final String errMessage;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        if (index == messages.length - 1) {
          return FailureBubble(
            message: messages[index].text,
            errorText: errMessage,
            onRetry: context.read<SendMessageCubit>().retry,
          );
        }
        final msg = messages[index];
        return msg.role == MessageRole.user
            ? UserBubble(message: msg)
            : BotBubble(message: msg);
      },
    );
  }
}
