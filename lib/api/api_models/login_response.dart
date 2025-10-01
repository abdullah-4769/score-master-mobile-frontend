class LoginResponse {
  final String token;
  final User user;

  LoginResponse({required this.token, required this.user});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      token: json['token'],
      user: User.fromJson(json['user']),
    );
  }
}

class User {
  final int id;
  final String name;
  final String email;
  final String language;
  final String phone;
  final String role;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.language,
    required this.phone,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      language: json['language'] ?? 'en',
      phone: json['phone'] ?? '',
      role: json['role'],
    );
  }

  /// Add this method to save user in SharedPreferences
  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "language": language,
    "phone": phone,
    "role": role,
  };
}