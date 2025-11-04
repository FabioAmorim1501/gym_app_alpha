import 'package:gym_app_alpha/src/models/user_model.dart';

class Trainer extends User {
  final List<String> athleteIds;

  Trainer({
    required String uid,
    required String email,
    required String name,
    required this.athleteIds,
  }) : super(
          uid: uid,
          email: email,
          name: name,
          role: UserRole.trainer,
        );
}
