import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:waste_protector/main.dart';
import 'package:waste_protector/allergies/allergies.dart';
import 'package:waste_protector/settings/settings_appbar.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String _errorMessage = "";

  Future<void> _signOut() async {
    try {
      await supabase.auth.signOut();
    } on AuthException catch (error) {
      _errorMessage = 'Unexpected error occurred';
    } catch (error) {
      _errorMessage = 'Unexpected error occurred';
    } finally {
      if (mounted) {
        SystemNavigator.pop();
      }
    }

    SystemNavigator.pop();

  }

  Widget _buildLogoutButton(
          BuildContext context, double height, double width) =>
      Padding(
          padding: EdgeInsets.symmetric(horizontal: width / 4),
          child: MaterialButton(
              onPressed: _signOut,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              height: height / 10,
              color: const Color(0xFF4E7A53),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.logout,
                    color: Color(0xFFF7FFF6),
                  ),
                  Text(
                    'Logout',
                    style: TextStyle(color: Color(0xFFF7FFF6)),
                  )
                ],
              )));

  Widget _buildAllergiesButton(
          BuildContext context, double height, double width) =>
      Padding(
          padding: EdgeInsets.symmetric(horizontal: width / 4),
          child: MaterialButton(
              onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute<Scaffold>(
                  builder: (context) => const Allergies()));
        },
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              height: height / 10,
              color: const Color(0xFF4E7A53),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.health_and_safety_outlined,
                    color: Color(0xFFF7FFF6),
                  ),
                  Text(
                    'Allergies',
                    style: TextStyle(color: Color(0xFFF7FFF6)),
                  )
                ],
              )));

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(height / 6),
            child: SettingsAppBar()),
        body: Container(
            child: Center(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
              _buildAllergiesButton(context, height, width),
              SizedBox(height: 10),
              _buildLogoutButton(context, height, width),
              Text(_errorMessage)
            ]))));
  }
}
