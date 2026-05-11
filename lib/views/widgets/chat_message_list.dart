import 'package:ai_chat_bot/data/models/chat_message_model.dart';
import 'package:ai_chat_bot/logic/send_message_cubit/send_message_cubit.dart';
import 'package:ai_chat_bot/logic/send_message_cubit/send_message_state.dart';
import 'package:ai_chat_bot/views/widgets/bot_bubble.dart';
import 'package:ai_chat_bot/views/widgets/chat_input_bar.dart';
import 'package:ai_chat_bot/views/widgets/user_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatMessageList extends StatefulWidget {
  const ChatMessageList({super.key});

  @override
  State<ChatMessageList> createState() => _ChatMessageListState();
}

class _ChatMessageListState extends State<ChatMessageList> {
  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SendMessageCubit, SendMessageState>(
      listenWhen: (prev, curr) =>
          curr is SendMessageLoading || curr is SendMessageSuccess,
      listener: (context, state) => _scrollToBottom(),
      child: Column(
        children: [
          Expanded(
            child: BlocBuilder<SendMessageCubit, SendMessageState>(
              builder: (context, state) {
                final List<ChatMessageModel> messages = state.messages;
                return ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final msg = messages[index];
                    return msg.role == MessageRole.user
                        ? UserBubble(message: msg)
                        : BotBubble(message: msg);
                  },
                );
              },
            ),
          ),
          ChatInputBar(),
        ],
      ),
    );
  }
}

