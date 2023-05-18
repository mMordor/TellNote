import 'package:flutter/material.dart';

class PasstextField extends StatefulWidget {
  const PasstextField({super.key, required this.lable,required this.obsecuretext,required this.validator});
  final String lable;
  final bool? obsecuretext;
  final String? Function(String?) validator;
  @override
  State<PasstextField> createState() => _PasstextFieldState(lable: lable,obsecuretext: obsecuretext,validator: validator);
}

class _PasstextFieldState extends State<PasstextField> {
  _PasstextFieldState({ required this.lable,this.obsecuretext,required this.validator});
  String? Function(String?) validator;
  final String lable;
  bool? obsecuretext;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      obscureText: obsecuretext!,
      decoration: InputDecoration(
        
        suffixIcon: InkWell(
          child: Icon(obsecuretext! ?Icons.visibility:Icons.visibility_off),
          onTap: () {
            setState(
              () {
                  obsecuretext = !obsecuretext!;
              }
            );
          },
        ),
        labelText: lable ,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),    
          borderSide: const BorderSide(color: Colors.black)   
        )    
      ),
    );
  }
}