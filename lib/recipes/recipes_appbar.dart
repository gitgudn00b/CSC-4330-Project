import 'package:flutter/material.dart';

class RecipeAppBar extends AppBar {
  RecipeAppBar({super.key});

  @override
  State<RecipeAppBar> createState() => _RecipeBarState();
}

class _RecipeBarState extends State<RecipeAppBar> {
  Text titleText = const Text('Recipes',
      style: TextStyle(
        fontSize: 56,
      ));

  Image chefHat = Image.asset('assets/project_images/chef_hat_rs.png');

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        //mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [chefHat, const Text("Recipes")],
      ),
    );
  }
}
