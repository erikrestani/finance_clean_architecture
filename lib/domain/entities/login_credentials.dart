class LoginCredentials {
  final String email;
  final String password;

  const LoginCredentials({required this.email, required this.password});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LoginCredentials &&
        other.email == email &&
        other.password == password;
  }

  @override
  int get hashCode => email.hashCode ^ password.hashCode;

  @override
  String toString() {
    return 'LoginCredentials(email: $email)';
  }
}
