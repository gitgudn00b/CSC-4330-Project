import 'package:flutter/material.dart';
import 'package:waste_protector/recipes/recipes_appbar.dart';

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
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(height / 6), child: RecipeAppBar()),
        body: Container(color: const Color(0xFF87D68D)));
  }
}
