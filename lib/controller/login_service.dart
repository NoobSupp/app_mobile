import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginResult {
  final bool success;
  final int statusCode;
  final String? body;
  final String? errorMessage;
  final String? username;
  final String? password;
  final String? userId;

  LoginResult.success({
    required this.statusCode,
    this.body,
    this.username,
    this.password,
    this.userId,
  })
      : success = true,
        errorMessage = null;

  LoginResult.failure({required this.statusCode, this.errorMessage})
      : success = false,
        body = null,
        username = null,
        password = null,
        userId = null;
}

class LoginService {
  final http.Client _client;

  LoginService({http.Client? client}) : _client = client ?? http.Client();

  Future<LoginResult> login(String username, String password) async {
    final uri = Uri.parse('https://deepness-legend-phrase.ngrok-free.dev/login');

    try {
      final response = await _client.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': username,
          'password': password,
        }),
      ).timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        // Tentar extrair user_id da resposta
        String? userId;
        try {
          final jsonResponse = json.decode(response.body);
          // Tente diferentes nomes de campo comuns
          userId = jsonResponse['user_id']?.toString() ??
              jsonResponse['userId']?.toString() ??
              jsonResponse['id']?.toString();
        } catch (e) {
          // Se não conseguir fazer parse, continua sem userId
        }

        await _saveLoginCredentials(username, password, userId);
        return LoginResult.success(
          statusCode: response.statusCode,
          body: response.body,
          username: username,
          password: password,
          userId: userId,
        );
      }

      return LoginResult.failure(
        statusCode: response.statusCode,
        errorMessage: response.body.isNotEmpty ? response.body : 'Falha no login',
      );
    } catch (error) {
      return LoginResult.failure(statusCode: 0, errorMessage: error.toString());
    }
  }

  Future<void> _saveLoginCredentials(String username, String password, String? userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    await prefs.setString('password', password);
    if (userId != null) {
      await prefs.setString('user_id', userId);
    }
  }

  Future<LoginResult?> getStoredCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username');
    final password = prefs.getString('password');
    final userId = prefs.getString('user_id');

    if (username != null && password != null) {
      return LoginResult.success(
        statusCode: 200,
        username: username,
        password: password,
        userId: userId,
      );
    }
    return null;
  }

  Future<void> clearStoredCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    await prefs.remove('password');
    await prefs.remove('user_id');
  }
}
