import 'dart:convert';

import 'package:app_mobile/model/course.dart';
import 'package:http/http.dart' as http;

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

  Future<CourseResult> getCourses(int userId) async {
    final uri = Uri.parse('http://localhost:4000/cursos?user_id=$userId');

    try {
      final response = await _client.post(
        uri,
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        final courses = Course.fromJsonList(jsonList);
        return CourseResult.success(courses: courses);
      }

      return CourseResult.failure(
        errorMessage: response.body.isNotEmpty ? response.body : 'Falha ao carregar cursos',
      );
    } catch (error) {
      return CourseResult.failure(errorMessage: error.toString());
    }
  }
}
