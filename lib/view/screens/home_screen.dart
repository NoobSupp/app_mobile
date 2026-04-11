import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:app_mobile/view/widgets/basic_card.dart';
import 'package:app_mobile/view/widgets/navbar.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Home',textAlign: TextAlign.center,),
      ),
      body: Center(
        child: BasicCard(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text('Welcome to the Home Screen!'),
              SizedBox(height: 16.0),
              Text('This is a basic card widget.'),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const navbar(),
    );
  }
}