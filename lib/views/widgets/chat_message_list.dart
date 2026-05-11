import 'package:ai_chat_bot/data/models/chat_message_model.dart';
import 'package:ai_chat_bot/views/widgets/bot_bubble.dart';
import 'package:ai_chat_bot/views/widgets/chat_input_bar.dart';
import 'package:ai_chat_bot/views/widgets/user_bubble.dart';
import 'package:flutter/material.dart';

class ChatMessageList extends StatefulWidget {
  const ChatMessageList({super.key});

  @override
  State<ChatMessageList> createState() => _ChatMessageListState();
}

class _ChatMessageListState extends State<ChatMessageList> {
  final ScrollController _scrollController = ScrollController();

  final List<ChatMessageModel> _messages = [
    ChatMessageModel(
      text: 'Hello chatGPT, how are you today?',
      role: MessageRole.user,
    ),
    ChatMessageModel(
      text: "Hello, i'm fine, how can i help you?",
      role: MessageRole.model,
    ),
    ChatMessageModel(
      text: 'What is the best programming language?',
      role: MessageRole.user,
    ),
    ChatMessageModel(
      text:
          'There are many programming languages in the market that are used in '
          'designing and building websites, various applications and other tasks. '
          'All these languages are popular in their place and in the way they are '
          'used, and many programmers learn and use them.',
      role: MessageRole.model,
    ),
    ChatMessageModel(text: 'So explain to me more', role: MessageRole.user),
    ChatMessageModel(
      text:
          'There are many programming languages in the market that are used in '
          'designing and building websites, various applications and other tasks. '
          'All these languages are popular in their place and in the way they are '
          'used, and many programmers learn and use them.',
      role: MessageRole.model,
    ),
  ];

  void _onSend(String text) {
    setState(() {
      _messages.add(ChatMessageModel(text: text, role: MessageRole.user));
    });
    Future.delayed(const Duration(milliseconds: 100), () {
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
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            itemCount: _messages.length,
            itemBuilder: (context, index) {
              final msg = _messages[index];
              return msg.role == MessageRole.user
                  ? UserBubble(message: msg)
                  : BotBubble(message: msg);
            },
          ),
        ),
        ChatInputBar(onSend: _onSend),
      ],
    );
  }
}
