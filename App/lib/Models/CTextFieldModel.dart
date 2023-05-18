import 'package:flutter/material.dart';

class textField extends StatelessWidget {
  
  textField({super.key,required this.label,required this.validator,this.defaultValue});
  String? label;
  String? Function(String?) validator;
  String? defaultValue;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: defaultValue,
      validator: validator,
      decoration: InputDecoration(
        labelText: label ,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),    
          borderSide: const BorderSide(color: Colors.black)   
        )    
      ),
    );
  }
}