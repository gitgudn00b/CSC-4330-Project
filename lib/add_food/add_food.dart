import 'package:flutter/material.dart';
import 'package:waste_protector/add_food/add_food_appbar.dart';
import 'package:waste_protector/add_food/date_text_formatter.dart';
import 'package:waste_protector/add_food/food_item.dart';
import 'package:waste_protector/pantry/pantry.dart';

class AddFood extends StatefulWidget {
  const AddFood({super.key});

  static PantryList foodItems = PantryList();

  @override
  State<AddFood> createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  final TextEditingController _foodNameController = TextEditingController();

  final TextEditingController _expirationDateController =
      TextEditingController();

  final _quantityKey = GlobalKey<FormState>();

  static int _foodCount = 0;

  List<String> _labelTexts = [
    "Enter Food Name:",
    "Enter Food Name",
    "Enter Expiration Date (MM/DD/YY):",
    "Enter Expiration Date",
    "Select Quantity:",
    "Quantity",
    "Submit",
    ""
  ];

  final List<Image> foodIcons = [
    Image.asset('assets/project_images/apple_icon.png'),
    Image.asset('assets/project_images/orange_icon.png'),
    Image.asset('assets/project_images/lemon_icon.png'),
    Image.asset('assets/project_images/watermelon_icon.png'),
    Image.asset('assets/project_images/pineapple_icon.png')
  ];

  List<int> daysInAMonth = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

  int _dropdownValue = 1;

  final GlobalKey<FormFieldState> _foodItemKey = GlobalKey<FormFieldState>();

  final GlobalKey<FormFieldState> _expirationDateKey =
      GlobalKey<FormFieldState>();

  void addFoodItem() {
    String foodName = _foodNameController.text;
    String foodExpirationDate = _expirationDateController.text;
    int foodQuantity = _dropdownValue;
    Image foodIcon = foodIcons[_foodCount % foodIcons.length];

    FoodItem foodItem = FoodItem(
      foodName: foodName,
      expirationDate: foodExpirationDate,
      quantity: foodQuantity,
      foodIcon: foodIcon,
    );

    AddFood.foodItems.add(foodItem);
    _foodCount += 1;
  }

  String _displaySubmitText(String foodName) {
    return "Successfully added $foodName to your pantry!";
  }

  Widget _buildSubmitButton() => MaterialButton(
      onPressed: () {
        if (_foodItemKey.currentState!.validate() &&
            _expirationDateKey.currentState!.validate()) {
          String foodName = _foodNameController.text;
          String foodExpirationDate = _expirationDateController.text;
          int foodQuantity = _dropdownValue;
          Image foodIcon = foodIcons[_foodCount % foodIcons.length];

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
      color: const Color(0xFF619267),
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
      decoration: const InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF619267), width: 2.0)),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF619267), width: 2.0)),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF619267), width: 2.0)),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF619267), width: 2.0)),
          prefixIcon: Icon(Icons.fastfood),
          prefixIconColor: Color(0xFF619267),
          focusColor: Color(0xFF619267),
          fillColor: Color(0xFFF7FFF6),
          filled: true,
          errorStyle: TextStyle(color: Color(0xFF353535))));

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
            }
          }
          return null;
        }
      },
      controller: _expirationDateController,
      keyboardType: TextInputType.datetime,
      cursorColor: const Color(0xFF619267),
      decoration: const InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF619267), width: 2.0)),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF619267), width: 2.0)),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF619267), width: 2.0)),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF619267), width: 2.0)),
          prefixIcon: Icon(Icons.calendar_month),
          prefixIconColor: Color(0xFF619267),
          focusColor: Color(0xFF619267),
          fillColor: Color(0xFFF7FFF6),
          filled: true,
          errorStyle: TextStyle(color: Color(0xFF353535))));

  Widget _buildDropdownField() => DropdownButtonFormField(
        value: _dropdownValue,
        decoration: const InputDecoration(
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF619267), width: 2.0)),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF619267), width: 2.0)),
            prefixIcon: Icon(Icons.format_list_bulleted),
            prefixIconColor: Color(0xFF619267),
            focusColor: Color(0xFF619267),
            fillColor: Color(0xFFF7FFF6),
            filled: true),
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
        backgroundColor: const Color(0xFF87D68D),
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(height / 6), child: AddFoodAppBar()),
        body: ListView.builder(
            itemCount: _labelTexts.length,
            itemBuilder: (BuildContext context, int index) {
              return _buildPaddedForm(_labelTexts[index], height / 35,
                  height / 50, width / 15, width / 10);
            }));
  }
}
