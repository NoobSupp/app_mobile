import 'package:app_mobile/view/widgets/basic_card.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: const Center(
        child: BasicCard(child:   Text('Login Form Goes Here')),
      ),
    );
  }
}