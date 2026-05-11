import 'package:ai_chat_bot/models/chat_message_model.dart';

abstract class SendMessageState {
  const SendMessageState();
}

class SendMessageInitial extends SendMessageState {}

class SendMessageLoading extends SendMessageState {}

class SendMessageSuccess extends SendMessageState {
  final ChatMessageModel response;

  const SendMessageSuccess(this.response);
}

class SendMessageFailure extends SendMessageState {
  final String errorMessage;

  const SendMessageFailure(this.errorMessage);
}
