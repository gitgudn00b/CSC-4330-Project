import 'package:flutter/material.dart';

class Recipe extends StatefulWidget {
  const Recipe({super.key});

  @override
  State<Recipe> createState() => _RecipeState();
}

class _RecipeState extends State<Recipe> {
  TextField foodName = const TextField(
      decoration: InputDecoration(
          labelText: 'Food Name',
          floatingLabelAlignment: FloatingLabelAlignment.start));

  @override
  Widget build(BuildContext context) {
    //var width = MediaQuery.of(context).size.width;
    return Container(color: const Color(0xFF87D68D));
  }
}
