import 'package:flutter/material.dart';
import 'app_card.dart';
import 'app_spacer.dart';
import 'package:app_mobile/view/theme/app_theme.dart';

class LoadingModal extends StatelessWidget {
  final String message;

  const LoadingModal({Key? key, this.message = 'Carregando...'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: AppCard(
          padding: AppSpacing.symmetric(context, vertical: 20, horizontal: 20),
          backgroundColor: AppColors.surface,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(strokeWidth: 3),
              ),
              const SizedBox(width: 16),
              Text(message, style: AppTypography.body(context)),
            ],
          ),
        ),
      ),
    );
  }
}
