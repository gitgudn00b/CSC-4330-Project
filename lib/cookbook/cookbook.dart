import 'package:flutter/material.dart';
import 'package:waste_protector/cookbook/cookbook_appbar.dart';

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
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(height / 6),
            child: CookbookAppBar()),
        body: Container(color: const Color(0xFF87D68D)));
  }
}
