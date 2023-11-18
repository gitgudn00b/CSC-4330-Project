import 'package:flutter/material.dart';
import 'package:waste_protector/pantry/pantry_appbar.dart';

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
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(height / 6), child: PantryAppBar()),
        body: Container(color: const Color(0xFF87D68D)));
  }
}
