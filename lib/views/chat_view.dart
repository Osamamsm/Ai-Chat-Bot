import 'package:ai_chat_bot/core/di/di.dart';
import 'package:ai_chat_bot/logic/send_message_cubit/send_message_cubit.dart';
import 'package:ai_chat_bot/views/widgets/chat_app_bar.dart';
import 'package:ai_chat_bot/views/widgets/chat_messages_bloc_builder.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SendMessageCubit>(),
      child: const Scaffold(
        backgroundColor: Colors.white,
        appBar: ChatAppBar(),
        body: ChatMessagesBlocBuilder(),
      ),
    );
  }
}
