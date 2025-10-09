import 'package:flutter/foundation.dart';

// Shared service to manage registered users across the app
// This ensures registration and login use the same user data
class UserService {
  // Singleton pattern to ensure only one instance exists
  static final UserService _instance = UserService._internal();
  factory UserService() => _instance;
  UserService._internal();

  // Shared list of registered users
  final List<Map<String, String>> _registeredUsers = [];

  // Add a new user during registration
  void registerUser({
    required String username,
    required String email,
    required String password,
    required String role,
  }) {
    _registeredUsers.add({
      'username': username,
      'email': email,
      'password': password,
      'role': role,
    });
    if (kDebugMode) {
      print('[v0] User registered: $email');
      print('[v0] Total registered users: ${_registeredUsers.length}');
    }
  }

  // Check if user credentials are valid during login
  bool isUserRegistered(String email, String password) {
    final isValid = _registeredUsers.any(
      (user) => user['email'] == email && user['password'] == password,
    );
    if (kDebugMode) {
      print('[v0] Login attempt for: $email');
      print('[v0] Is valid: $isValid');
      print(
          '[v0] Registered users: ${_registeredUsers.map((u) => u['email']).toList()}');
    }
    return isValid;
  }

  // Get all registered users (for debugging)
  List<Map<String, String>> getAllUsers() =>
      List.unmodifiable(_registeredUsers);
}
