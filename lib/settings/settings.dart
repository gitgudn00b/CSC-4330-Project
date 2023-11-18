import 'package:flutter/material.dart';
import 'package:waste_protector/settings/settings_appbar.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(height / 6),
            child: SettingsAppBar()),
        body: Container(color: const Color(0xFF87D68D)));
  }
}
