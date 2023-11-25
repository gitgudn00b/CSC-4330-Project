import 'package:flutter/material.dart';

class AddFoodAppBar extends AppBar {
  AddFoodAppBar({super.key});

  @override
  State<AddFoodAppBar> createState() => _AddFoodBarState();
}

class _AddFoodBarState extends State<AddFoodAppBar> {
  Text titleText = const Text('Add Food');

  Image plusSign = Image.asset('assets/project_images/plus_sign_rs.png');

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        //mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [plusSign, const Text("Add Food")],
      ),
    );
  }
}
