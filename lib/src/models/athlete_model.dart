import 'package:gym_app_alpha/src/models/user_model.dart';

class Athlete extends User {
  final String trainerId;
  final String trainingPlanId;

  Athlete({
    required String uid,
    required String email,
    required String name,
    required this.trainerId,
    required this.trainingPlanId,
  }) : super(
          uid: uid,
          email: email,
          name: name,
          role: UserRole.athlete,
        );
}
