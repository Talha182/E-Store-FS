class User {
  String username;
  String email;
  String password;

  User({required this.username, required this.email, required this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      email: json['email'],
      password: json['password'], // Be careful with sensitive data like passwords
    );
  }

  Map<String, dynamic> toJson() => {
    'username': username,
    'email': email,
    'password': password,
  };
}
