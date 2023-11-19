import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:waste_protector/waste_protector_navigator.dart';

class WasteProtector extends StatefulWidget {
  const WasteProtector({super.key});

  @override
  State<WasteProtector> createState() => _WasteProtectorState();
}

class _WasteProtectorState extends State<WasteProtector> {
  int currentPageIndex = 0;

  String _currentPage = "Pantry";

  List<String> pageKeys = ["Pantry", "Cookbook", "Add Food", "Recipe"];

  final Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
    "Pantry": GlobalKey<NavigatorState>(),
    "Cookbook": GlobalKey<NavigatorState>(),
    "Add Food": GlobalKey<NavigatorState>(),
    "Recipe": GlobalKey<NavigatorState>(),
  };

  /* static List<AppBar> appBars = [
    PantryAppBar(),
    CookbookAppBar(),
    AddFoodAppBar(),
    RecipeAppBar(),
    SettingsAppBar()
  ];

  static List<Widget> containers = [
    const Pantry(),
    const Cookbook(),
    AddFood(),
    const Recipe(),
    const Settings()
  ]; */

  void _selectPage(String pageItem, int index) {
    if (pageItem == _currentPage) {
      _navigatorKeys[pageItem]!
          .currentState!
          .popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _currentPage = pageKeys[index];
        currentPageIndex = index;
      });
    }
  }

  Widget _buildOffstageNavigator(String pageItem) {
    return Offstage(
        offstage: _currentPage != pageItem,
        child: WasteProtectorNavigator(
            navigatorKey: _navigatorKeys[pageItem]!, pageItem: pageItem));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                //textSelectionTheme: const TextSelectionThemeData(
                //selectionColor: Color(0xFF619267)),
                textTheme: Theme.of(context).textTheme.apply(
                      fontFamily: 'Fredoka',
                      bodyColor: Color(0xFF353535),
                      displayColor: Color(0xFF353535),
                      decorationColor: Color(0xFF353535),
                    )),
            home: WillPopScope(
              onWillPop: () async {
                final isFirstRouteInCurrentPage =
                    !await _navigatorKeys[_currentPage]!
                        .currentState!
                        .maybePop();
                if (isFirstRouteInCurrentPage) {
                  if (_currentPage != "Pantry") {
                    _selectPage('Pantry', 1);
                    return false;
                  }
                }
                return isFirstRouteInCurrentPage;
              },
              child: Scaffold(
                  body: Stack(children: <Widget>[
                    _buildOffstageNavigator("Pantry"),
                    _buildOffstageNavigator("Cookbook"),
                    _buildOffstageNavigator("Add Food"),
                    _buildOffstageNavigator("Recipe"),
                  ]),
                  bottomNavigationBar: NavigationBar(
                    backgroundColor: const Color(0xFFF7FFF6),
                    indicatorColor: const Color(0xFFB8DDB3),
                    onDestinationSelected: (int index) {
                      _selectPage(pageKeys[index], index);
                    },
                    selectedIndex: currentPageIndex,
                    destinations: <Widget>[
                      NavigationDestination(
                        icon: Image.asset(
                            'assets/project_images/home_button_rs.png'),
                        label: 'Home',
                      ),
                      NavigationDestination(
                        icon: Image.asset('assets/project_images/cookbook.png'),
                        label: 'Cookbook',
                      ),
                      NavigationDestination(
                        icon:
                            Image.asset('assets/project_images/plus_sign.png'),
                        label: 'Add Food',
                      ),
                      NavigationDestination(
                        icon: Image.asset('assets/project_images/chef_hat.png'),
                        label: 'Get Recipes',
                      ),
                    ],
                  )),
            )));
  }
}
