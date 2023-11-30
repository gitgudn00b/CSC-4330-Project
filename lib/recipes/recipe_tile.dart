import 'package:flutter/material.dart';
import 'package:waste_protector/recipes/recipe_page.dart';

class RecipeTile extends StatelessWidget {
  RecipeTile({super.key, required this.recipeName, required this.recipeImage});

  String recipeName;
  Image recipeImage;

  List<RecipeTile> recipes = [];

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return MaterialButton(
        elevation: 5,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute<Scaffold>(
                  builder: (context) => RecipePage(recipeTitle: recipeName)));
        },
        child: Container(
            width: width * 0.95,
            height: height / 10,
            margin: EdgeInsets.only(
                top: height / 48, right: width / 8, left: width / 60),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(50)),
              color: const Color(0xFFF7FFF6),
              border: Border.all(color: const Color(0xFFF7FFF6), width: 2.0),
            ),
            child: Row(
              children: [
                FittedBox(
                    alignment: Alignment.centerLeft,
                    fit: BoxFit.fitHeight,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: recipeImage)),
                Flexible(
                    child: Text(
                  recipeName,
                  softWrap: true,
                  maxLines: 3,
                ))
              ],
            )));
  }
}
