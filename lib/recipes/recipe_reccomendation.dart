import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:waste_protector/main.dart';
import 'package:waste_protector/user.dart';

class RecipeReccomendation {
  RecipeReccomendation(
      {required this.ingredients, required this.typeOfSearchQuery});

  List<String> ingredients;
  String typeOfSearchQuery;
  List<dynamic> unformattedRecipes = [];

  WasteProtectorUser loggedInUser = WasteProtectorInit.getLoggedInUser();

  String formatIngredients(List<String> ingredients, String operator) {
    String ingredient = "";
    for (int i = 0; i < ingredients.length; i++) {
      if (ingredients[i].contains(" ")) {
        ingredient = "\"$ingredient\"";
        ingredients[i] = ingredient;
      }
    }
    return ingredients.join(operator);
  }

  String formatRecipeTitle(String unformattedRecipes) {
    String recipeTitle = "";

    int length = unformattedRecipes.length;
    recipeTitle = unformattedRecipes.substring(8, length - 1);

    return recipeTitle;
  }

  Future<List<String>> getRecipeReccomendations() async {
    List<String> formattedRecipeTitles = [];
    if (typeOfSearchQuery == "pn") {
      try {
        unformattedRecipes = await supabase
            .from('recipes')
            .select('title')
            .textSearch(
                'cleaned_ingredients', formatIngredients(ingredients, "&"));
      } on PostgrestException catch (error) {
        print(error.message);
      } catch (error) {
        print("oopsie poopsie ${error.toString()}");
      }
      if (unformattedRecipes.isEmpty) {
        try {
          unformattedRecipes = await supabase
              .from('recipes')
              .select('title')
              .textSearch(
                  'cleaned_ingredients', formatIngredients(ingredients, "|"));
        } on PostgrestException catch (error) {
          print(error.message);
        } catch (error) {
          print("oopsie poopsie ${error.toString()}");
        }
      }
      for (int i = 0; i < unformattedRecipes.length; i++) {
        formattedRecipeTitles
            .add(formatRecipeTitle(unformattedRecipes[i].toString()));
      }
    } else {
      try {
        ingredients.clear();
        ingredients.add(typeOfSearchQuery);
        unformattedRecipes = await supabase
            .from('recipes')
            .select('title')
            .textSearch(
                'cleaned_ingredients', formatIngredients(ingredients, "&"));
      } on PostgrestException catch (error) {
        print(error.message);
      } catch (error) {
        print("oopsie poopsie ${error.toString()}");
      }
      if (unformattedRecipes.isEmpty) {
        try {
          unformattedRecipes = await supabase
              .from('recipes')
              .select('title')
              .textSearch(
                  'cleaned_ingredients', formatIngredients(ingredients, "|"));
        } on PostgrestException catch (error) {
          print(error.message);
        } catch (error) {
          print("oopsie poopsie ${error.toString()}");
        }
      }
      for (int i = 0; i < unformattedRecipes.length; i++) {
        formattedRecipeTitles
            .add(formatRecipeTitle(unformattedRecipes[i].toString()));
      }
    }
    if (formattedRecipeTitles.length > 50) {
      return formattedRecipeTitles.sublist(0, 50);
    } else {
      return formattedRecipeTitles;
    }
  }
}
