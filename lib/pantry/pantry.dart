import 'package:flutter/material.dart';
import 'package:waste_protector/add_food/food_item.dart';
import 'package:waste_protector/pantry/pantry_appbar.dart';
import 'package:waste_protector/main.dart';
import 'package:waste_protector/user.dart';

class PantryList with ChangeNotifier {
  final List<FoodItem> _foodItems = <FoodItem>[];

  void add(FoodItem food) {
    _foodItems.add(food);
    notifyListeners();
  }

  sortByExpirationDate() {
    int length = _foodItems.length;
    for (int i = 0; i < length - 1; i++) {
      int indexWithMinExpirationDate = i;
      for (int j = i + 1; j < length; j++) {
        if (_foodItems[j].expirationDateAsInt <
            _foodItems[indexWithMinExpirationDate].expirationDateAsInt) {
          indexWithMinExpirationDate = j;
        }
        print(_foodItems[indexWithMinExpirationDate].foodName +
            "\n+${_foodItems[indexWithMinExpirationDate].expirationDateAsInt}");
      }
      FoodItem temp = _foodItems[indexWithMinExpirationDate];
      _foodItems[indexWithMinExpirationDate] = _foodItems[i];
      _foodItems[i] = temp;
    }
  }

  List<FoodItem> get foodItems => _foodItems.toList();
}

class Pantry extends StatefulWidget {
  const Pantry({super.key, required this.pantryList});

  void initPantry() async {
    WasteProtectorUser loggedInUser = WasteProtectorInit.getLoggedInUser();
    await loggedInUser.initWasteProtectorUser();

    print("this is the food count ${loggedInUser.foodCount}");

    for (int i = 0; i < loggedInUser.foodCount; i++) {
      FoodItem foodItem = FoodItem(
          foodName: loggedInUser.foodNames[i],
          expirationDate: loggedInUser.expirationDates[i],
          quantity: loggedInUser.quantities[i],
          foodIcon: WasteProtectorUser
              .foodIcons[i % WasteProtectorUser.foodIcons.length]);
      pantryList.add(foodItem);
    }
    pantryList.sortByExpirationDate();
  }

  final PantryList pantryList;

  PantryList getPantryList() => pantryList;

  @override
  State<Pantry> createState() => _PantryState();
}

class _PantryState extends State<Pantry> {
  @override
  void initState() {
    super.initState();
    widget.initPantry();
  }

  ListenableBuilder _buildListenableBuilder(double padding) {
    return ListenableBuilder(
        listenable: widget.pantryList,
        builder: (BuildContext context, Widget? child) {
          return RawScrollbar(
              thumbVisibility: true,
              crossAxisMargin: padding / 6,
              mainAxisMargin: padding / 6,
              radius: Radius.circular(50),
              thickness: padding / 6,
              thumbColor: Color(0xFF6db078),
              child: ListView.builder(
                padding: EdgeInsets.only(bottom: padding),
                itemBuilder: (BuildContext context, int index) {
                  return widget.pantryList.foodItems[index];
                },
                itemCount: widget.pantryList.foodItems.length,
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFF87D68D),
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(height / 6), child: PantryAppBar()),
      body: _buildListenableBuilder(height / 24),
    );
  }
}
