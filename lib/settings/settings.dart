import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    //var width = MediaQuery.of(context).size.width;
    return Container(color: const Color(0xFF87D68D));
  }
}
