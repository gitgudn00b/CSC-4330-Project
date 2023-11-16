import 'package:flutter/material.dart';

class AddFoodAppBar extends AppBar {
  AddFoodAppBar({super.key});

  @override
  State<AddFoodAppBar> createState() => _AddFoodBarState();
}

class _AddFoodBarState extends State<AddFoodAppBar> {
  Text titleText = const Text('Add Food',
      style: TextStyle(
        color: Color(0xFF353535),
        fontSize: 56,
      ));

  Image plusSign = Image.asset('assets/project_images/plus_sign_rs.png');

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return AppBar(
      title: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [plusSign, titleText],
      ),
      backgroundColor: const Color(0xFFF7FFF6),
      elevation: 0,
      toolbarHeight: height / 6,
    );
  }
}
