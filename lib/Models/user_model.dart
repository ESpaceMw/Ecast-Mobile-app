class User {
  final String firstname;
  final String lastname;

  const User({
    required this.firstname,
    required this.lastname,
  });

  factory User.fromJson(Map<String, dynamic> parsedJson) {
    return User(
      firstname: parsedJson['first_name'] ?? "",
      lastname: parsedJson['last_name'] ?? "",
    );
  }
  Map<String, dynamic> toJson() {
    return {"first_name": this.firstname, "last_name": this.lastname};
  }
}
