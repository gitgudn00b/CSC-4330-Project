import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AllergiesAppBar extends AppBar {
  AllergiesAppBar({super.key});

  @override
  State<AllergiesAppBar> createState() => _AllergiesAppBarState();
}

class _AllergiesAppBarState extends State<AllergiesAppBar> {
  Text titleText = const Text('Allergies',
      style: TextStyle(
        fontSize: 56,
      ));

  Image allergiesHand = Image.asset('assets/project_images/allergies_hand.png'); //!!!

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        //mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [allergiesHand, const Text("Allergies")],
      ),
    );
  }
}
