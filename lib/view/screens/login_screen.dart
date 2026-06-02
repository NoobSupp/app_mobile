
import 'package:app_mobile/view/widgets/app_widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text;

    if (username.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor informe o usuário')),
      );
      return;
    }

    // show loading modal (uses styled LoadingModal from widgets)
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const LoadingModal(),
    );

    try {
      final uri = Uri.https(
        'deepness-legend-phrase.ngrok-free.dev',
        '/login',
        {
          'username': username,
          'password': password,
        },
      );

      final response = await http.get(uri).timeout(const Duration(seconds: 15));

      if (!mounted) return;

      Navigator.of(context, rootNavigator: true).pop(); // close loading

      if (response.statusCode == 200) {
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Erro'),
            content: Text('Falha no login: ${response.statusCode}'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      if (mounted) Navigator.of(context, rootNavigator: true).pop();
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Erro'),
          content: Text('Erro ao conectar: $e'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Login',
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: AppCard(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppTextField(
                  controller: _usernameController,
                  label: 'Username',
                ),
                const SizedBox(height: 16.0),
                AppTextField(
                  controller: _passwordController,
                  label: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 24.0),
                AppButton(
                  label: 'Login',
                  onPressed: _handleLogin,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}