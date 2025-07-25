import '../entities/login_credentials.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<User> login(LoginCredentials credentials);
  Future<void> logout();
  Future<User?> getCurrentUser();
  Future<bool> isAuthenticated();
}
