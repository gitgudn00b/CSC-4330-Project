import 'package:flutter/material.dart';

class SettingsAppBar extends AppBar {
  SettingsAppBar({super.key});

  @override
  State<SettingsAppBar> createState() => _SettingsAppBarState();
}

class _SettingsAppBarState extends State<SettingsAppBar> {
  Text titleText = const Text('Settings',
      style: TextStyle(
        color: Color(0xFF353535),
        fontSize: 56,
      ));

  Image settingsGear = Image.asset('assets/project_images/settings_gear.png');

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return AppBar(
      title: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [settingsGear, titleText],
      ),
      backgroundColor: const Color(0xFFF7FFF6),
      elevation: 0,
      toolbarHeight: height / 6,
    );
  }
}
