class TrainingPlan {
  final String id;
  final String name;
  final String trainerId;
  final String athleteId;
  final List<Exercise> exercises;

  TrainingPlan({
    required this.id,
    required this.name,
    required this.trainerId,
    required this.athleteId,
    required this.exercises,
  });
}

class Exercise {
  final String name;
  final int sets;
  final int reps;
  final String? notes;

  Exercise({
    required this.name,
    required this.sets,
    required this.reps,
    this.notes,
  });
}
