import 'package:flutter/material.dart';

class Cookbook extends StatefulWidget {
  const Cookbook({super.key});

  @override
  State<Cookbook> createState() => _CookbookState();
}

class _CookbookState extends State<Cookbook> {
  TextField foodName = const TextField(
      decoration: InputDecoration(
          labelText: 'Food Name',
          floatingLabelAlignment: FloatingLabelAlignment.start));

  @override
  Widget build(BuildContext context) {
    //var width = MediaQuery.of(context).size.width;
    return Container(color: Color(0xFF87D68D));
  }
}
