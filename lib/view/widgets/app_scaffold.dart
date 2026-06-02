import 'package:flutter/material.dart';
import 'package:app_mobile/view/theme/app_theme.dart';

class AppScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;

  const AppScaffold({
    Key? key,
    required this.title,
    required this.body,
    this.appBar,
    this.bottomNavigationBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar ?? AppBar(title: Text(title, style: AppTypography.title(context))),
      backgroundColor: AppColors.background,
      bottomNavigationBar: bottomNavigationBar,
      body: SafeArea(
        child: Padding(
          padding: AppSpacing.symmetric(context, vertical: 16, horizontal: 16),
          child: body,
        ),
      ),
    );
  }
}
