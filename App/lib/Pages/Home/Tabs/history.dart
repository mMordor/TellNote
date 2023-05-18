//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_app/Functions/Functions.dart';
//import 'package:flutter_app/classes/Users.dart';

class ActionsHistory extends StatefulWidget {
  const ActionsHistory({Key? key}) : super(key: key);

  @override
  State<ActionsHistory> createState() => _ActionsHistory();
}

class _ActionsHistory extends State<ActionsHistory> {




  @override
  Widget build(BuildContext context) {
    
    // MediaQueryData query = MediaQuery.of(context);
        
    //     double widthsize = query.size.width;
    //     double heightsize = query.size.height;


    return Scaffold(
      body: SingleChildScrollView(
        child:Center(
          child: Column(
            children:[
              Container(
                margin:const EdgeInsets.symmetric(horizontal: 10),
                height: 465,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(240, 223, 218, 218),
                  borderRadius: BorderRadius.all(Radius.circular(5)),               
                ),
                child: const Center(
                  child: Text('Your Hisory is Empty!')
                )
              ),
            ],
          )
        ),
      )
    );
  }
}