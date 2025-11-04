import 'package:flutter/material.dart';
import 'package:gym_app_alpha/src/models/training_plan_model.dart';
import 'package:gym_app_alpha/src/services/firestore_service.dart';
import 'package:uuid/uuid.dart';

class CreateTrainingPlanScreen extends StatefulWidget {
  const CreateTrainingPlanScreen({super.key});

  @override
  State<CreateTrainingPlanScreen> createState() =>
      _CreateTrainingPlanScreenState();
}

class _CreateTrainingPlanScreenState extends State<CreateTrainingPlanScreen> {
  final List<Exercise> _exercises = [];
  final TextEditingController _planNameController = TextEditingController();
  final TextEditingController _exerciseNameController = TextEditingController();
  final TextEditingController _setsController = TextEditingController();
  final TextEditingController _repsController = TextEditingController();
  final FirestoreService _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Training Plan'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              final trainingPlan = TrainingPlan(
                id: const Uuid().v4(),
                name: _planNameController.text,
                trainerId: 'hardcoded_trainer_id',
                athleteId: 'hardcoded_athlete_id',
                exercises: _exercises,
              );
              _firestoreService.saveTrainingPlan(trainingPlan);
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _planNameController,
              decoration: const InputDecoration(
                labelText: 'Plan Name',
              ),
            ),
            TextField(
              controller: _exerciseNameController,
              decoration: const InputDecoration(
                labelText: 'Exercise Name',
              ),
            ),
            TextField(
              controller: _setsController,
              decoration: const InputDecoration(
                labelText: 'Sets',
              ),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _repsController,
              decoration: const InputDecoration(
                labelText: 'Reps',
              ),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _exercises.add(
                    Exercise(
                      name: _exerciseNameController.text,
                      sets: int.parse(_setsController.text),
                      reps: int.parse(_repsController.text),
                    ),
                  );
                });
              },
              child: const Text('Add Exercise'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _exercises.length,
                itemBuilder: (context, index) {
                  final exercise = _exercises[index];
                  return ListTile(
                    title: Text(exercise.name),
                    subtitle: Text('Sets: ${exercise.sets}, Reps: ${exercise.reps}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
