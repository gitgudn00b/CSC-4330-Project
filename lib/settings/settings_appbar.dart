import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:waste_protector/add_food/add_food.dart';
import 'package:waste_protector/pantry/pantry.dart';

class SettingsAppBar extends AppBar {
  SettingsAppBar({super.key});

  @override
  State<SettingsAppBar> createState() => _SettingsAppBarState();
}

class _SettingsAppBarState extends State<SettingsAppBar> {
  Text titleText = const Text('Settings',
      style: TextStyle(
        fontSize: 56,
      ));

  Image settingsGear = Image.asset('assets/project_images/settings_gear.png');

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    IconButton backButton = IconButton(
        icon: Icon(
          Icons.arrow_back,
          size: 30,
        ),
        color: const Color(0xFF619267),
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute<Scaffold>(
                builder: (context) => Pantry(pantryList: AddFood.foodItems))),
        alignment: const Alignment(-1, 50));

    return AppBar(
      automaticallyImplyLeading: false,
      flexibleSpace: backButton,
      title: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [settingsGear, titleText],
      ),
    );
  }
}
