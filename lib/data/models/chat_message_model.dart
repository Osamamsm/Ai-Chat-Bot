enum MessageRole { user, model }

class ChatMessageModel {
  final String text;
  final MessageRole role;
  final String? thoughtSignature;

  ChatMessageModel({
    required this.text,
    required this.role,
    this.thoughtSignature,
  });

  Map<String, dynamic> toJson() {
    return {
      'role': role == MessageRole.user ? 'user' : 'model',
      'parts': [
        {
          'text': text,
          if (thoughtSignature != null) 'thoughtSignature': thoughtSignature,
        },
      ],
    };
  }

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    final content = json['content'] ?? json;
    final parts = content['parts'] as List;
    final firstPart = parts.first as Map<String, dynamic>;

    return ChatMessageModel(
      text: firstPart['text'] ?? '',
      role: content['role'] == 'user' ? MessageRole.user : MessageRole.model,
      thoughtSignature: firstPart['thoughtSignature'],
    );
  }
}
