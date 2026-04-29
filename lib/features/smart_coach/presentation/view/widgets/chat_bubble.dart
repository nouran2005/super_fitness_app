import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isUser;
  final bool isError;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isUser,
    this.isError = false,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: isError
              ? Colors.red.withOpacity(0.1)
              : (isUser
                    ? Theme.of(context).colorScheme.primary
                    : const Color(0xFF2C2C2C)),
          border: isError
              ? Border.all(color: Colors.redAccent.withOpacity(0.5))
              : null,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: isUser
                ? const Radius.circular(16)
                : const Radius.circular(0),
            bottomRight: isUser
                ? const Radius.circular(0)
                : const Radius.circular(16),
          ),
        ),
        child: Text(
          message,
          style: TextStyle(
            color: isError ? Colors.redAccent : Colors.white,
            fontSize: 16,
            fontWeight: isError ? FontWeight.w500 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
