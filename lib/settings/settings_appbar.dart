import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    IconButton backButton = IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded),
        color: const Color(0xFF619267),
        onPressed: () => Navigator.of(context).pop(),
        alignment: const Alignment(-1.0, -1.0));

    var height = MediaQuery.of(context).size.height;
    return AppBar(
      automaticallyImplyLeading: false,
      flexibleSpace: backButton,
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
