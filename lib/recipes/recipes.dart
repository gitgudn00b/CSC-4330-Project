import 'package:flutter/material.dart';
import 'package:waste_protector/main.dart';
import 'package:waste_protector/recipes/recipe_reccomendation.dart';
import 'package:waste_protector/recipes/recipe_tile.dart';
import 'package:waste_protector/recipes/recipes_appbar.dart';
import 'package:waste_protector/user.dart';

class Recipe extends StatefulWidget {
  const Recipe({super.key});

  @override
  State<Recipe> createState() => _RecipeState();
}

class _RecipeState extends State<Recipe> {
  final TextEditingController _searchBarController = TextEditingController();

  String typeOfSearchQuery = "pn";

  List<RecipeTile> reccomendedRecipes = [];

  Future<List<RecipeTile>> _getRecipeData() async {
    WasteProtectorUser loggedInUser = WasteProtectorInit.getLoggedInUser();
    if (!loggedInUser.userInitialized) {
      await loggedInUser.initWasteProtectorUser();
    }
    List<String> recipeTitles = [];

    List<String> ingredients = loggedInUser.foodNames;
    RecipeReccomendation recipeReccomendation = RecipeReccomendation(
        ingredients: ingredients, typeOfSearchQuery: typeOfSearchQuery);
    recipeTitles = await recipeReccomendation.getRecipeReccomendations();
    List<RecipeTile> recipeTiles = [];
    for (int i = 0; i < recipeTitles.length; i++) {
      recipeTiles.add(RecipeTile(
        recipeName: recipeTitles[i],
        recipeImage: Image.asset('assets/project_images/cookbook_rs.png'),
      ));
    }
    return recipeTiles;
  }

  final InputDecoration _textFieldDecoration = const InputDecoration(
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF619267), width: 2.0)),
      enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF619267), width: 4.0)),
      errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF619267), width: 4.0)),
      focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF619267), width: 4.0)),
      prefixIconColor: Color(0xFF619267),
      focusColor: Color(0xFF619267),
      fillColor: Color(0xFFF7FFF6),
      filled: true,
      errorStyle: TextStyle(color: Color(0xFF353535)));

  Padding _buildSearchBar(double width) => Padding(
      padding:
          EdgeInsets.symmetric(vertical: width / 30, horizontal: width / 16),
      child: TextFormField(
          textInputAction: TextInputAction.go,
          decoration: _textFieldDecoration.copyWith(
              prefixIcon: const Icon(Icons.search)),
          controller: _searchBarController,
          onEditingComplete: () {
            FocusManager.instance.primaryFocus?.unfocus();
            setState(() {
              typeOfSearchQuery = _searchBarController.text;
              _getRecipeData();
            });
          }));

  Widget _buildSearchByTags() {
    return FittedBox(
      fit: BoxFit.contain,
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 25),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.25),
              child: MaterialButton(
                  onPressed: () {
                    setState(() {
                      typeOfSearchQuery = "es";
                    });
                  },
                  height: 25,
                  color: const Color(0xFF4E7A53),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  child: const Text("Expiring Soon",
                      style: TextStyle(color: Color(0xFFF7FFF6)))),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.25),
              child: MaterialButton(
                  onPressed: () {
                    setState(() {
                      typeOfSearchQuery = "pn";
                      _getRecipeData();
                    });
                  },
                  height: 25,
                  color: const Color(0xFF4E7A53),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  child: const Text("Pantry",
                      style: TextStyle(color: Color(0xFFF7FFF6)))),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.25),
              child: MaterialButton(
                  onPressed: () {
                    setState(() {
                      typeOfSearchQuery = "pp";
                    });
                  },
                  height: 25,
                  color: const Color(0xFF4E7A53),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  child: const Text("Popular",
                      style: TextStyle(color: Color(0xFFF7FFF6)))),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.25),
              child: MaterialButton(
                  onPressed: () {
                    setState(() {
                      typeOfSearchQuery = "rp";
                    });
                  },
                  height: 25,
                  color: const Color(0xFF4E7A53),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  child: const Text("Random Pair",
                      style: TextStyle(color: Color(0xFFF7FFF6)))),
            )
          ])),
    );
  }

  @override
  void initState() {
    _getRecipeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: RecipeAppBar(),
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
                    child: ListView(children: [
                      _buildSearchBar(width),
                      _buildSearchByTags(),
                      Column(children: snapshot.data as List<Widget>)
                    ]));
              } else {
                return const Center(
                    child: CircularProgressIndicator(color: Color(0xFF619267)));
              }
            },
            future: _getRecipeData()));
  }
}
