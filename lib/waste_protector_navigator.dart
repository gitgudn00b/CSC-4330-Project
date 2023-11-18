import 'package:flutter/material.dart';
import 'package:waste_protector/add_food/add_food.dart';
import 'package:waste_protector/cookbook/cookbook.dart';
import 'package:waste_protector/pantry/pantry.dart';
import 'package:waste_protector/recipes/recipes.dart';

class WasteProtectorNavigator extends StatelessWidget {
  WasteProtectorNavigator(
      {super.key, required this.navigatorKey, required this.pageItem});
  final GlobalKey<NavigatorState> navigatorKey;
  final String pageItem;

  Widget build(BuildContext context) {
    Widget child;
    if (pageItem == "Pantry") {
      child = Pantry();
    } else if (pageItem == "Cookbook") {
      child = Cookbook();
    } else if (pageItem == "Add Food") {
      child = AddFood();
    } else if (pageItem == "Recipe") {
      child = Recipe();
    } else
      child = Container();
    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(builder: (context) => child);
      },
    );
  }
}
