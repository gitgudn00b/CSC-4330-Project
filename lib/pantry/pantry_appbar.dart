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
        color: Color(0xFF353535),
        fontSize: 56,
      ));

  //Image.asset('assets/project_images/default_pfp.png', scale: 15);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    IconButton profilePicture = IconButton(
        icon: Image.asset('assets/project_images/default_pfp.png'),
        iconSize: 75,
        onPressed: () {
          // _WasteProtectorState.currentPageIndex=4;
          Navigator.push(
              context,
              MaterialPageRoute<Scaffold>(
                  builder: (context) => const Settings()));
        });

    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [profilePicture, titleText],
      ),
      backgroundColor: const Color(0xFFF7FFF6),
      elevation: 0,
      toolbarHeight: height / 6,
    );
  }
}
