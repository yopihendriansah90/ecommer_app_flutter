class User {
  final int id;
  final String name;
  final String phone;
  final String? email;

  User({required this.id, required this.name, required this.phone, this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      name: json['name'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String?,
    );
  }
}

class AuthResponse {
  final String message;
  final String? token;
  final int? otp;
  final bool? isLogin;
  final User? user;

  AuthResponse({
    required this.message,
    this.token,
    this.otp,
    this.isLogin,
    this.user,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      message: json['message'] as String,
      token: json['token'] as String?,
      otp: json['otp'] as int?,
      isLogin: json['is_Login'] as bool?,
      user: json['user'] != null
          ? User.fromJson(json['user'] as Map<String, dynamic>)
          : null,
    );
  }
}
