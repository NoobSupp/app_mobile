import 'package:flutter/material.dart';

class navbar extends StatelessWidget {
  final int currentIndex;

  const navbar({super.key, this.currentIndex = 0});

  void _navigate(BuildContext context, int index) {
    final route = switch (index) {
      0 => '/home',
      1 => '/home',
      2 => '/user',
      _ => '/home',
    };

    final currentRoute = ModalRoute.of(context)?.settings.name;
    if (currentRoute == route) return;

    Navigator.pushNamedAndRemoveUntil(context, route, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) => _navigate(context, index),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.format_list_bulleted),
          label: 'Cursos',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Usuario',
        ),
      ],
    );
  }
}
