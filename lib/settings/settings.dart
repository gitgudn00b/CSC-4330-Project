import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:waste_protector/main.dart';
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
        Navigator.of(context).popAndPushNamed('/login');
      }
    }
  }

  Widget _buildLogoutButton(
          BuildContext context, double height, double width) =>
      Padding(
          padding: EdgeInsets.symmetric(horizontal: width / 4),
          child: MaterialButton(
              onPressed: _signOut,
              color: const Color(0xFF619267),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              height: height / 10,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.logout, color: Color(0xFFF7FFF6)),
                  Text(
                    'Logout',
                    style: TextStyle(color: Color(0xFFF7FFF6)),
                  )
                ],
              )));

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: const Color(0xFF87D68D),
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(height / 6),
            child: SettingsAppBar()),
        body: Container(
            child: Center(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
              _buildLogoutButton(context, height, width),
              Text(_errorMessage)
            ]))));
  }
}
