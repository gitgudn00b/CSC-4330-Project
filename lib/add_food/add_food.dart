import 'package:flutter/material.dart';
import 'package:waste_protector/add_food/add_food_appbar.dart';

class AddFood extends StatefulWidget {
  AddFood({super.key});

  @override
  State<AddFood> createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    var width = MediaQuery.of(context).size.width;

    Padding foodName2 = Padding(
      padding: EdgeInsets.only(bottom: height / 35),
      child: TextFormField(
        decoration: const InputDecoration(
          filled: true,
          fillColor: Color(0xFFF7FFF6),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF353535), width: 4.0),
          ),
        ),
      ),
    );

    Padding expirationDate = Padding(
      padding: EdgeInsets.only(bottom: height / 35),
      child: TextFormField(
        decoration: const InputDecoration(
          filled: true,
          fillColor: Color(0xFFF7FFF6),
          hintText: 'MM/DD/YY',
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF353535), width: 4.0),
          ),
        ),
      ),
    );

    Padding quantity = Padding(
      padding: EdgeInsets.only(bottom: height / 35),
      child: TextFormField(
        decoration: const InputDecoration(
          filled: true,
          fillColor: Color(0xFFF7FFF6),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF353535), width: 4.0),
          ),
        ),
      ),
    );

    Padding foodNameText = Padding(
      padding: EdgeInsets.only(bottom: height / 50),
      child: const Text('Enter Food Name:',
          style: TextStyle(color: Color(0xFF353535), fontSize: 14)),
    );

    Padding expirationText = Padding(
      padding: EdgeInsets.only(bottom: height / 50),
      child: const Text('Enter Expiration Date:',
          style: TextStyle(color: Color(0xFF353535), fontSize: 14)),
    );

    Padding quantityText = Padding(
      padding: EdgeInsets.only(bottom: height / 50),
      child: const Text('Enter Quantity:',
          style: TextStyle(color: Color(0xFF353535), fontSize: 14)),
    );

    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(height / 6), child: AddFoodAppBar()),
        body: Container(
            padding: EdgeInsets.only(
                left: width / 25, right: width / 10, top: height / 50),
            color: const Color(0xFF87D68D),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  foodNameText,
                  foodName2,
                  expirationText,
                  expirationDate,
                  quantityText,
                  quantity
                ])));
  }
}
