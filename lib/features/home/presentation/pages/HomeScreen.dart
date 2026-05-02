import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/app/config/di/di.dart';
import 'package:super_fitness_app/features/home/presentation/manger/Rc_to_day_cubit.dart';
import 'package:super_fitness_app/features/home/presentation/manger/Rc_to_day_intents.dart';
import 'package:super_fitness_app/features/home/presentation/widgets/homeBody.dart';
import 'package:super_fitness_app/features/meals/presentation/view_model/cubit/meals_cubit.dart';
import 'package:super_fitness_app/features/meals/presentation/view_model/cubit/meals_intent.dart';
import 'package:super_fitness_app/features/profile/presentation/view_model/cubit/profile_cubit.dart';
import 'package:super_fitness_app/features/profile/presentation/view_model/cubit/profile_events.dart';
import 'package:super_fitness_app/features/work_out/presentation/view_model/cubit/work_out_cubit.dart';
import 'package:super_fitness_app/features/work_out/presentation/view_model/cubit/work_out_events.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final language = context.locale.languageCode;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              getIt<RcToDayCubit>()..doIntent(GetRandomMusclesIntent()),
        ),
        BlocProvider(
          create: (context) =>
              getIt<MealsCubit>()..doIntent(GetMealsCategoriesIntent()),
        ),
        BlocProvider(
          create: (context) =>
              getIt<WorkOutCubit>()
                ..doEvent(GetAllMusclesGroup(language: language)),
        ),
      ],
      child: const Scaffold(body: HomeBody()),
    );
  }
}
