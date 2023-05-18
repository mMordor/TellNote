import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Functions/Functions.dart';
import 'package:flutter_app/Models/CContactsModel.dart';
import 'package:flutter_app/Models/CDropdownButton.dart';
import 'package:flutter_app/Models/CTextFieldModel.dart';

class EditContact extends StatefulWidget {
  EditContact({super.key,required this.contact});
  Contacts contact = Contacts();

  @override
  State<EditContact> createState() => _EditContactState(contact: contact);
}

class _EditContactState extends State<EditContact> with TickerProviderStateMixin{
  
  _EditContactState({required this.contact}){
    this.Name=contact.name!;
    this.Family=contact.lastName!;
    this.Number=contact.number!;
    this.Relation=contact.relation!;
    this.CID=contact.contactID!;
    print(Name);
  }

  Contacts contact = Contacts();
  final _formKey= GlobalKey<FormState>();
  List<String> items = ["Friend","Family","Business"];
  late int CID;
  late String Relation;
  late String Name;
  late String Family;
  late String Number;
  String massage="";


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 223, 179, 50),
        body: AnimatedBackground(
          behaviour: RandomParticleBehaviour(options: const ParticleOptions(
            baseColor: Color.fromARGB(255, 54, 0, 63),
            particleCount: 20
          )),
          vsync: this,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 110),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Edit Your Contact",style: TextStyle(color: Colors.white,fontSize: 28)),
                    )
                    ,
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(massage),
                    )
                    ,
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: textField(defaultValue: Name,label: "Name", validator: (value) {
                        if(value == ""){
                          return "Insert A Name!";
                        }
                        else if(value!.length < 3){
                          return "Too Little";
                        }else{
                        Name = value;                      
                        }
                      } ),
                    )
                    ,
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: textField(defaultValue: Family,label: "Last-Name", validator: (value) {
                        if(value != ""){
                          if(value!.length < 3){
                            return "too Little";
                          }else{
                            Family = value;                      
                          }
                        }
                      } ),
                    )
                    ,
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: textField(defaultValue: Number,label: "Number", validator: (value) {
                        if(value == ""){
                          return "Insert Number!";
                        }
                        else if(value!.length < 11){
                          return "too Little";
                        }else{
                          Number = value;                      
                        }
                      } ),
                    )
                    ,
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: dropDownButton(items: items, selectedItem: Relation, validator: (item)=>setState(() {Relation = item!;}),),
                    )
                    ,
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: ()async{
                            var chek = _formKey.currentState?.validate();

                            if(chek == true){
                              Map<String,dynamic> Massage =  await Functions.Submit2(CID,Name, Family, Number, Relation, context);
                                      
                              if(Massage["Chek"] != true){
                                setState(() {
                                massage = Massage["Massage"];
                                });
                              }
                            }
                          }
                            , 
                            child: const Text("Submit",style: TextStyle(color: Colors.white,fontSize: 18),)                        
                          )
                          ,
                          TextButton(
                            onPressed: (){
                            Navigator.of(context).pop();
                          }
                            , 
                            child: const Text("Cancel",style: TextStyle(color: Colors.redAccent,fontSize: 18),)                        
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ),
            )
          ),
        ),
      ),
    );
  }
}