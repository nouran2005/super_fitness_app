import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/app/config/di/di.dart';
import 'package:super_fitness_app/features/profile/presentation/view_model/cubit/profile_cubit.dart';
import 'package:super_fitness_app/features/profile/presentation/view_model/cubit/profile_events.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view_model/cubit/smart_coach_cubit.dart';
import '../widgets/smart_coach_chat_screen.dart';

class SmartCoachChatPage extends StatelessWidget {
  final SmartCoachCubit cubit;

  const SmartCoachChatPage({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: cubit),
        BlocProvider(
          create: (context) =>
              getIt<ProfileCubit>()..doIntent(ProfileDataEvent()),
        ),
      ],
      child: const SmartCoachChatScreen(),
    );
  }
}
