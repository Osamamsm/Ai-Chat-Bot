import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ai_chat_bot/data/models/chat_message_model.dart';
import 'package:ai_chat_bot/data/repositories/message_repository.dart';
import 'package:ai_chat_bot/logic/send_message_cubit/send_message_state.dart';

class SendMessageCubit extends Cubit<SendMessageState> {
  final IMessageRepository _repository;

  SendMessageCubit(this._repository) : super(SendMessageInitial());

  Future<void> sendMessage(List<ChatMessageModel> messages) async {
    emit(SendMessageLoading());
    try {
      final response = await _repository.sendMessage(messages);
      emit(SendMessageSuccess(response));
    } catch (e) {
      emit(SendMessageFailure(e.toString()));
    }
  }
}
