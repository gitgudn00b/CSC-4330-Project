import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:waste_protector/add_food/add_food_appbar.dart';
import 'package:waste_protector/add_food/date_text_formatter.dart';
import 'package:waste_protector/add_food/food_item.dart';
import 'package:waste_protector/main.dart';
import 'package:waste_protector/pantry/pantry.dart';
import 'package:waste_protector/user.dart';

class AddFood extends StatefulWidget {
  const AddFood({super.key});

  static PantryList foodItems = PantryList();

  @override
  State<AddFood> createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  WasteProtectorUser loggedInUser = WasteProtectorInit.getLoggedInUser();

  List<String> currentFoodNames = [];
  List<String> currentExpirationDates = [];
  List<int> currentQuantities = [];
  int foodCount = 0;

  void _getCurrentUserFoodItems() async {
    if (!loggedInUser.userInitialized) {
      await loggedInUser.initWasteProtectorUser();
    }
    currentFoodNames = loggedInUser.foodNamesSorted;
    currentExpirationDates = loggedInUser.expirationDatesSorted;
    currentQuantities = loggedInUser.quantitiesSorted;
    foodCount = loggedInUser.foodCount;
  }

  @override
  void initState() {
    _getCurrentUserFoodItems();
    super.initState();
  }

  final TextEditingController _foodNameController = TextEditingController();

  final TextEditingController _expirationDateController =
      TextEditingController();

  final _quantityKey = GlobalKey<FormState>();

  final List<String> _labelTexts = [
    "Enter Food Name:",
    "Enter Food Name",
    "Enter Expiration Date (MMDDYY):",
    "Enter Expiration Date",
    "Select Quantity:",
    "Quantity",
    "Submit",
    ""
  ];

  List<int> daysInAMonth = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

  int _dropdownValue = 1;

  final GlobalKey<FormFieldState> _foodItemKey = GlobalKey<FormFieldState>();

  final GlobalKey<FormFieldState> _expirationDateKey =
      GlobalKey<FormFieldState>();

  final InputDecoration _textFieldDecoration = const InputDecoration(
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF619267), width: 2.0)),
      enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF619267), width: 4.0)),
      errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF619267), width: 4.0)),
      focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF619267), width: 4.0)),
      prefixIconColor: Color(0xFF619267),
      focusColor: Color(0xFF619267),
      fillColor: Color(0xFFF7FFF6),
      filled: true,
      errorStyle: TextStyle(color: Color(0xFF353535)));

  void addFoodItem() async {
    String foodName = _foodNameController.text;
    String expirationDate = _expirationDateController.text;
    int foodQuantity = _dropdownValue;
    Image foodIcon = WasteProtectorUser
        .foodIcons[foodCount % WasteProtectorUser.foodIcons.length];

    currentFoodNames.add(foodName);
    currentExpirationDates.add(expirationDate);
    currentQuantities.add(foodQuantity);

    FoodItem foodItem = FoodItem(
        foodName: foodName,
        expirationDate: expirationDate,
        quantity: foodQuantity,
        foodIcon: foodIcon,
        expirationDateAsInt:
            (int.parse(expirationDate.substring(6, 8)) * 10000) +
                (int.parse(expirationDate.substring(0, 2)) * 100) +
                int.parse(expirationDate.substring(3, 5)));
    try {
      await supabase.from('food_items').update({
        'food_names': currentFoodNames,
        'expiration_dates': currentExpirationDates,
        'quantity': currentQuantities,
        'food_count': foodCount + 1,
      }).eq('id', loggedInUser.userId);
    } on PostgrestException catch (error) {
      print(error.code);
      print(error.hint);
      print(error.details);
      print(error.message);
    }

    AddFood.foodItems.insert(foodItem);
    foodCount += 1;
  }

  String _displaySubmitText(String foodName) {
    return "Successfully added $foodName to your pantry!";
  }

  Widget _buildSubmitButton() => MaterialButton(
      onPressed: () async {
        if (_foodItemKey.currentState!.validate() &&
            _expirationDateKey.currentState!.validate()) {
          addFoodItem();
          setState(() {
            _labelTexts[_labelTexts.length - 1] =
                _displaySubmitText(_foodNameController.text);
          });
          _foodNameController.clear();
          _expirationDateController.clear();
          _quantityKey.currentState?.reset();
        }
      },
      color: const Color(0xFF4E7A53),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(50))),
      child: const Text(
        'Add Food',
        style: TextStyle(color: Color(0xFFF7FFF6)),
      ));

  Widget _buildTextField() => TextFormField(
      validator: (value) {
        if (value == null) return "ERROR: Please enter the name of your item";
        if (value.isEmpty) return "ERROR: Please enter the name of your item";
        return null;
      },
      key: _foodItemKey,
      controller: _foodNameController,
      keyboardType: TextInputType.text,
      cursorColor: const Color(0xFF619267),
      decoration: _textFieldDecoration.copyWith(
          prefixIcon: const Icon(Icons.fastfood)));

  Widget _buildDateField() => TextFormField(
      inputFormatters: [DateTextFormatter()],
      key: _expirationDateKey,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "ERROR: Please enter an expiration date for your item";
        } else {
          if (value.length != 8) {
            return "ERROR: Please enter a valid date";
          } else {
            int month = int.parse(value.substring(0, 2));
            int day = int.parse(value.substring(3, 5));
            int year = int.parse(value.substring(6, 8));
            if (year % 4 == 0) {
              daysInAMonth[2] = 29;
            }
            if (month < 1 || month > 12 || day > daysInAMonth[month]) {
              return "ERROR: Please enter a valid date";
            } else {
              DateTime now = new DateTime.now();
              DateTime date = new DateTime(now.year, now.month, now.day);
              String stringDate = date.toString().substring(2, 10);
              int currentDate = int.parse(stringDate.split("-").join());
              int dateEntered = (year * 10000) + (month * 100) + day;
              if (dateEntered < currentDate) {
                return "ERROR: Expirations dates should be in the future";
              }
            }
          }
          daysInAMonth[2] = 28;
          return null;
        }
      },
      controller: _expirationDateController,
      keyboardType: TextInputType.datetime,
      cursorColor: const Color(0xFF619267),
      decoration: _textFieldDecoration.copyWith(
          prefixIcon: const Icon(Icons.calendar_month)));

  Widget _buildDropdownField() => DropdownButtonFormField(
        value: _dropdownValue,
        decoration: _textFieldDecoration.copyWith(
            prefixIcon: const Icon(Icons.format_list_bulleted),
            focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF619267), width: 4.0))),
        onChanged: (int? value) {
          setState(() {
            _dropdownValue = value!;
          });
        },
        items: const [
          DropdownMenuItem(value: 1, child: Text('1')),
          DropdownMenuItem(value: 2, child: Text('2')),
          DropdownMenuItem(value: 3, child: Text('3')),
          DropdownMenuItem(value: 4, child: Text('4')),
          DropdownMenuItem(value: 5, child: Text('5'))
        ],
      );

  Padding _buildPaddedForm(String labelText, double topPadding,
      double bottomPadding, double leftPadding, double rightPadding) {
    if (labelText == "Quantity") {
      return Padding(
          padding: EdgeInsets.only(
              bottom: bottomPadding, left: leftPadding, right: rightPadding),
          child: _buildDropdownField());
    } else if (labelText == "Enter Food Name") {
      return Padding(
          padding: EdgeInsets.only(
              bottom: bottomPadding, left: leftPadding, right: rightPadding),
          child: _buildTextField());
    } else if (labelText == "Enter Expiration Date") {
      return Padding(
          padding: EdgeInsets.only(
              bottom: bottomPadding, left: leftPadding, right: rightPadding),
          child: _buildDateField());
    } else if (labelText == "Submit") {
      return Padding(
          padding: EdgeInsets.only(
              top: topPadding * 2,
              bottom: bottomPadding * 2,
              left: rightPadding * 2,
              right: rightPadding * 2),
          child: _buildSubmitButton());
    } else if (labelText == "Enter Food Name:") {
      return Padding(
          padding: EdgeInsets.only(
              top: topPadding,
              bottom: topPadding,
              left: leftPadding,
              right: rightPadding),
          child: Text(labelText));
    }
    return Padding(
        padding: EdgeInsets.only(
            bottom: topPadding, left: leftPadding, right: rightPadding),
        child: Text(labelText));
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    var width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AddFoodAppBar(),
        body: ListView.builder(
            itemCount: _labelTexts.length,
            itemBuilder: (BuildContext context, int index) {
              return _buildPaddedForm(_labelTexts[index], height / 35,
                  height / 50, width / 15, width / 10);
            }));
  }
}
