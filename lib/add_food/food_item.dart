import 'package:flutter/material.dart';

class FoodItem extends StatelessWidget {
  FoodItem(
      {super.key,
      required this.foodName,
      required this.expirationDate,
      required this.quantity,
      required this.foodIcon});

  final String foodName;
  final String expirationDate;
  final int quantity;
  final Image foodIcon;
  int expirationDateAsInt = 0;

  Text _formatText() {
    return Text(
        "$foodName\nExpiration Date: $expirationDate\nQuantity: $quantity");
  }

  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    int month = int.parse(expirationDate.substring(0, 2));
    int day = int.parse(expirationDate.substring(3, 5));
    int year = int.parse(expirationDate.substring(6, 8));

    expirationDateAsInt = (year * 10000) + (month * 100) + day;

    return Container(
        width: width * 0.75,
        height: height / 10.75,
        margin: EdgeInsets.only(
            top: height / 24, right: width / 8, left: width / 24),
        decoration: BoxDecoration(
            color: Color(0xFFF7FFF6),
            border: Border.all(color: Color(0xFF353535), width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(50))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
                padding: EdgeInsets.only(top: 1.5, right: 8), child: foodIcon),
            _formatText()
          ],
        ));
  }
}
