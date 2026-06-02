import 'package:app_mobile/controller/course_service.dart';
import 'package:app_mobile/model/course.dart';
import 'package:flutter/material.dart';
import 'package:app_mobile/view/widgets/app_widgets.dart';
import 'package:app_mobile/view/widgets/navbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum CourseStatus { loading, success, error }

class _HomeScreenState extends State<HomeScreen> {
  final CourseService _courseService = CourseService();
  CourseStatus _status = CourseStatus.loading;
  List<Course> _courses = [];
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadCourses();
  }

  Future<void> _loadCourses() async {
    setState(() {
      _status = CourseStatus.loading;
    });

    final result = await _courseService.getCourses(1); // hardcoded user_id=1 for now

    if (!mounted) return;

    setState(() {
      if (result.success) {
        _status = CourseStatus.success;
        _courses = result.courses ?? [];
      } else {
        _status = CourseStatus.error;
        _errorMessage = result.errorMessage;
      }
    });
  }

  void _handleEnroll(Course course) {
    // TODO: implement enrollment logic
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Inscrição no curso "${course.name}" realizada!')),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Cursos',
      body: _buildBody(),
      bottomNavigationBar: const navbar(),
    );
  }

  Widget _buildBody() {
    if (_status == CourseStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_status == CourseStatus.error) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Erro ao carregar cursos: $_errorMessage'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadCourses,
              child: const Text('Tentar novamente'),
            ),
          ],
        ),
      );
    }

    if (_courses.isEmpty) {
      return const Center(child: Text('Nenhum curso disponível'));
    }

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 3 / 1.2,
      ),
      itemCount: _courses.length,
      itemBuilder: (context, index) {
        final course = _courses[index];
        return CourseCard(
          course: course,
          onEnroll: () => _handleEnroll(course),
        );
      },
    );
  }
}
