import 'package:flutter/material.dart';
import 'package:gym_app_alpha/src/models/training_plan_model.dart';

class ViewTrainingPlanScreen extends StatelessWidget {
  final TrainingPlan trainingPlan;

  const ViewTrainingPlanScreen({super.key, required this.trainingPlan});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(trainingPlan.name),
      ),
      body: ListView.builder(
        itemCount: trainingPlan.exercises.length,
        itemBuilder: (context, index) {
          final exercise = trainingPlan.exercises[index];
          return ListTile(
            title: Text(exercise.name),
            subtitle: Text('Sets: ${exercise.sets}, Reps: ${exercise.reps}'),
          );
        },
      ),
    );
  }
}
