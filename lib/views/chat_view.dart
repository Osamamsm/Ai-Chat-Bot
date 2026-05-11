import 'package:ai_chat_bot/data/repositories/gemini_message_repository.dart';
import 'package:ai_chat_bot/logic/send_message_cubit/send_message_cubit.dart';
import 'package:ai_chat_bot/services/api_client.dart';
import 'package:ai_chat_bot/services/gemini_message_service.dart';
import 'package:ai_chat_bot/views/widgets/chat_app_bar.dart';
import 'package:ai_chat_bot/views/widgets/chat_message_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});



  @override
  Widget build(BuildContext context) {
    String geminiKey = dotenv.env['GEMINI_API_KEY'] ?? 'default_val';
    return BlocProvider(
      create: (_) => SendMessageCubit(
        GeminiMessageRepository(
          geminiService: GeminiMessageService(
            apiClient: ApiClient(),
            apiKey: geminiKey,
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
