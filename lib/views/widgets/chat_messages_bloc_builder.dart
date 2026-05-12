import 'package:ai_chat_bot/data/models/chat_message_model.dart';
import 'package:ai_chat_bot/logic/send_message_cubit/send_message_cubit.dart';
import 'package:ai_chat_bot/logic/send_message_cubit/send_message_state.dart';
import 'package:ai_chat_bot/views/widgets/chat_input_bar.dart';
import 'package:ai_chat_bot/views/widgets/chat_messages_list_view.dart';
import 'package:ai_chat_bot/views/widgets/failed_chat_messages_list_view.dart';
import 'package:ai_chat_bot/views/widgets/loading_chat_messages_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatMessagesBlocBuilder extends StatefulWidget {
  const ChatMessagesBlocBuilder({super.key});

  @override
  State<ChatMessagesBlocBuilder> createState() =>
      _ChatMessagesBlocBuilderState();
}

class _ChatMessagesBlocBuilderState extends State<ChatMessagesBlocBuilder> {
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

                if (state is SendMessageLoading) {
                  return LoadingChatMessagesListView(
                    scrollController: _scrollController,
                    messages: messages,
                  );
                }
                if (state is SendMessageFailure) {
                  return FailedChatMessagesListView(
                    scrollController: _scrollController,
                    messages: messages,
                    errMessage: state.errorMessage,
                  );
                }
                return ChatMessagesListView(
                  scrollController: _scrollController,
                  messages: messages,
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
