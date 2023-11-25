import 'dart:async';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:waste_protector/main.dart';
import 'package:waste_protector/register_login/login_appbar.dart';

class WasteProtectorLogin extends StatefulWidget {
  const WasteProtectorLogin({super.key});

  @override
  State<WasteProtectorLogin> createState() => _WasteProtectorLoginState();

  static bool logoutButtonPressed = false;
}

class _WasteProtectorLoginState extends State<WasteProtectorLogin> {
  final TextEditingController _usernameController = TextEditingController();

  Image logo = Image.asset('assets/project_images/wp_logo.png',
      alignment: Alignment.topCenter, scale: 1.65);

  final List<String> _labelTexts = [
    "logo",
    "Email Address:",
    "email",
    "login",
    ""
  ];

  bool _isLoading = false;

  bool _redirecting = false;

  late final StreamSubscription<AuthState> _authSubscription;

  Future<void> _signIn() async {
    try {
      setState(() {
        _isLoading = true;
      });
      await supabase.auth.signInWithOtp(
        email: _usernameController.text.trim(),
        emailRedirectTo: 'io.supabase.flutterquickstart://login-callback/',
      );
    } on AuthException catch (error) {
      _labelTexts[_labelTexts.length - 1] = "Authentication Error Occurred";
    } catch (error) {
      _labelTexts[_labelTexts.length - 1] = "Unknown Error Occurred";
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
          WasteProtectorLogin.logoutButtonPressed = false;
          _labelTexts[_labelTexts.length - 1] =
              "Please check your email for login link";
        });
      }
    }
  }

  @override
  void initState() {
    _authSubscription = supabase.auth.onAuthStateChange.listen((data) {
      if (_redirecting) return;
      final session = data.session;
      if (session != null) {
        _redirecting = true;
        WasteProtectorLogin.logoutButtonPressed = false;
        Navigator.of(context).pushReplacementNamed('/pantry');
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _authSubscription.cancel();
    super.dispose();
  }

  Widget _buildUsernameField() => TextFormField(
      controller: _usernameController,
      keyboardType: TextInputType.emailAddress,
      cursorColor: const Color(0xFF619267),
      decoration: const InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF619267), width: 2.0)),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF619267), width: 2.0)),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF619267), width: 2.0)),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF619267), width: 2.0)),
          prefixIcon: Icon(Icons.person),
          prefixIconColor: Color(0xFF619267),
          focusColor: Color(0xFF619267),
          fillColor: Color(0xFFF7FFF6),
          filled: true,
          errorStyle: TextStyle(color: Color(0xFF353535))));

  Widget _buildSubmitButton(BuildContext context) => MaterialButton(
      onPressed: _isLoading ? null : _signIn,
      color: const Color(0xFF619267),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(50))),
      child: const Text(
        'Login',
        style: TextStyle(color: Color(0xFFF7FFF6)),
      ));

  Padding _buildPaddedForm(
      String labelText,
      double topPadding,
      double bottomPadding,
      double leftPadding,
      double rightPadding,
      BuildContext context) {
    if (labelText == "logo") {
      return Padding(
          padding: EdgeInsets.only(
              top: topPadding / 4, left: leftPadding, right: leftPadding),
          child: logo);
    } else if (labelText == "email") {
      return Padding(
          padding: EdgeInsets.only(
              left: leftPadding, right: rightPadding, bottom: bottomPadding),
          child: _buildUsernameField());
    } else if (labelText == "login") {
      return Padding(
          padding: EdgeInsets.only(
              top: topPadding,
              left: rightPadding * 2,
              right: rightPadding * 2,
              bottom: topPadding),
          child: _buildSubmitButton(context));
    }
    return Padding(
        padding: EdgeInsets.only(
            top: topPadding, left: leftPadding, right: rightPadding),
        child: Text(labelText));
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(height / 6), child: LoginAppBar()),
      body: ListView.builder(
          itemCount: _labelTexts.length,
          itemBuilder: (BuildContext context, int index) {
            return _buildPaddedForm(_labelTexts[index], height / 35,
                height / 50, width / 15, width / 10, context);
          }),
      backgroundColor: const Color(0xFFF7FFF6),
    );
  }
}
