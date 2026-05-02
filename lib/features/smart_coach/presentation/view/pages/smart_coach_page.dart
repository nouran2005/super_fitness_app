import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/features/profile/presentation/view_model/cubit/profile_cubit.dart';
import 'package:super_fitness_app/features/profile/presentation/view_model/cubit/profile_events.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view_model/cubit/smart_coach_cubit.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view_model/cubit/smart_coach_event.dart';
import 'package:super_fitness_app/app/config/di/di.dart';
import '../widgets/smart_coach_start_screen.dart';

class SmartCoachPage extends StatelessWidget {
  const SmartCoachPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<SmartCoachCubit>()..doEvent(GetAllChats()),
        ),
        BlocProvider(
          create: (context) =>
              getIt<ProfileCubit>()..doIntent(ProfileDataEvent()),
        ),
      ],
      child: const SmartCoachStartScreen(),
    );
  }
}
