import 'dart:convert';

import 'package:app_mobile/model/course.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CourseResult {
  final bool success;
  final List<Course>? courses;
  final String? errorMessage;

  CourseResult.success({required this.courses})
      : success = true,
        errorMessage = null;

  CourseResult.failure({required this.errorMessage})
      : success = false,
        courses = null;
}

class CourseService {
  final http.Client _client;

  CourseService({http.Client? client}) : _client = client ?? http.Client();

  Future<CourseResult> getCourses([String? usernameParam]) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('user_id');
      final username = usernameParam ?? prefs.getString('username');
      final password = prefs.getString('password');

      if (username == null || password == null) {
        return CourseResult.failure(
          errorMessage: 'Usuario nao autenticado. Faca login novamente.',
        );
      }

      final queryParameters = <String, String>{
        'username': username,
        'password': password,
      };

      if (userId != null) {
        queryParameters['user_id'] = userId;
      }

      final uri = Uri.https(
        'deepness-legend-phrase.ngrok-free.dev',
        '/cursos',
        queryParameters,
      );

      final response = await _client.get(
        uri,
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        final courses = Course.fromJsonList(jsonList);
        return CourseResult.success(courses: courses);
      }

      return CourseResult.failure(
        errorMessage:
            response.body.isNotEmpty ? response.body : 'Falha ao carregar cursos',
      );
    } catch (error) {
      return CourseResult.failure(errorMessage: error.toString());
    }
  }
}
