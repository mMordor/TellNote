import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Functions/Functions.dart';
import 'package:flutter_app/Models/CTextFieldModel.dart';
import 'package:flutter_app/Models/CUsersModel.dart';

class UserProfile extends StatefulWidget {
  UserProfile({super.key,required this.user});
  UsersModel user = UsersModel();

  @override
  State<UserProfile> createState() => _UserProfileState(user: user);
}

class _UserProfileState extends State<UserProfile> with TickerProviderStateMixin{
  
  _UserProfileState({required this.user}){
    this.UserName=user.userName!;
    this.PassWord=user.password!;
    this.Email=user.email!;
    print(UserName);
  }

  UsersModel user = UsersModel();
  final _formKey= GlobalKey<FormState>();
  late String UserName;
  late String PassWord;
  late String Email;
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
                      child: Text("Edit Your Profile",style: TextStyle(color: Colors.white,fontSize: 28)),
                    )
                    ,
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(massage),
                    )
                    ,
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: textField(defaultValue: UserName,label: "UserName", validator: (value) {
                        if(value == ""){
                          return "Insert your UserName!";
                        }
                        else if(value!.length < 3){
                          return "Too Little";
                        }else{
                        UserName = value;                      
                        }
                      } ),
                    )
                    ,
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: textField(defaultValue: PassWord,label: "PassWord", validator: (value) {
                        if(value != ""){
                          if(value!.length < 3){
                            return "too Little";
                          }else{
                            PassWord = value;                      
                          }
                        }
                      } ),
                    )
                    ,
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: textField(defaultValue: Email,label: "Email", validator: (value) {
                        if(value == ''){
                          return "Insert Your Email!";
                        }
                        else if(!value!.contains("@")){
                          return "Your Email is not Correct!";
                        }else{
                          Email = value;
                        }
                      } ),
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
                              Map<String,dynamic> Massage =  await Functions.Submit3(user.userID!, UserName, PassWord, Email, context);
                                      
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
