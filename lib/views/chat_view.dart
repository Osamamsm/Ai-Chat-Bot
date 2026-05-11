import 'package:ai_chat_bot/data/repositories/gemini_message_repository.dart';
import 'package:ai_chat_bot/logic/send_message_cubit/send_message_cubit.dart';
import 'package:ai_chat_bot/services/api_client.dart';
import 'package:ai_chat_bot/services/gemini_message_service.dart';
import 'package:ai_chat_bot/views/widgets/chat_app_bar.dart';
import 'package:ai_chat_bot/views/widgets/chat_message_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SendMessageCubit(
        GeminiMessageRepository(
          geminiService: GeminiMessageService(
            apiClient: ApiClient(),
            apiKey: const String.fromEnvironment('GEMINI_API_KEY'),
          ),
        ),
      ),
      child: const Scaffold(
        backgroundColor: Colors.white,
        appBar: ChatAppBar(),
        body: ChatMessageList(),
      ),
    );
  }
}
