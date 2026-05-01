import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view_model/cubit/smart_coach_cubit.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view_model/cubit/smart_coach_event.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view_model/cubit/smart_coach_state.dart';
import 'package:super_fitness_app/app/core/router/route_names.dart';

class SmartCoachDrawer extends StatelessWidget {
  const SmartCoachDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF1A1A1A),
      child: Column(
        children: [
          const SafeArea(
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: Text(
                'Previous Conversations',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const Divider(color: Colors.white24, indent: 20, endIndent: 20),
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.deepOrange.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.add, color: Colors.deepOrange, size: 20),
            ),
            title: const Text(
              'Start New Chat',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: () {
              final cubit = context.read<SmartCoachCubit>();
              cubit.doEvent(StartNewChat());
              Navigator.pop(context);
              if (GoRouterState.of(context).matchedLocation !=
                  RouteNames.smartCoachChat) {
                context.push(RouteNames.smartCoachChat, extra: cubit);
              }
            },
          ),
          const Divider(color: Colors.white24, indent: 20, endIndent: 20),
          Expanded(
            child: BlocBuilder<SmartCoachCubit, SmartCoachState>(
              builder: (context, state) {
                final chats = state.chatsResource.data ?? [];
                if (state.chatsResource.isLoading && chats.isEmpty) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.deepOrange),
                  );
                }
                if (chats.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.chat_bubble_outline,
                          color: Colors.white24,
                          size: 48,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'No previous chats',
                          style: TextStyle(color: Colors.white54),
                        ),
                      ],
                    ),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: chats.length,
                  itemBuilder: (context, index) {
                    final chat = chats[index];
                    final isSelected = state.currentChatId == chat['id'];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 4,
                      ),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        tileColor: isSelected
                            ? Colors.deepOrange.withOpacity(0.1)
                            : Colors.transparent,
                        leading: Icon(
                          Icons.chat_bubble_outline,
                          color: isSelected
                              ? Colors.deepOrange
                              : Colors.white54,
                          size: 20,
                        ),
                        title: Text(
                          chat['title'] ?? 'Chat ${chat['id']}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: isSelected
                                ? Colors.deepOrange
                                : Colors.white,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                        onTap: () {
                          final cubit = context.read<SmartCoachCubit>();
                          cubit.doEvent(GetMessagesByChat(chat['id']));
                          Navigator.pop(context);
                          if (GoRouterState.of(context).matchedLocation !=
                              RouteNames.smartCoachChat) {
                            context.push(
                              RouteNames.smartCoachChat,
                              extra: cubit,
                            );
                          }
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
