import 'package:ai_chat_bot/data/models/chat_message_model.dart';
import 'package:material_ui/material_ui.dart';

class BotBubble extends StatelessWidget {
  final ChatMessageModel message;

  const BotBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 8, bottom: 2),
            child: Icon(Icons.smart_toy, color: Color(0xFF2563EB)),
          ),
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: const BoxDecoration(
                color: Color(0xFFF1F1F1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18),
                  bottomLeft: Radius.circular(4),
                  bottomRight: Radius.circular(18),
                ),
              ),
              child: Text(
                message.text,
                style: const TextStyle(
                  color: Color(0xFF1F2937),
                  fontSize: 14.5,
                  height: 1.45,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
