import 'package:ai_chat_bot/features/chat/model/models/chat_message_model.dart';
import 'package:ai_chat_bot/features/chat/view_model/send_message_cubit/send_message_cubit.dart';
import 'package:ai_chat_bot/features/chat/view_model/send_message_cubit/send_message_state.dart';
import 'package:ai_chat_bot/features/chat/view/widgets/widgets/chat_input_bar.dart';
import 'package:ai_chat_bot/features/chat/view/widgets/widgets/chat_messages_list_view.dart';
import 'package:ai_chat_bot/features/chat/view/widgets/widgets/failed_chat_messages_list_view.dart';
import 'package:ai_chat_bot/features/chat/view/widgets/widgets/loading_chat_messages_list_view.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatMessagesBlocBuilder extends StatelessWidget {
  const ChatMessagesBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: BlocBuilder<SendMessageCubit, SendMessageState>(
            builder: (context, state) {
              final List<ChatMessageModel> messages = state.messages;
              if (state is SendMessageLoading) {
                return LoadingChatMessagesListView(messages: messages);
              }
              if (state is SendMessageFailure) {
                return FailedChatMessagesListView(
                  messages: messages,
                  errMessage: state.errorMessage,
                );
              }
              return ChatMessagesListView(messages: messages);
            },
          ),
        ),
        ChatInputBar(),
      ],
    );
  }
}
