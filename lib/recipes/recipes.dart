import 'dart:math';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:waste_protector/main.dart';
import 'package:waste_protector/recipes/recipe_tile.dart';
import 'package:waste_protector/recipes/recipes_appbar.dart';
import 'package:waste_protector/user.dart';

class Recipe extends StatefulWidget {
  const Recipe({super.key});

  @override
  State<Recipe> createState() => _RecipeState();
}

class _RecipeState extends State<Recipe> {
  List<String> recipes = [];

  List<dynamic> unformattedRecipes = [];

  int lowerBound = Random().nextInt(6500);
  int upperBound = Random().nextInt(1000) + 5500;

  void _getRecipes() async {
    WasteProtectorUser loggedInUser = WasteProtectorInit.getLoggedInUser();
    if (!loggedInUser.userInitialized) {
      await loggedInUser.initWasteProtectorUser();
    }
    String ingredients = loggedInUser.foodNames.join(" ");
    try {
      unformattedRecipes = await supabase
          .from('recipes')
          .select('title')
          .filter('cleaned_ingredients', 'contains', loggedInUser.foodNames);
    } on PostgrestException catch (error) {
      print(error.message);
    } catch (error) {
      print("oopsie poopsie ${error.toString()}");
    }
    print(unformattedRecipes.toString());
    recipes = unformattedRecipes[0].toString().split(", ");
    print(recipes.contains(ingredients[0]));
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    _getRecipes();
    return Scaffold(
      appBar: RecipeAppBar(),
      body: RecipeTile(
          recipeName: "banana",
          recipeImage: Image.asset('assets/project_images/chef_hat_rs.png')),
    );
  }
}
