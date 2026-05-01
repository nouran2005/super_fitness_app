import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view_model/cubit/smart_coach_cubit.dart';
import '../widgets/smart_coach_chat_screen.dart';

class SmartCoachChatPage extends StatelessWidget {
  final SmartCoachCubit cubit;

  const SmartCoachChatPage({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: const SmartCoachChatScreen(),
    );
  }
}
