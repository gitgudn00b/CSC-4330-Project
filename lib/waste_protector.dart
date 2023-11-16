import 'package:flutter/material.dart';
import 'package:waste_protector/add_food/add_food.dart';
import 'package:waste_protector/add_food/add_food_appbar.dart';
import 'package:waste_protector/cookbook/cookbook.dart';
import 'package:waste_protector/cookbook/cookbook_appbar.dart';
import 'package:waste_protector/pantry/pantry.dart';
import 'package:waste_protector/pantry/pantry_appbar.dart';
import 'package:waste_protector/recipes/recipes.dart';
import 'package:waste_protector/recipes/recipes_appbar.dart';
import 'package:waste_protector/settings/settings.dart';
import 'package:waste_protector/settings/settings_appbar.dart';

class WasteProtector extends StatefulWidget {
  const WasteProtector({super.key});

  @override
  State<WasteProtector> createState() => _WasteProtectorState();
}

class _WasteProtectorState extends State<WasteProtector> {
  int currentPageIndex = 0;

  List<AppBar> appBars = [
    PantryAppBar(),
    CookbookAppBar(),
    AddFoodAppBar(),
    RecipeAppBar(),
    SettingsAppBar()
  ];

  List<Widget> containers = [
    const Pantry(),
    const Cookbook(),
    AddFood(),
    const Recipe(),
    const Settings()
  ];

  @override
  Widget build(BuildContext context) {
    //var width = MediaQuery.of(context).size.width;

    var height = MediaQuery.of(context).size.height;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textTheme: Theme.of(context).textTheme.apply(fontFamily: 'Fredoka')),
      home: Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(height / 6),
              child: appBars[currentPageIndex]),
          body: containers[currentPageIndex],
          bottomNavigationBar: NavigationBar(
            backgroundColor: const Color(0xFFF7FFF6),
            indicatorColor: const Color(0xFFB8DDB3),
            onDestinationSelected: (int index) {
              setState(() {
                currentPageIndex = index;
              });
            },
            selectedIndex: currentPageIndex,
            destinations: <Widget>[
              NavigationDestination(
                selectedIcon:
                    Image.asset('assets/project_images/home_button_rs.png'),
                icon: Image.asset('assets/project_images/home_button_rs.png'),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Image.asset('assets/project_images/cookbook.png'),
                label: 'Cookbook',
              ),
              NavigationDestination(
                selectedIcon:
                    Image.asset('assets/project_images/plus_sign.png'),
                icon: Image.asset('assets/project_images/plus_sign.png'),
                label: 'Add Food',
              ),
              NavigationDestination(
                selectedIcon: Image.asset('assets/project_images/chef_hat.png'),
                icon: Image.asset('assets/project_images/chef_hat.png'),
                label: 'Get Recipes',
              ),
            ],
          )),
    );
  }
}
