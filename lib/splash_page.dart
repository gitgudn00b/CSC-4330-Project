import 'package:flutter/material.dart';
import 'package:waste_protector/main.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Image logo = Image.asset('assets/project_images/wp_logo.png', scale: 1.65);

  @override
  void initState() {
    super.initState();
    _redirect();
  }

  Future<void> _redirect() async {
    await Future.delayed(Duration.zero);
    final session = supabase.auth.currentSession;
    if (!mounted) return;
    if (session != null) {
      Navigator.pushReplacementNamed(context, '/pantry');
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      children: [logo, const CircularProgressIndicator()],
    )));
  }
}
