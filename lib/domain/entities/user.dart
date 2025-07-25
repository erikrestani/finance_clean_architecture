class User {
  final String id;
  final String email;
  final String name;
  final String? avatar;

  const User({
    required this.id,
    required this.email,
    required this.name,
    this.avatar,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is User && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'User(id: $id, email: $email, name: $name)';
  }
}
