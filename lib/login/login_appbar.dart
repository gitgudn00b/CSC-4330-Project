import 'package:flutter/material.dart';

class LoginAppBar extends AppBar {
  LoginAppBar({super.key});

  @override
  State<LoginAppBar> createState() => _LoginBarState();
}

class _LoginBarState extends State<LoginAppBar> {
  FittedBox _buildTitleText(double width, double height) {
    Text wasteText = const Text(
      'WASTE',
    );
    Text protectorText = const Text('PROTECTOR',
        style: TextStyle(
          color: Color(0xFFF7FFF6),
        ));
    return FittedBox(
        fit: BoxFit.fitWidth,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [wasteText, protectorText]));
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return AppBar(
      title: _buildTitleText(width, height),
      backgroundColor: const Color(0xFF87D68D),
      elevation: 0,
      toolbarHeight: height / 6,
    );
  }
}
