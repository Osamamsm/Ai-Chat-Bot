import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ai_chat_bot/data/models/chat_message_model.dart';
import 'package:ai_chat_bot/data/repositories/message_repository.dart';
import 'package:ai_chat_bot/logic/send_message_cubit/send_message_state.dart';

class SendMessageCubit extends Cubit<SendMessageState> {
  final IMessageRepository _repository;

  /// Internal message history — the single source of truth.
  final List<ChatMessageModel> _messages = [];

  SendMessageCubit(this._repository) : super(const SendMessageInitial());

  Future<void> sendMessage(String text) async {
    _messages.add(ChatMessageModel(text: text, role: MessageRole.user));
    emit(SendMessageLoading(List.unmodifiable(_messages)));

    try {
      final response = await _repository.sendMessage(_messages);
      _messages.add(response);
      emit(SendMessageSuccess(List.unmodifiable(_messages)));
    } catch (e) {
      emit(SendMessageFailure(List.unmodifiable(_messages), e.toString()));
    }
  }
}

