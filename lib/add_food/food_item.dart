import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:waste_protector/add_food/add_food.dart';
import 'package:waste_protector/main.dart';
import 'package:waste_protector/user.dart';

class FoodItem extends StatefulWidget {
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
  State<FoodItem> createState() => _FoodItemState();
}

class _FoodItemState extends State<FoodItem> {
  Text _formatText() {
    return Text(
        "${widget.foodName}\nExpiration Date: ${widget.expirationDate}\nQuantity: ${widget.quantity}");
  }

  bool foodItemPressed = false;

  void _deleteFoodItem() async {
    WasteProtectorUser loggedInUser = WasteProtectorInit.getLoggedInUser();
    if (!loggedInUser.userInitialized) {
      await loggedInUser.initWasteProtectorUser();
    }
    List<String> currentFoodNames = loggedInUser.foodNames;
    List<String> currentExpirationDates = loggedInUser.expirationDates;
    List<int> currentQuantities = loggedInUser.quantities;
    int foodCount = loggedInUser.foodCount;

    currentFoodNames.remove(widget.foodName);
    currentExpirationDates.remove(widget.expirationDate);
    currentQuantities.remove(widget.quantity);

    try {
      await supabase.from('food_items').update({
        'food_names': currentFoodNames,
        'expiration_dates': currentExpirationDates,
        'quantity': currentQuantities,
        'food_count': foodCount - 1,
      }).eq('id', loggedInUser.userId);
    } on PostgrestException catch (error) {
      print(error.code);
      print(error.hint);
      print(error.details);
      print(error.message);
    }
    AddFood.foodItems.remove(widget);
  }

  Widget _displayDeleteButton() {
    if (foodItemPressed) {
      return IconButton(
          padding: EdgeInsets.only(left: 20),
          onPressed: () {
            setState(() {
              _deleteFoodItem();
            });
          },
          icon: const Icon(Icons.delete_sharp, color: Color(0xff619267)));
    }
    return const Text("");
  }

  Text _expirationDateStatus() {
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);
    String stringDate = date.toString().substring(2, 10);
    int currentDate = int.parse(stringDate.split("-").join());
    if ((widget.expirationDateAsInt - currentDate) <= 0) {
      return const Text("(EX)", style: TextStyle(color: Colors.red));
    }
    if ((widget.expirationDateAsInt - currentDate) <= 3) {
      return const Text("  (!!!)", style: TextStyle(color: Colors.red));
    }
    return Text("      ");
  }

  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    int month = int.parse(widget.expirationDate.substring(0, 2));
    int day = int.parse(widget.expirationDate.substring(3, 5));
    int year = int.parse(widget.expirationDate.substring(6, 8));

    widget.expirationDateAsInt = (year * 10000) + (month * 100) + day;

    return MaterialButton(
        onPressed: () {
          setState(() {
            if (!foodItemPressed) {
              foodItemPressed = true;
            } else {
              foodItemPressed = false;
            }
          });
        },
        child: Container(
            width: width * 0.9,
            height: height / 13,
            margin: EdgeInsets.only(
                top: height / 24, right: width / 8, left: width / 60),
            decoration: BoxDecoration(
                color: const Color(0xFFF7FFF6),
                border: Border.all(color: const Color(0xFF353535), width: 2.0),
                borderRadius: const BorderRadius.all(Radius.circular(50))),
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.start,
              //crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 1.5, right: 8),
                    child: widget.foodIcon),
                _formatText(),
                _expirationDateStatus(),
                _displayDeleteButton()
              ],
            )));
  }
}
