import 'package:flutter/material.dart';

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
        onPressed: () {},
        child: Container(
            width: width * 0.95,
            height: height / 13,
            margin: EdgeInsets.only(
                top: height / 24, right: width / 8, left: width / 60),
            decoration: BoxDecoration(
              color: const Color(0xFFF7FFF6),
              border: Border.all(color: const Color(0xFF353535), width: 2.0),
            ),
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.start,
              //crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                    padding:
                        const EdgeInsets.only(top: 1.5, right: 15, left: 8),
                    child: recipeImage),
                Text(recipeName)
              ],
            )));
  }
}
