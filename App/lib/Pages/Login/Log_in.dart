import 'package:flutter/material.dart';
import 'package:flutter_app/Models/CContactsModel.dart';
import 'package:flutter_app/Models/CPassTextField.dart';
import 'package:flutter_app/Models/CTextFieldModel.dart';
import 'package:flutter_app/Pages/Login/CLoding.dart';
import 'package:flutter_app/Pages/Signin/Sign_in.dart';
import 'package:flutter_app/Pages/Home/Home.dart';
import 'package:animated_background/animated_background.dart';
import 'package:flutter_app/Functions/Functions.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LogInView extends StatefulWidget {
  const LogInView({Key? key}) : super(key: key);
  //final SharedPreferences? perefs ;
  @override
  State<LogInView> createState() => _LogInViewState();
}

class _LogInViewState extends State<LogInView> with TickerProviderStateMixin {

  //_LogInViewState({this.perefs});

  final _formKey = GlobalKey<FormState>();
  final TextStyle h = const TextStyle(
               color: Colors.white,
               fontSize: 32
               );

  final TextStyle F = const TextStyle(
               color: Colors.white,
               fontSize: 18
               );

  String? Username;
  String? Password;
  String massage = "";
  //final SharedPreferences? perefs ;
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 223, 179, 50),
      body:SafeArea(
        child:AnimatedBackground(
          behaviour: BubblesBehaviour(options: const BubbleOptions(bubbleCount: 10)),
          vsync: this,
          child: Center(
            child:Container(
              width: 250 ,            
              child:Column(
              mainAxisAlignment: MainAxisAlignment.center,            
              children:[
               Text(
                'TellNote',
                 style: h
                ),
                Container(
                  margin: const EdgeInsets.only(top: 40),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        //Massage section
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Align(
                            alignment: Alignment.center,
                            child:Text(massage,style: const TextStyle(color: Colors.red),)
                          ),
                        ),

                        //Username section
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child:textField(
                              label: "UserName",
                              validator:(String? value){
                                if(value == ""){
                                  return "Insert Your UserName!";
                                }
                                else if(value!.length < 3){
                                  return "too Little";
                                }else{
                                  Username = value;                      
                                }
                              }
                            )
                          ),
                        ),
                      

                        //Password section
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0,top: 6.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child:PasstextField(
                              lable: "Password",
                              obsecuretext: true,
                              validator: (String? value){
                                if(value==""){
                                  return "Insert Your Password";                            
                                }
                                else if(value!.length < 4){
                                  return "it's Less than 4 digits ";
                                }else{
                                  Password = value ;
                                }
                              },
                            )
                          ),
                        ),
                        
                        
                    
                        
                        //Log in button
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: TextButton(
                            onPressed: ()async{
                              var chek = _formKey.currentState?.validate();

                              if(chek == true){
                                Map<String,dynamic> Massage = await Functions.Login(Username!, Password!, context);
                                
                                if(Massage["Chek"] != true){
                                  setState(() {
                                    massage = Massage["Massage"];
                                  });
                                }
                              }
                            },
                            child: Text('Log in' , style: F )
                          ),
                        ),


                        
                        Padding(
                          padding: const EdgeInsets.only(top :10.0),
                          child: Row(
                            children: [
                              const Text('Dosent Registerd ? '),
                              TextButton(
                                onPressed: (){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => const SignInView()));
                                },
                                child: const Text('Sign in') )
                            ],
                          ),
                        ),

                        //  Padding(
                        //   padding:const EdgeInsets.only(top: 3.0),
                        //  child:Row(
                        //     children: [
                        //       const Text('forgot your password?') ,
                        //       TextButton(onPressed: ()=> const SignInView(), child: const Text('get it')) 
                        //     ]
                        //   )
                        // )
                      ],
                    ),
                  )
                )
              ],
            ),
          )
        ),
      
      )
    ));
  }
}
