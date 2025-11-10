import 'package:flutter_test/flutter_test.dart';
import 'package:gym_app_alpha/src/models/training_plan_model.dart';

void main() {
  group('TrainingPlan', () {
    test('can be instantiated', () {
      final trainingPlan = TrainingPlan(
        id: '1',
        name: 'Test Plan',
        trainerId: 'trainer1',
        athleteId: 'athlete1',
        exercises: [
          Exercise(
            name: 'Push-ups',
            sets: 3,
            reps: 10,
          ),
        ],
      );
      expect(trainingPlan, isNotNull);
    });
  });
}
