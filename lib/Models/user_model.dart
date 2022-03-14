class User {
  final String email;
  final String password;

  const User({
    required this.email,
    required this.password,
  });

  factory User.fromJson(Map<String, dynamic> parsedJson) {
    return User(
      email: parsedJson['first_name'] ?? "",
      password: parsedJson['last_name'] ?? "",
    );
  }
}
