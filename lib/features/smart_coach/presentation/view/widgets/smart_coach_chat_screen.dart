import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view_model/cubit/smart_coach_cubit.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view_model/cubit/smart_coach_event.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view_model/cubit/smart_coach_state.dart';
import 'typing_indicator.dart';
import 'chat_bubble.dart';
import 'smart_coach_drawer.dart';

import 'package:super_fitness_app/features/profile/presentation/view_model/cubit/profile_cubit.dart';
import 'package:super_fitness_app/features/profile/presentation/view_model/cubit/profile_states.dart';

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
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      endDrawer: const SmartCoachDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Navigator.of(context).canPop()
            ? Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 20,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                ),
              )
            : null,
        title: Text(
          'smart_coach'.tr(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              return CircleAvatar(
                radius: 18,
                backgroundColor: Colors.white.withOpacity(0.2),
                backgroundImage: (state.profileData.data?.user?.photo != null)
                    ? NetworkImage(state.profileData.data!.user!.photo!)
                    : const AssetImage('assets/images/prfofle photo .png')
                          as ImageProvider,
              );
            },
          ),
          const SizedBox(width: 8),
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(
                Icons.menu_open,
                color: Colors.deepOrange,
                size: 30,
              ),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/chatbot bg.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.5)),
          ),
          BlocConsumer<SmartCoachCubit, SmartCoachState>(
            listener: (context, state) {
              if (state.messagesResource.isSuccess) {
                _scrollToBottom();
              }
            },
            builder: (context, state) {
              final messages = state.messagesResource.data ?? [];
              final isSending = state.isSendingMessage;
              return Column(
                children: [
                  const SizedBox(height: kToolbarHeight + 40),
                  Expanded(
                    child: BlocBuilder<ProfileCubit, ProfileState>(
                      builder: (context, profileState) {
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
                              photo: profileState.profileData.data?.user?.photo,
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
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                      boxShadow: const [
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
                                        ? 'coach_is_thinking'.tr()
                                        : 'type_a_message'.tr(),
                                    hintStyle: const TextStyle(
                                      color: Colors.white54,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(24),
                                      borderSide: BorderSide.none,
                                    ),
                                    filled: true,
                                    fillColor: Colors.white.withOpacity(0.1),
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
                                          context
                                              .read<SmartCoachCubit>()
                                              .doEvent(SendMessage(text));
                                          _controller.clear();
                                        }
                                      },
                                child: AnimatedOpacity(
                                  duration: const Duration(milliseconds: 200),
                                  opacity: isSending ? 0.5 : 1.0,
                                  child: Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
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
        ],
      ),
    );
  }
}
