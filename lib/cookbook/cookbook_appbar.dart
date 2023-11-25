import 'package:flutter/material.dart';

class CookbookAppBar extends AppBar {
  CookbookAppBar({super.key});

  @override
  State<CookbookAppBar> createState() => _CookbookBarState();
}

class _CookbookBarState extends State<CookbookAppBar> {
  Text titleText = const Text('Cookbook',
      style: TextStyle(
        fontSize: 56,
      ));

  Image cookbook = Image.asset('assets/project_images/cookbook_rs.png');

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        //mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [cookbook, const Text("Cookbook")],
      ),
    );
  }
}
