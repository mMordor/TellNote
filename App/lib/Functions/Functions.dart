import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Models/CUsersModel.dart';
import 'package:flutter_app/Pages/Login/CLoding.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/Models/CContactsModel.dart';
import 'package:flutter_app/Pages/Home/Home.dart';
import 'package:flutter_app/Pages/Login/Log_in.dart';
import 'package:flutter_app/Pages/Signin/Sign_in.dart';
import 'dart:convert';

//import 'package:shared_preferences/shared_preferences.dart';

class Functions{
  static List<Contacts> contacts = [];
  static late UsersModel user;
  static int? UID;
  static LinearGradient bisnesBackground =  const LinearGradient(
                                        colors: [
                                          Color(0xffB993D6),
                                          Color(0xff8CA6DB)
                                        ],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight
                                        
                                      );

  static LinearGradient freindBackground =  const LinearGradient(
                                        colors: [
                                          Color(0xff134E5E),
                                          Color(0xff71B280)                                          
                                        ],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight
                                        
                                      );

  static LinearGradient familyBackground = const LinearGradient(
                                        colors: [
                                          Color(0xffDE6262),
                                          Color(0xffFFB88C)
                                        ],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight
                                        
                                      );

  static LinearGradient? setBack({required String? status}){
    switch (status){
      case "Friend":
        return freindBackground; 
        break;     
      case "Family":
        return familyBackground;
        break;
      case "Business":
        return bisnesBackground;
        break;
      default:
    
    }
  }

  static Future<Map> insertContact({required String Name , required String Family, required String Number, required Relation})async{
    Name = Uri.encodeComponent(Name);
    if(Family==""){
      Family="NULL";
    }
    Family = Uri.encodeComponent(Family);
    Number = Uri.encodeComponent(Number);
    Relation = Uri.encodeComponent(Relation);

    var Url = "http://127.0.0.1:8000/post_cotacts?uID=$UID&name=$Name&num=$Number&rel=$Relation&lname=$Family";
    var Data = await http.post(Uri.parse(Url),headers: {
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Methods": "POST, GET, OPTIONS, PUT, DELETE, HEAD",
      });
    if(Data.statusCode == 200){
      print("Connected");
      print(Url);
      var jData = jsonDecode(Data.body);
      return jData;
    }else{
      return {"Massage":"Connecting faild"};
    }
  }

  static Future<Map> UpdateContact({required int CID,required String Name , required String Family, required String Number, required Relation})async{
    Name = Uri.encodeComponent(Name);
    if(Family==""){
      Family="NULL";
    }
    Family = Uri.encodeComponent(Family);
    Number = Uri.encodeComponent(Number);
    Relation = Uri.encodeComponent(Relation);

    var Url = "http://127.0.0.1:8000/update_contact?cID=$CID&name=$Name&numb=$Number&rel=$Relation&lname=$Family";
    var Data = await http.put(Uri.parse(Url),headers: {
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Methods": "POST, GET, OPTIONS, PUT, DELETE, HEAD",
      });
    if(Data.statusCode == 200){
      print("Connected");
      print(Url);
      var jData = jsonDecode(Data.body);
      return jData;
    }else{
      return {"Massage":"Connecting faild"};
    }
  }

  static Future<Map> LogInValidating({required String Name , required String Password})async{
    Name = Uri.encodeComponent(Name);
    Password = Uri.encodeComponent(Password);
    var Url = "http://127.0.0.1:8000/Log_User?username=$Name&password=$Password";
    var Data = await http.get(Uri.parse(Url),headers: {
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Methods": "POST, GET, OPTIONS, PUT, DELETE, HEAD",
      });
    if(Data.statusCode == 200){
      print("Connected");
      print(Url);
      var jData = jsonDecode(Data.body);
      return jData;
    }else{
      return {"Massage":"Connecting faild"};
    }
  }

  static  Future<String> SignInValidating({required String Name , required String Password,required String Email}) async{
    Name = Uri.encodeComponent(Name);
    Password = Uri.encodeComponent(Password);
    Email = Uri.encodeComponent(Email);
    var Url = "http://127.0.0.1:8000/post_user?name=$Name&pas=$Password&email=$Email";
    var Data = await http.post(Uri.parse(Url),headers: {
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Methods": "POST, GET, OPTIONS, PUT, DELETE, HEAD",
      });
    if(Data.statusCode == 200){
      print("Connected");
      print(Url);
      var jData = jsonDecode(Data.body);
      return jData["Massage"];
    }else{
      return "Connecting faild";
    }
  }

  static Future<dynamic> ContactList({required int UID})async{
    var Url = "http://127.0.0.1:8000/Get_Contacts?UserID=$UID";
    var Data = await http.get(Uri.parse(Url),headers: {
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Methods": "POST, GET, OPTIONS, PUT, DELETE, HEAD",
      });
    if(Data.statusCode == 200){
      print("Connected");
      print(Url);
      ContactsModel Contacts = ContactsModel.fromJson(jsonDecode(Data.body));
      
      return Contacts.contacts;
    }
    return {"Massage":"Connection Faild!"};
  } 

  static Future<Map> UpdateUser({required int UID,required String UserName , required String PassWord , required String Email})async{
    UserName = Uri.encodeComponent(UserName);
    if(Email==""){
      Email="NULL";
    }
    Email = Uri.encodeComponent(Email);
    UserName = Uri.encodeComponent(UserName);
    PassWord = Uri.encodeComponent(PassWord);

    var Url = "http://127.0.0.1:8000/update_user?uid=$UID&uname=$UserName&pas=$PassWord&email=$Email";
    var Data = await http.put(Uri.parse(Url),headers: {
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Methods": "POST, GET, OPTIONS, PUT, DELETE, HEAD",
      });
    if(Data.statusCode == 200){
      print("Connected");
      print(Url);
      var jData = jsonDecode(Data.body);
      return jData;
    }else{
      return {"Massage":"Connecting faild"};
    }
  }
  
  static Future<dynamic> UserInfo({required int UID})async{
    var Url = "http://127.0.0.1:8000/Get_User?uid=$UID";
    var Data = await http.get(Uri.parse(Url),headers: {
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Methods": "POST, GET, OPTIONS, PUT, DELETE, HEAD",
      });
    if(Data.statusCode == 200){
      print("Connected");
      print(Url);
      print(Data);
      print(Data.body);
      UsersModel User = UsersModel.fromJson(jsonDecode(Data.body));
    
      return User;
    }
    return {"Massage":"Connection Faild!"};
  }
  
  static void homePageTransfer({required BuildContext context ,required List<Contacts> contacts}){
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context )=> Homeview(contacts: contacts)));
  }

  static void loginPageTransfer({required BuildContext context}){
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context )=> LogInView()));
  }

  static Future deleteContact({required int cID,required BuildContext context})async{
    String url = "http://127.0.0.1:8000/delete_contact?cID=$cID";
    var respons = await http.delete(Uri.parse(url),headers: {
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Methods": "POST, GET, OPTIONS, PUT, DELETE, HEAD",
      });
    var Data = jsonDecode(respons.body);
    if(Data["Massage"] == "Contact Deleted"){
      contacts = await ContactList(UID: UID!);
      homePageTransfer(context: context, contacts: contacts);
    }else{
      showDialog(context: context, builder: ((context) => Container(
        decoration: BoxDecoration(color: Colors.white60,borderRadius: BorderRadius.circular(5)),
        child: Column(
          children: [
            Text(Data["Massage"]),
            Padding(
              padding: const EdgeInsets.all(8)
              ,
              child: ElevatedButton(onPressed: () =>Navigator.of(context).pop() , child: const Text("Ok")),
            )
          ],
        ),
        
      )));
    }
    
  }

  static Future Login(String Name,String Password, BuildContext context)async{

    Map<String,dynamic> Massage = <String,dynamic>{"Massage" : "","Chek" : false,"Uid": -1};

    showDialog(context: context,barrierDismissible: false, builder: (context){
      return const Center(child: CircularProgressIndicator());
    });

    var result = await LogInValidating(Name: Name, Password: Password);
    if(result["Massage"] == "Acsses acsepted"){
      Massage["Chek"] = true;  
      UID = result["ID"];
      contacts = await ContactList(UID: UID!);
      user = await UserInfo(UID: UID!);
      print(user);
      
    }else{
      Massage["Massage"] = result["Massage"];
      Massage["Chek"] = false;
    }

    Navigator.of(context).pop(); 

    if(Massage["Chek"] == true){
      homePageTransfer(context: context, contacts: contacts);
    }


    return Massage; 
  }

  static Future Submit(String Name, String Family, String Number, String Relation, BuildContext context)async{
   
    Map<String,dynamic> Massage = <String,dynamic>{"Massage" : "","Chek" : false,"Uid": -1};
  
    showDialog(context: context,barrierDismissible: false, builder: (context){
      return const Center(child: CircularProgressIndicator());
    });

    var result = await insertContact(Name: Name, Family: Family, Number: Number, Relation: Relation);
    if(result["Massage"] == "Contact added"){
      Massage["Chek"] = true;  
      
      contacts = await ContactList(UID: UID!);
      
    }else{
      Massage["Massage"] = result["Massage"];
      Massage["Chek"] = false;
    }

    Navigator.of(context).pop(); 

    if(Massage["Chek"] == true){
      homePageTransfer(context: context, contacts: contacts);
    }


    return Massage;  
  }

  static Future Submit2(int CID,String Name, String Family, String Number, String Relation, BuildContext context)async{
   
    Map<String,dynamic> Massage = <String,dynamic>{"Massage" : "","Chek" : false,"Uid": -1};
  
    showDialog(context: context,barrierDismissible: false, builder: (context){
      return const Center(child: CircularProgressIndicator());
    });

    var result = await UpdateContact(CID: CID,Name: Name, Family: Family, Number: Number, Relation: Relation);
    if(result["Massage"] == "Contact Updated"){
      Massage["Chek"] = true;  
      
      contacts = await ContactList(UID: UID!);
      
    }else{
      Massage["Massage"] = result["Massage"];
      Massage["Chek"] = false;
    }

    Navigator.of(context).pop(); 

    if(Massage["Chek"] == true){
      homePageTransfer(context: context, contacts: contacts);
    }


    return Massage;  
  }

  static Future Submit3(int UID, String UserName, String PassWord, String Email, BuildContext context)async{
   
    Map<String,dynamic> Massage = <String,dynamic>{"Massage" : "","Chek" : false,"Uid": -1};
  
    showDialog(context: context,barrierDismissible: false, builder: (context){
      return const Center(child: CircularProgressIndicator());
    });

    var result = await UpdateUser(UID: UID, UserName: UserName, PassWord: PassWord, Email: Email);
    if(result["Massage"] == "User Updated"){
      Massage["Chek"] = true;  
      
      user = await UserInfo(UID: UID);
      
    }else{
      Massage["Massage"] = result["Massage"];
      Massage["Chek"] = false;
    }

    Navigator.of(context).pop(); 

    if(Massage["Chek"] == true){
      homePageTransfer(context: context, contacts: contacts);
    }


    return Massage;  
  }

  // static void initializing(BuildContext context, Future<SharedPreferences> _perefs)async{
  //   showDialog(context: context, builder: (context){
  //     return const Loding();
  //   });

  //   var perefs = await _perefs;
  //   if(perefs.getInt("Uid") != null){
  //     List<Contacts> contacts = await ContactList(UID: perefs.getInt("Uid")!);                                
  //     homePageTransfer(context: context, contacts: contacts);
  //   }else{
  //     loginPageTransfer(context: context,perefs: perefs);
  //   }

  //   Navigator.of(context).pop();
  // }
  
}