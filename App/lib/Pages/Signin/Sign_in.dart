import 'package:flutter/material.dart';
import 'package:animated_background/animated_background.dart';
import 'package:flutter_app/Models/CTextFieldModel.dart';
import 'package:flutter_app/Models/CPassTextField.dart';
import 'package:flutter_app/Functions/Functions.dart';
import 'package:flutter_app/Pages/Login/Log_in.dart';


class SignInView extends StatefulWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> with TickerProviderStateMixin {
  
  String massage = "";
  final _formKey = GlobalKey<FormState>();
  final bool val = false;
  String? Password;
  final TextStyle h = const TextStyle(
               color: Colors.white,
               fontSize: 32
               );

  final TextStyle F = const TextStyle(
               color: Colors.white,
               fontSize: 18
               );
  
  late Users user = Users();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body:SafeArea(
        child:AnimatedBackground(
          behaviour: RandomParticleBehaviour(options: const ParticleOptions(
            baseColor: Color.fromARGB(255, 54, 0, 63),
            particleCount: 20
          )),
          vsync: this,
          child:
            Center(
              child:SizedBox(
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

                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Align(
                              alignment: Alignment.center,
                              child:Text(massage,style: const TextStyle(color: Colors.red),)
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child:
                              textField(
                                label: "UserName",
                                validator: (String? value){
                                  if(value == ''){
                                    return "Insert Your UserName!";
                                  }
                                  else if(value!.length < 3){
                                    return "too Little";
                                  }else{
                                    user.Username = value;
                                  }
                                }
                              )
                            ),
                          ),

                        
                          Padding(
                            padding: EdgeInsets.only(top: 8.0,bottom: 4.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child:
                              textField(
                                label: "Email",
                                validator: (String? value){
                                  if(value == ''){
                                    return "Insert Your Email!";
                                  }
                                  else if(!value!.contains("@")){
                                    return "Your Email is not Correct!";
                                  }else{
                                    user.Email = value;
                                  }
                                }
                              )
                            ),
                          ),

                          

                          Padding(
                            padding: EdgeInsets.only(top: 8.0,bottom: 4.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: 
                              PasstextField(
                                lable: "Password",
                                obsecuretext: true,
                                validator: (String? value){
                                  if(value == ''){
                                    return "Insert Your Password!";
                                  }
                                  else if(value!.length < 4){
                                    return "It's Less than 4 digits!";
                                  }else{
                                    Password = value;
                                  }
                                },
                              )
                            ),
                          ),

                        
                          


                          Padding(
                            padding: EdgeInsets.only(top: 8.0,bottom: 4.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child:
                              PasstextField(
                                lable: "Password Again",
                                obsecuretext: true,
                                validator: (String? value){
                                  if(value == ''){
                                    return "Insert Your Password Again!";
                                  }
                                  if(value != Password){
                                    return "Passwords Not Match!";
                                  }else{
                                    user.Password = value;
                                  }
                                },
                              )
                            ),
                          ),

                          

                          Padding(
                            padding: const EdgeInsets.only(top: 9.0),
                            child: TextButton(
                              onPressed: ()async{
                                var chek = _formKey.currentState?.validate();
                                if(chek == true){
                                  var result = await Functions.SignInValidating(Name: user.Username!, Password: user.Password!, Email: user.Email!);
                                  print(result);
                                  if(result == "User added"){
                                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context )=> const LogInView()));
                                  }else{
                                    setState(() {
                                    massage = result;
                                    });
                                  }
                                }
                              },
                              child: Text('Sign in' , style: F )
                            ),
                          ),
                          

                          
                          Padding(
                            padding:const EdgeInsets.only(top: 3.0),
                          child:Row(
                              children: [
                                const Text('Did you have an acount?') ,
                                TextButton(
                                  onPressed: (){
                                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => const LogInView()));
                                  }, 
                                  child: const Text('Get in')) 
                              ]
                            )
                          )
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

class Users{
  String? Username;
  String? Email;
  String? Password;
}