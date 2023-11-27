import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:waste_protector/settings/settings.dart';

class PantryAppBar extends AppBar {
  PantryAppBar({super.key});

  @override
  State<PantryAppBar> createState() => _PantryBarState();
}

class _PantryBarState extends State<PantryAppBar> {
  Text titleText = const Text('Welcome!',
      style: TextStyle(
        fontSize: 56,
      ));

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    IconButton profilePicture = IconButton(
        icon: Image.asset('assets/project_images/default_pfp.png'),
        splashRadius: 1,
        iconSize: height / 8,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute<Scaffold>(
                  builder: (context) => const Settings()));
        });

    return AppBar(
        automaticallyImplyLeading: false,
        title: FittedBox(
          fit: BoxFit.fitWidth,
          child: Row(
            //mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [profilePicture, const Text("Welcome!")],
          ),
        ));
  }
}
