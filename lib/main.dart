import 'package:flutter/material.dart';
import 'package:app_mobile/controller/login_service.dart';
import 'package:app_mobile/view/screens/login_screen.dart';
import 'package:app_mobile/view/screens/home_screen.dart';
import 'package:app_mobile/view/screens/user_screen.dart';
import 'package:app_mobile/view/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LoginService().clearStoredCredentials();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/user': (context) => const UserScreen(),
      },
    );
  }
}
