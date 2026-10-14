import 'package:material_ui/material_ui.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatAppBar({super.key});

  static const Color _primaryBlue = Color(0xFF2563EB);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      titleSpacing: 0,
      centerTitle: true,
      title: Row(
        mainAxisAlignment: .center,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: _primaryBlue,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(Icons.smart_toy, color: Colors.white),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Ai Bot',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
