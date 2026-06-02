import 'package:app_mobile/model/course.dart';
import 'package:app_mobile/view/theme/app_theme.dart';
import 'package:app_mobile/view/widgets/app_widgets.dart';
import 'package:flutter/material.dart';

class CourseCard extends StatelessWidget {
  final Course course;
  final VoidCallback? onEnroll;

  const CourseCard({
    Key? key,
    required this.course,
    this.onEnroll,
  }) : super(key: key);

  void _showCourseModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(course.name),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Professor: ${course.professor}',
                style: AppTypography.body(context),
              ),
              const SizedBox(height: 8),
              Text(
                '${course.dayOfWeek} às ${course.time}',
                style: AppTypography.body(context),
              ),
              const SizedBox(height: 8),
              Text(
                'Local: ${course.location}',
                style: AppTypography.body(context),
              ),
              const SizedBox(height: 16),
              Text(
                'Descrição',
                style: AppTypography.label(context),
              ),
              const SizedBox(height: 8),
              Text(
                course.description,
                style: AppTypography.body(context),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Fechar'),
          ),
          if (!course.isEnrolled)
            ElevatedButton(
              onPressed: onEnroll,
              child: const Text('Inscrever-se'),
            )
          else
            ElevatedButton(
              onPressed: null,
              child: const Text('Já inscrito'),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = course.isEnrolled
        ? const Color(0xFFC0C0C0) // Gray
        : const Color(0xFFADD8E6); // Light blue

    return GestureDetector(
      onTap: () => _showCourseModal(context),
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(AppBorderRadius.medium),
          boxShadow: AppShadow.card,
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              course.name,
              style: AppTypography.title(context).copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${course.dayOfWeek} às ${course.time}',
              style: AppTypography.label(context).copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
