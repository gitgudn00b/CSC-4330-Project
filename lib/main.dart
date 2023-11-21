import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:waste_protector/register_login/login.dart';
import 'package:waste_protector/splash_page.dart';
import 'package:waste_protector/waste_protector.dart';

void main() async {
  await Supabase.initialize(
      url: 'https://nfwotckotoawmkdefais.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5md290Y2tvdG9hd21rZGVmYWlzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDA1MzY2OTMsImV4cCI6MjAxNjExMjY5M30.PYVXB0ToJOgt4xTvQFY6uigFXau370x6SgY_DHmCauI',
      authFlowType: AuthFlowType.pkce);
  runApp(const WasteProtectorInit());
}

final supabase = Supabase.instance.client;

class WasteProtectorInit extends StatelessWidget {
  const WasteProtectorInit({super.key});

  Widget build(BuildContext context) {
    return SafeArea(
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                textTheme: Theme.of(context).textTheme.apply(
                      fontFamily: 'Fredoka',
                      bodyColor: const Color(0xFF353535),
                      displayColor: const Color(0xFF353535),
                      decorationColor: const Color(0xFF353535),
                    )),
            initialRoute: '/',
            routes: <String, WidgetBuilder>{
          '/': (context) => const SplashPage(),
          '/login': (context) => const WasteProtectorLogin(),
          '/pantry': (context) => const WasteProtector()
        }));
  }
}
