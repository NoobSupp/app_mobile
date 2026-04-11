import 'package:flutter/material.dart';

class navbar extends StatelessWidget {
  const navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(items: 
    const [
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
        label: 'Profile',
      ),
    ]
    );
  }
}