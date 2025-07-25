import 'package:dio/dio.dart';
import '../../core/api/api_client.dart';
import '../../domain/entities/login_credentials.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/auth_response.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiClient _apiClient;

  AuthRepositoryImpl(this._apiClient);

  @override
  Future<User> login(LoginCredentials credentials) async {
    try {
      final response = await _apiClient.post('/auth/login', data: {
        'email': credentials.email,
        'password': credentials.password,
      });

      final authResponse = AuthResponse.fromJson(response.data);
      return authResponse.user;
    } on DioException catch (e) {
      throw Exception(e.error ?? 'Login failed');
    }
  }

  @override
  Future<User> register(String email, String password, String name) async {
    try {
      final response = await _apiClient.post('/auth/register', data: {
        'email': email,
        'password': password,
        'name': name,
      });

      final authResponse = AuthResponse.fromJson(response.data);
      return authResponse.user;
    } on DioException catch (e) {
      throw Exception(e.error ?? 'Registration failed');
    }
  }

  @override
  Future<User?> getCurrentUser() async {
    try {
      final response = await _apiClient.get('/auth/me');
      return User(
        id: response.data['user']['id'],
        email: response.data['user']['email'],
        name: response.data['user']['name'],
        avatar: response.data['user']['avatar'],
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        return null;
      }
      throw Exception(e.error ?? 'Failed to get current user');
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _apiClient.post('/auth/logout');
    } on DioException catch (e) {
      throw Exception(e.error ?? 'Logout failed');
    }
  }

  @override
  Future<bool> isAuthenticated() async {
    try {
      final user = await getCurrentUser();
      return user != null;
    } catch (e) {
      return false;
    }
  }
} 