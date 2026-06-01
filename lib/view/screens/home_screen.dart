import 'package:flutter/material.dart';
import 'package:app_mobile/view/widgets/app_widgets.dart';
import 'package:app_mobile/view/widgets/navbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Home',
      body: Center(
        child: AppCard(
          child: AppSection(
            spacing: 14,
            children: const [
              Text('Welcome to the Home Screen!'),
              Text('This is a basic card widget.'),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const navbar(),
    );
  }
}
