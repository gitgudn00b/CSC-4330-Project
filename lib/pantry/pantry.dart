import 'package:flutter/material.dart';
import 'package:waste_protector/add_food/food_item.dart';
import 'package:waste_protector/pantry/pantry_appbar.dart';
import 'package:waste_protector/main.dart';
import 'package:waste_protector/user.dart';

class PantryList with ChangeNotifier {
  final List<FoodItem> _foodItems = <FoodItem>[];

  bool _loading = true;

  void add(FoodItem food) {
    _foodItems.add(food);
    notifyListeners();
  }

  void insert(FoodItem food) {
    int index = 0;
    while (index < _foodItems.length) {
      if (food.expirationDateAsInt < _foodItems[index].expirationDateAsInt) {
        _foodItems.insert(index, food);
        notifyListeners();
        return;
      }
      index++;
    }
    _foodItems.add(food);
    notifyListeners();
  }

  void remove(FoodItem food) {
    _foodItems.remove(food);
    notifyListeners();
    _loading = true;
  }

  List<FoodItem> get foodItems => _foodItems.toList();
}

class Pantry extends StatefulWidget {
  Pantry({super.key, required this.pantryList});
  final PantryList pantryList;

  PantryList getPantryList() => pantryList;

  void initPantry() async {
    pantryList._loading = true;
    WasteProtectorUser loggedInUser = WasteProtectorInit.getLoggedInUser();
    try {
      await loggedInUser.initWasteProtectorUser();
    } catch (error) {
      print("oopsies");
    } finally {
      for (int i = 0; i < loggedInUser.foodCount; i++) {
        FoodItem foodItem = FoodItem(
            foodName: loggedInUser.foodNamesSorted[i],
            expirationDate: loggedInUser.expirationDatesSorted[i],
            quantity: loggedInUser.quantitiesSorted[i],
            foodIcon: WasteProtectorUser
                .foodIcons[i % WasteProtectorUser.foodIcons.length]);
        pantryList.add(foodItem);
      }
    }
  }

  @override
  State<Pantry> createState() => _PantryState();
}

class _PantryState extends State<Pantry> {
  @override
  void initState() {
    super.initState();
    widget.initPantry();
    if (mounted) {
      setState(() {
        widget.pantryList._loading = false;
      });
    }
  }

  ListenableBuilder _buildListenableBuilder(double padding) {
    return ListenableBuilder(
        listenable: widget.pantryList,
        builder: (BuildContext context, Widget? child) {
          return RawScrollbar(
              thumbVisibility: true,
              crossAxisMargin: padding / 4,
              mainAxisMargin: padding / 3,
              radius: const Radius.circular(50),
              thickness: padding / 6,
              thumbColor: const Color(0xFF6db078),
              child: ListView.builder(
                padding: EdgeInsets.only(bottom: padding),
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return Padding(
                        padding: EdgeInsets.only(
                            left: padding,
                            top: padding / 4,
                            bottom: padding / 4),
                        child: const Text("Pantry (Sorted by Expiration Date):",
                            style: TextStyle(fontSize: 14)));
                  } else {
                    return widget.pantryList.foodItems[index - 1];
                  }
                },
                itemCount: widget.pantryList.foodItems.length + 1,
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
      body: widget.pantryList._loading
          ? const Center(
              child: CircularProgressIndicator(color: Color(0xFF619267)))
          : _buildListenableBuilder(height / 24),
    );
  }
}
