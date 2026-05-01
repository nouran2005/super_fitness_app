import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view_model/cubit/smart_coach_cubit.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view_model/cubit/smart_coach_event.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view_model/cubit/smart_coach_state.dart';
import 'typing_indicator.dart';
import 'chat_bubble.dart';
import 'smart_coach_drawer.dart';

class SmartCoachChatScreen extends StatefulWidget {
  const SmartCoachChatScreen({super.key});

  @override
  State<SmartCoachChatScreen> createState() => _SmartCoachChatScreenState();
}

class _SmartCoachChatScreenState extends State<SmartCoachChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      endDrawer: const SmartCoachDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Navigator.of(context).canPop()
            ? IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.deepOrange,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            : null,
        title: const Text(
          'Smart Coach',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu, color: Colors.deepOrange),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            ),
          ),
        ],
      ),
      body: BlocConsumer<SmartCoachCubit, SmartCoachState>(
        listener: (context, state) {
          if (state.messagesResource.isSuccess) {
            _scrollToBottom();
          }
        },
        builder: (context, state) {
          final messages = state.messagesResource.data ?? [];

          return Column(
            children: [
              Expanded(
                child: BlocBuilder<SmartCoachCubit, SmartCoachState>(
                  builder: (context, state) {
                    final messages = state.messagesResource.data ?? [];
                    final isSending = state.isSendingMessage;

                    return ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(16),
                      itemCount:
                          messages.length +
                          (isSending &&
                                  (messages.isEmpty ||
                                      messages.last['role'] != 'bot')
                              ? 1
                              : 0),
                      itemBuilder: (context, index) {
                        if (index == messages.length) {
                          return const TypingIndicator();
                        }
                        final message = messages[index];
                        final isUser = message['role'] == 'user';
                        final isError = message['isError'] == true;

                        return ChatBubble(
                          message: message['content'],
                          isUser: isUser,
                          isError: isError,
                        );
                      },
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: const BoxDecoration(
                  color: Color(0xFF2C2C2C),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, -2),
                    ),
                  ],
                ),
                child: SafeArea(
                  child: BlocBuilder<SmartCoachCubit, SmartCoachState>(
                    builder: (context, state) {
                      final isSending = state.isSendingMessage;
                      return Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _controller,
                              enabled: !isSending,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: isSending
                                    ? 'Coach is thinking...'
                                    : 'Type a message...',
                                hintStyle: const TextStyle(
                                  color: Colors.white54,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(24),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: const Color(0xFF3C3C3C),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 12,
                                ),
                              ),
                              onSubmitted: (text) {
                                if (text.trim().isNotEmpty && !isSending) {
                                  context.read<SmartCoachCubit>().doEvent(
                                    SendMessage(text),
                                  );
                                  _controller.clear();
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: isSending
                                ? null
                                : () {
                                    final text = _controller.text.trim();
                                    if (text.isNotEmpty) {
                                      context.read<SmartCoachCubit>().doEvent(
                                        SendMessage(text),
                                      );
                                      _controller.clear();
                                    }
                                  },
                            child: AnimatedOpacity(
                              duration: const Duration(milliseconds: 200),
                              opacity: isSending ? 0.5 : 1.0,
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: const BoxDecoration(
                                  color: Colors.deepOrange,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.send,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
