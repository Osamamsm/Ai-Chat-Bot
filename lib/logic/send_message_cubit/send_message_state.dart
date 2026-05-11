import 'package:ai_chat_bot/data/models/chat_message_model.dart';

abstract class SendMessageState {
  final List<ChatMessageModel> messages;
  const SendMessageState(this.messages);
}

class SendMessageInitial extends SendMessageState {
  const SendMessageInitial() : super(const []);
}

class SendMessageLoading extends SendMessageState {
  const SendMessageLoading(super.messages);
}

class SendMessageSuccess extends SendMessageState {
  const SendMessageSuccess(super.messages);
}

class SendMessageFailure extends SendMessageState {
  final String errorMessage;

  const SendMessageFailure(super.messages, this.errorMessage);
}

