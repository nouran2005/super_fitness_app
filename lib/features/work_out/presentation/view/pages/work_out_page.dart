import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/app/config/di/di.dart';
import 'package:super_fitness_app/features/work_out/presentation/view/widgets/work_out_body.dart';
import 'package:super_fitness_app/features/work_out/presentation/view_model/cubit/work_out_cubit.dart';
import 'package:super_fitness_app/features/work_out/presentation/view_model/cubit/work_out_events.dart';

class WorkOutPage extends StatelessWidget {
  const WorkOutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final language = context.locale.languageCode;
    return BlocProvider(
      create: (context) =>
          getIt<WorkOutCubit>()
            ..doEvent(GetAllMusclesGroup(language: language)),
      child: const Scaffold(body: WorkOutBody()),
    );
  }
}
