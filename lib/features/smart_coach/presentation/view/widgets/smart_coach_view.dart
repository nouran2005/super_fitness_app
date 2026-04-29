import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view_model/cubit/smart_coach_cubit.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view_model/cubit/smart_coach_state.dart';
import 'smart_coach_start_screen.dart';
import 'smart_coach_chat_screen.dart';

class SmartCoachView extends StatelessWidget {
  const SmartCoachView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SmartCoachCubit, SmartCoachState>(
      builder: (context, state) {
        if (state.currentChatId == null) {
          return const SmartCoachStartScreen();
        }
        return const SmartCoachChatScreen();
      },
    );
  }
}
