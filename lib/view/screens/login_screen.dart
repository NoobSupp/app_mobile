
import 'package:app_mobile/controller/login_service.dart';
import 'package:app_mobile/view/widgets/app_widgets.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

enum LoginStatus { idle, loading, error }

class _LoginScreenState extends State<LoginScreen> {
  final LoginService _loginService = LoginService();
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  LoginStatus _status = LoginStatus.idle;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _checkStoredCredentials();
  }

  Future<void> _checkStoredCredentials() async {
    final storedCredentials = await _loginService.getStoredCredentials();
    if (storedCredentials != null && storedCredentials.username != null) {
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    }
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

    setState(() {
      _status = LoginStatus.loading;
      _errorMessage = null;
    });

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const LoadingModal(),
    );

    final result = await _loginService.login(username, password);

    if (!mounted) return;

    Navigator.of(context, rootNavigator: true).pop();

    setState(() {
      _status = result.success ? LoginStatus.idle : LoginStatus.error;
      _errorMessage = result.errorMessage;
    });

    if (result.success) {
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Erro'),
        content: Text(result.errorMessage ?? 'Erro ao conectar'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
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