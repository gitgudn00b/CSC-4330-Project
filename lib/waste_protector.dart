import 'package:flutter/material.dart';
import 'package:waste_protector/waste_protector_navigator.dart';

class WasteProtector extends StatefulWidget {
  const WasteProtector({super.key});

  static int currentPageIndex = 0;

  static final Map<String, GlobalKey<NavigatorState>> navigatorKeys = {
    "Pantry": GlobalKey<NavigatorState>(),
    "Cookbook": GlobalKey<NavigatorState>(),
    "Add Food": GlobalKey<NavigatorState>(),
    "Recipe": GlobalKey<NavigatorState>(),
  };

  @override
  State<WasteProtector> createState() => _WasteProtectorState();
}

class _WasteProtectorState extends State<WasteProtector> {
  static String _currentPage = "Pantry";

  List<String> pageKeys = ["Pantry", "Cookbook", "Add Food", "Recipe"];

  void _selectPage(String pageItem, int index) {
    if (pageItem == _currentPage) {
      WasteProtector.navigatorKeys[pageItem]!.currentState!
          .popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _currentPage = pageKeys[index];
        WasteProtector.currentPageIndex = index;
      });
    }
  }

  static Widget _buildOffstageNavigator(String pageItem) {
    return Offstage(
        offstage: _currentPage != pageItem,
        child: WasteProtectorNavigator(
            navigatorKey: WasteProtector.navigatorKeys[pageItem]!,
            pageItem: pageItem));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentPage = !await WasteProtector
            .navigatorKeys[_currentPage]!.currentState!
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
          backgroundColor: const Color(0xFF87D68D),
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
            selectedIndex: WasteProtector.currentPageIndex,
            destinations: <Widget>[
              NavigationDestination(
                icon: Image.asset('assets/project_images/home_button_rs.png'),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Image.asset('assets/project_images/cookbook.png'),
                label: 'Cookbook',
              ),
              NavigationDestination(
                icon: Image.asset('assets/project_images/plus_sign.png'),
                label: 'Add Food',
              ),
              NavigationDestination(
                icon: Image.asset('assets/project_images/chef_hat.png'),
                label: 'Get Recipes',
              ),
            ],
          )),
    );
  }
}
