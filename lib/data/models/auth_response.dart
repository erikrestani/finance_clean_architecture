import '../../domain/entities/user.dart';

class AuthResponse {
  final User user;
  final String token;

  AuthResponse({
    required this.user,
    required this.token,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      user: User(
        id: json['user']['id'],
        email: json['user']['email'],
        name: json['user']['name'],
        avatar: json['user']['avatar'],
      ),
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': {
        'id': user.id,
        'email': user.email,
        'name': user.name,
        'avatar': user.avatar,
      },
      'token': token,
    };
  }
} 