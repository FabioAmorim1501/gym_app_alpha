import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gym_app_alpha/src/models/training_plan_model.dart';
import 'package:gym_app_alpha/src/services/firestore_service.dart';
import 'package:uuid/uuid.dart';

class CreateTrainingPlanScreen extends StatefulWidget {
  const CreateTrainingPlanScreen({
    super.key,
    required this.athleteId,
    FirestoreService? firestoreService,
  }) : _firestoreService = firestoreService;

  final String athleteId;
  final FirestoreService? _firestoreService;

  @override
  State<CreateTrainingPlanScreen> createState() =>
      _CreateTrainingPlanScreenState();
}

class _CreateTrainingPlanScreenState extends State<CreateTrainingPlanScreen> {
  final ValueNotifier<List<Exercise>> _exercisesNotifier = ValueNotifier([]);
  final TextEditingController _planNameController = TextEditingController();
  final TextEditingController _exerciseNameController = TextEditingController();
  final TextEditingController _setsController = TextEditingController();
  final TextEditingController _repsController = TextEditingController();
  late final FirestoreService _firestoreService;
  User? _user;

  @override
  void initState() {
    super.initState();
    _firestoreService = widget._firestoreService ?? FirestoreService();
    _user = FirebaseAuth.instance.currentUser;
  }

  @override
  void dispose() {
    // ⚡ Bolt: Disposing TextEditingControllers prevents memory leaks when widget is destroyed.
    // Impact: Reduces memory consumption by cleaning up native resources.
    _exercisesNotifier.dispose();
    _planNameController.dispose();
    _exerciseNameController.dispose();
    _setsController.dispose();
    _repsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Training Plan'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            tooltip: 'Save Training Plan',
            onPressed: () {
              if (_user != null) {
                final trainingPlan = TrainingPlan(
                  id: const Uuid().v4(),
                  name: _planNameController.text,
                  trainerId: _user!.uid,
                  athleteId: widget.athleteId,
                  exercises: _exercisesNotifier.value,
                );
                _firestoreService.saveTrainingPlan(trainingPlan);
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('You must be logged in to create a plan.'),
                  ),
                );
              }
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
                prefixIcon: Icon(Icons.assignment),
              ),
            ),
            TextField(
              controller: _exerciseNameController,
              decoration: const InputDecoration(
                labelText: 'Exercise Name',
                prefixIcon: Icon(Icons.fitness_center),
              ),
            ),
            TextField(
              controller: _setsController,
              decoration: const InputDecoration(
                labelText: 'Sets',
                prefixIcon: Icon(Icons.repeat),
              ),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _repsController,
              decoration: const InputDecoration(
                labelText: 'Reps',
                prefixIcon: Icon(Icons.format_list_numbered),
              ),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: () {
                // ⚡ Bolt: Update ValueNotifier instead of triggering a global setState.
                // Impact: Prevents expensive entire form rebuilds when adding a single exercise.
                _exercisesNotifier.value = [
                  ..._exercisesNotifier.value,
                  Exercise(
                    name: _exerciseNameController.text,
                    sets: int.parse(_setsController.text),
                    reps: int.parse(_repsController.text),
                  ),
                ];
                _exerciseNameController.clear();
                _setsController.clear();
                _repsController.clear();
              },
              child: const Text('Add Exercise'),
            ),
            Expanded(
              child: ValueListenableBuilder<List<Exercise>>(
                valueListenable: _exercisesNotifier,
                builder: (context, exercises, _) {
                  return exercises.isEmpty
                      ? const Center(
                          child: Text('No exercises added yet. Add one above!'),
                        )
                      : ListView.builder(
                          itemCount: exercises.length,
                          itemBuilder: (context, index) {
                            final exercise = exercises[index];
                            return ListTile(
                              title: Text(exercise.name),
                              subtitle: Text(
                                'Sets: ${exercise.sets}, Reps: ${exercise.reps}',
                              ),
                            );
                          },
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
