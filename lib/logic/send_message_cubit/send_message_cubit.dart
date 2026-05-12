import 'package:ai_chat_bot/data/models/app_exception.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ai_chat_bot/data/models/chat_message_model.dart';
import 'package:ai_chat_bot/data/repositories/message_repository.dart';
import 'package:ai_chat_bot/logic/send_message_cubit/send_message_state.dart';

class SendMessageCubit extends Cubit<SendMessageState> {
  final IMessageRepository _repository;

  final List<ChatMessageModel> _messages = [];

  SendMessageCubit(this._repository) : super(const SendMessageInitial());

  Future<void> sendMessage(String text) async {
    _messages.add(ChatMessageModel(text: text, role: MessageRole.user));
    emit(SendMessageLoading(_messages));

    try {
      final response = await _repository.sendMessage(_messages);
      _messages.add(response);
      emit(SendMessageSuccess(_messages));
    } catch (e) {
      final message = e is AppException ? e.message : 'Something went wrong.';
      emit(SendMessageFailure(_messages, message));
    }
  }
  Future<void> removeLastAndSend(String text) async {
    
  if (_messages.isNotEmpty && _messages.last.role == MessageRole.user) {
    _messages.removeLast();
  }
  await sendMessage(text);
}

  Future<void> retry() async {
    emit(SendMessageLoading(_messages));
    try {
      final response = await _repository.sendMessage(_messages);
      _messages.add(response);
      emit(SendMessageSuccess(_messages));
    } catch (e) {
      final message = e is AppException ? e.message : 'Something went wrong.';
      emit(SendMessageFailure(_messages, message));
    }
  }
}
