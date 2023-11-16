import 'package:flutter/material.dart';

class Pantry extends StatefulWidget {
  const Pantry({super.key});

  @override
  State<Pantry> createState() => _PantryState();
}

class _PantryState extends State<Pantry> {
  int foodCounter = 0;
  List<Image> foodIcons = [
    Image.asset('assets/project_images/apple_icon.png'),
    Image.asset('assets/project_images/orange_icon.png'),
    Image.asset('assets/project_images/lemon_icon.png'),
    Image.asset('assets/project_images/watermelon_icon.png')
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF87D68D),
    );
  }
}
