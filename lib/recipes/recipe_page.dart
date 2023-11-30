import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:waste_protector/main.dart';

class RecipePage extends StatefulWidget {
  const RecipePage({super.key, required this.recipeTitle});

  final String recipeTitle;

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  Image cookbook = Image.asset('assets/project_images/cookbook_rs.png');
  AppBar recipePageAppBar() => AppBar(
        leading: IconButton(
          iconSize: 50,
          onPressed: () {},
          icon: const Icon(Icons.favorite_border, color: Color(0xFF619267)),
          selectedIcon: const Icon(
            Icons.favorite,
            color: Color(0xFF619267),
          ),
        ),
        title: Row(
          //mainAxisSize: MainAxisSize.max,
          //crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            cookbook,
            Flexible(
                child: Text(
              widget.recipeTitle,
              softWrap: true,
              maxLines: 3,
              style: const TextStyle(fontSize: 24),
            )),
          ],
        ),
      );

  Future<List<Text>> getRecipe() async {
    List<dynamic> ingredients = [];
    try {
      ingredients = await supabase
          .from('recipes')
          .select('ingredients')
          .eq('title', widget.recipeTitle);
    } on PostgrestException catch (error) {
      print(error.message);
    } catch (error) {
      print("oopsie poopsie ${error.toString()}");
    }

    String unformattedIngredients = ingredients[0].toString();
    int length = unformattedIngredients.length;
    String stillUnformattedIngredients =
        unformattedIngredients.substring(15, length - 2);
    length = stillUnformattedIngredients.length;
    String formattedIngredients = "";
    bool firstQuote = true;
    for (int i = 0; i < length; i++) {
      if (stillUnformattedIngredients[i] == "\'") {
        if (firstQuote) {
          firstQuote = false;
        } else {
          formattedIngredients = formattedIngredients + "\n";
          firstQuote = true;
        }
      } else {
        if (stillUnformattedIngredients[i] != ",") {
          formattedIngredients =
              formattedIngredients + stillUnformattedIngredients[i];
        }
      }
    }
    List<dynamic> recipe = [];
    try {
      recipe = await supabase
          .from('recipes')
          .select('instructions')
          .eq('title', widget.recipeTitle);
    } on PostgrestException catch (error) {
      print(error.message);
    } catch (error) {
      print("oopsie poopsie ${error.toString()}");
    }
    String unformattedRecipe = recipe[0].toString();
    length = unformattedRecipe.length;
    String formattedRecipe = unformattedRecipe.substring(14, length - 1);
    //return formattedIngredients + "\n" + formattedRecipe;
    Text ingredientsText = Text(
      formattedIngredients,
      style: const TextStyle(
          fontSize: 14,
          textBaseline: TextBaseline.ideographic,
          color: Color(0xFFF7FFF6)),
    );
    Text recipeText = Text(
      formattedRecipe,
      style:
          const TextStyle(fontSize: 14, textBaseline: TextBaseline.ideographic),
    );
    return [ingredientsText, recipeText];
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(height / 6),
            child: recipePageAppBar()),
        body: FutureBuilder(
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var padding = height / 24;
                return RawScrollbar(
                    thumbVisibility: true,
                    crossAxisMargin: padding / 4,
                    mainAxisMargin: padding / 3,
                    radius: const Radius.circular(50),
                    thickness: padding / 6,
                    thumbColor: const Color(0xFF6db078),
                    child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child:
                            ListView(children: snapshot.data as List<Widget>)));
              } else {
                return const Center(
                    child: CircularProgressIndicator(color: Color(0xFF619267)));
              }
            },
            future: getRecipe()));
  }
}
