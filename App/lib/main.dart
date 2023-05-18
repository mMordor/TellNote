import 'package:flutter/material.dart';
import 'package:flutter_app/Models/CContactsModel.dart';
import 'package:flutter_app/Functions/Functions.dart';
import 'package:flutter_app/Pages/AddContact/AddContact.dart';
import 'package:flutter_app/Pages/Login/CLoding.dart';
import 'package:flutter_app/Pages/Login/Log_in.dart';
import 'package:flutter_app/Pages/Signin/Sign_in.dart';
import 'Pages/Home/Home.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(        
        primarySwatch: Colors.blue,
      ),
      home: const Loding(),
    );
  }
}

