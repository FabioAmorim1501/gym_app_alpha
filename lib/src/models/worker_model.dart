import 'package.gym_app_alpha/src/models/user_model.dart';

class Worker extends User {
  final String administratorId;

  Worker({
    required String uid,
    required String email,
    required String name,
    required this.administratorId,
  }) : super(
          uid: uid,
          email: email,
          name: name,
          role: UserRole.worker,
        );
}
