import 'package:flutter/material.dart';

class RecipeAppBar extends AppBar {
  RecipeAppBar({super.key});

  @override
  State<RecipeAppBar> createState() => _RecipeBarState();
}

class _RecipeBarState extends State<RecipeAppBar> {
  Text titleText = const Text('Recipes',
      style: TextStyle(
        color: Color(0xFF353535),
        fontSize: 56,
      ));

  Image chefHat = Image.asset('assets/project_images/chef_hat_rs.png');

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return AppBar(
      title: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [chefHat, titleText],
      ),
      backgroundColor: const Color(0xFFF7FFF6),
      elevation: 0,
      toolbarHeight: height / 6,
    );
  }
}
