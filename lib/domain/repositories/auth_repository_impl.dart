import '../entities/login_credentials.dart';
import '../entities/user.dart';
import 'auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  User? _currentUser;

  @override
  Future<User> login(LoginCredentials credentials) async {
    await Future.delayed(const Duration(seconds: 2));

    if (credentials.email == 'teste@teste.com' &&
        credentials.password == '123456') {
      _currentUser = const User(
        id: '1',
        email: 'test@test.com',
        name: 'Test User',
      );
      return _currentUser!;
    } else {
      throw Exception('Invalid credentials');
    }
  }

  @override
  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _currentUser = null;
  }

  @override
  Future<User?> getCurrentUser() async {
    return _currentUser;
  }

  @override
  Future<bool> isAuthenticated() async {
    return _currentUser != null;
  }
}
