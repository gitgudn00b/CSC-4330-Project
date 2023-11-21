import 'package:flutter/material.dart';

class LoginAppBar extends AppBar {
  LoginAppBar({super.key});

  @override
  State<LoginAppBar> createState() => _LoginBarState();
}

class _LoginBarState extends State<LoginAppBar> {
  Text wasteText = const Text('WASTE',
      style: TextStyle(
        color: Color(0xFF353535),
        fontSize: 40,
      ));
  Text protectorText = const Text('PROTECTOR',
      style: TextStyle(
        color: Color(0xFFF7FFF6),
        fontSize: 40,
      ));

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return AppBar(
      title: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [wasteText, protectorText],
      ),
      backgroundColor: const Color(0xFF87D68D),
      elevation: 0,
      toolbarHeight: height / 6,
    );
  }
}
