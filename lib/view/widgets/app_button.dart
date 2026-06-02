import 'package:flutter/material.dart';
import 'package:app_mobile/view/theme/app_theme.dart';

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool expanded;
  final Color? color;

  const AppButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.expanded = true,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: expanded ? double.infinity : null,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? AppColors.primary,
          foregroundColor: AppColors.surface,
          padding: AppSpacing.symmetric(context, vertical: 16, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppBorderRadius.medium),
          ),
        ),
        onPressed: onPressed,
        child: Text(label, style: AppTypography.button(context)),
      ),
    );
  }
}
