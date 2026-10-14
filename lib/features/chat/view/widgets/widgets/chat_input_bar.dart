import 'package:ai_chat_bot/features/chat/view_model/send_message_cubit/send_message_cubit.dart';
import 'package:ai_chat_bot/features/chat/view_model/send_message_cubit/send_message_state.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatInputBar extends StatefulWidget {
  const ChatInputBar({super.key});

  @override
  State<ChatInputBar> createState() => _ChatInputBarState();
}

class _ChatInputBarState extends State<ChatInputBar> {
  final TextEditingController _controller = TextEditingController();

  static const Color _primaryBlue = Color(0xFF2563EB);
  static const Color _disabledBlue = Color(0xFF93B4F5);
  static const Color _inputBorderColor = Color(0xFFE0E0E0);

  void _handleSend(BuildContext context) {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    final state = context.read<SendMessageCubit>().state;
    if (state is SendMessageFailure) {
      context.read<SendMessageCubit>().removeLastAndSend(text);
    } else {
      context.read<SendMessageCubit>().sendMessage(text);
    }
    _controller.clear();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SendMessageCubit, SendMessageState>(
      buildWhen: (prev, curr) =>
          (prev is SendMessageLoading) != (curr is SendMessageLoading),
      builder: (context, state) {
        final isLoading = state is SendMessageLoading;

        return Container(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: _inputBorderColor)),
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: _inputBorderColor),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          enabled: !isLoading,
                          decoration: const InputDecoration(
                            hintText: 'Write your message',
                            hintStyle: TextStyle(
                              color: Color(0xFFBDBDBD),
                              fontSize: 14,
                            ),
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 8),
                          ),
                          onSubmitted: isLoading
                              ? null
                              : (_) => _handleSend(context),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.mic_none_rounded,
                          color: Color(0xFFBDBDBD),
                        ),
                        onPressed: () {},
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: isLoading ? null : () => _handleSend(context),
                child: Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: isLoading ? _disabledBlue : _primaryBlue,
                    shape: BoxShape.circle,
                  ),
                  child: isLoading
                      ? const Padding(
                          padding: EdgeInsets.all(12),
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(
                          Icons.send_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
