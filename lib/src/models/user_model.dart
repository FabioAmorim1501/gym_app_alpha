enum UserRole {
  athlete,
  trainer,
  worker,
  administrator,
}

class User {
  final String uid;
  final String email;
  final String name;
  final UserRole role;

  User({
    required this.uid,
    required this.email,
    required this.name,
    required this.role,
  });
}
