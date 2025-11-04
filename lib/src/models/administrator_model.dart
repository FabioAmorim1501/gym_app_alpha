import 'package:gym_app_alpha/src/models/user_model.dart';

class Administrator extends User {
  final List<String> workerIds;

  Administrator({
    required String uid,
    required String email,
    required String name,
    required this.workerIds,
  }) : super(
          uid: uid,
          email: email,
          name: name,
          role: UserRole.administrator,
        );
}
