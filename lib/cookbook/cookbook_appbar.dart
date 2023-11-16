import 'package:flutter/material.dart';

class CookbookAppBar extends AppBar {
  CookbookAppBar({super.key});

  @override
  State<CookbookAppBar> createState() => _CookbookBarState();
}

class _CookbookBarState extends State<CookbookAppBar> {
  Text titleText = const Text('Cookbook',
      style: TextStyle(
        color: Color(0xFF353535),
        fontSize: 56,
      ));

  Image cookbook = Image.asset('assets/project_images/cookbook_rs.png');

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return AppBar(
      title: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [cookbook, titleText],
      ),
      backgroundColor: const Color(0xFFF7FFF6),
      elevation: 0,
      toolbarHeight: height / 6,
    );
  }
}
