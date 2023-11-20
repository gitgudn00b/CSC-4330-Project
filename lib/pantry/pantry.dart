import 'package:flutter/material.dart';
import 'package:waste_protector/add_food/food_item.dart';
import 'package:waste_protector/pantry/pantry_appbar.dart';

class PantryList with ChangeNotifier {
  final List<FoodItem> _foodItems = <FoodItem>[];

  void add(FoodItem food) {
    _foodItems.add(food);
    notifyListeners();
    print(_foodItems.length);
  }

  List<FoodItem> get foodItems => _foodItems.toList();
}

class Pantry extends StatefulWidget {
  const Pantry({super.key, required this.pantryList});

  final PantryList pantryList;

  PantryList getPantryList() => pantryList;

  @override
  State<Pantry> createState() => _PantryState();
}

class _PantryState extends State<Pantry> {
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
              thumbColor: Color(0xFF619267),
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
