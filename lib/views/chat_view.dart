import 'package:ai_chat_bot/views/widgets/chat_app_bar.dart';
import 'package:ai_chat_bot/views/widgets/chat_message_list.dart';
import 'package:flutter/material.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      appBar: ChatAppBar(),
      body: ChatMessageList(),
    );
  }
}
