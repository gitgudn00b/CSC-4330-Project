import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:waste_protector/main.dart';

class WasteProtectorUser {
  WasteProtectorUser({required this.userId});

  static final List<Image> foodIcons = [
    Image.asset('assets/project_images/apple_icon.png'),
    Image.asset('assets/project_images/orange_icon.png'),
    Image.asset('assets/project_images/lemon_icon.png'),
    Image.asset('assets/project_images/watermelon_icon.png'),
    Image.asset('assets/project_images/pineapple_icon.png')
  ];

  var userId;

  bool userInitialized = false;

  List<dynamic> foodNamesUnformatted = [];
  List<dynamic> expirationDatesUnformatted = [];
  List<dynamic> quantitiesUnformatted = [];
  dynamic foodCountUnformatted = 0;

  List<String> foodNames = [];
  List<String> expirationDates = [];
  List<int> quantities = [];
  int foodCount = 0;

  List<String> formatStringLists(String unformattedString, String typeOfList) {
    List<String> formattedList = [];
    String initialString = "";
    int length = unformattedString.length;

    if (typeOfList == "food names") {
      initialString = unformattedString.substring(14, length - 2);
    } else if (typeOfList == "expiration dates") {
      initialString = unformattedString.substring(20, length - 2);
    } else if (typeOfList == "quantity") {
      initialString = unformattedString.substring(12, length - 2);
    }
    formattedList = initialString.split(", ");

    return formattedList;
  }

  List<int> formatIntegerLists(String unformattedString) {
    int length = unformattedString.length;
    String initialString = unformattedString.substring(12, length - 2);
    List<int> formattedIntList = [];
    List<String> stringList = initialString.split(", ");
    for (int i = 0; i < stringList.length; i++) {
      formattedIntList.add(int.parse(stringList[i]));
    }
    return formattedIntList;
  }

  int getFoodCount(String unformattedFoodCount) {
    return int.parse(unformattedFoodCount.substring(13, 14));
  }

  Future<void> initWasteProtectorUser() async {
    try {
      foodCountUnformatted = await supabase
          .from('food_items')
          .select('food_count')
          .eq('id', userId);
      foodCount = getFoodCount(foodCountUnformatted[0].toString());
      print("this is the food count $foodCount");
      if (foodCount > 0) {
        foodNamesUnformatted = await supabase
            .from('food_items')
            .select('food_names')
            .eq('id', userId);
        expirationDatesUnformatted = await supabase
            .from('food_items')
            .select('expiration_dates')
            .eq('id', userId);
        quantitiesUnformatted = await supabase
            .from('food_items')
            .select('quantity')
            .eq('id', userId);
      }
    } on PostgrestException catch (error) {
      print(error.message);
    } catch (error) {
      print("oopsie poopsie ${error.toString()}");
    }
    foodNames =
        formatStringLists(foodNamesUnformatted[0].toString(), "food names");
    expirationDates = formatStringLists(
        expirationDatesUnformatted[0].toString(), "expiration dates");
    quantities = formatIntegerLists(quantitiesUnformatted[0].toString());
    userInitialized = true;
  }
}
