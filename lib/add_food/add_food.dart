import 'package:flutter/material.dart';

class AddFood extends StatefulWidget {
  AddFood({super.key});

  @override
  State<AddFood> createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  TextField foodName = const TextField(
      decoration: InputDecoration(
          labelText: 'Food Name',
          floatingLabelAlignment: FloatingLabelAlignment.start));

  @override
  Widget build(BuildContext context) {
    //var width = MediaQuery.of(context).size.width;
    return Container(color: const Color(0xFF87D68D));
  }
}
