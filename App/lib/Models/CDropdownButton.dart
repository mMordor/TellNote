import 'package:flutter/material.dart';

class dropDownButton extends StatefulWidget {
  dropDownButton({super.key,required this.items,required this.selectedItem,required this.validator});
  List<String> items = ["Freind","Family","Business"];
  String selectedItem = "Freind";
  void Function(String?) validator;
  

  @override
  State<dropDownButton> createState() => _dropDownButtonState(items: items, selectedItem: selectedItem, validator: validator);
}

class _dropDownButtonState extends State<dropDownButton> {
  _dropDownButtonState({this.items,this.selectedItem,required this.validator});
  List<String>? items = ["Freind","Family","Business"];
  String? selectedItem = "Freind";
  void Function(String?) validator;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: "Relation",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),    
          borderSide: const BorderSide(color: Colors.black)   
        )    
      ),
      value: selectedItem,
      items: items!.map((item) => DropdownMenuItem<String>(
        value: item,
        child: Text(item)
      )).toList(),
      onChanged: validator
    );
  }
}