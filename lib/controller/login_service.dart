import 'dart:convert';

import 'package:http/http.dart' as http;

class LoginResult {
  final bool success;
  final int statusCode;
  final String? body;
  final String? errorMessage;

  LoginResult.success({required this.statusCode, this.body})
      : success = true,
        errorMessage = null;

  LoginResult.failure({required this.statusCode, this.errorMessage})
      : success = false,
        body = null;
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
        return LoginResult.success(statusCode: response.statusCode, body: response.body);
      }

      return LoginResult.failure(
        statusCode: response.statusCode,
        errorMessage: response.body.isNotEmpty ? response.body : 'Falha no login',
      );
    } catch (error) {
      return LoginResult.failure(statusCode: 0, errorMessage: error.toString());
    }
  }
}
