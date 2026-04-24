import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/app/config/di/di.dart';
import 'package:super_fitness_app/features/popular_training/presentation/view_model/popular_training_cubit.dart';
import 'package:super_fitness_app/features/popular_training/presentation/view_model/popular_training_events.dart';
import 'package:super_fitness_app/features/popular_training/presentation/views/widgets/popular_training_list.dart';

class PopularScreen extends StatelessWidget {
  const PopularScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.blue,
      body: Column(
        children: [
          SizedBox(height: 50),
          PopularTrainingList(),
          SizedBox(height: 50),
        ],
      ),
    );
  }
}
