import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/Pages/Login/Log_in.dart';

class Loding extends StatefulWidget {
  const Loding({super.key});

  @override
  State<Loding> createState() => _LodingState();

}

class _LodingState extends State<Loding> {

  @override
  void initState() {

    Future.delayed(const Duration(seconds: 3)).then((value) {
      Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (cotext) => const LogInView()));
    });

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return  Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [

            Text(
              'TellNote',
              style: TextStyle(
                color: Color.fromARGB(255, 223, 179, 50) ,
                fontSize: 42,
                inherit: false
              )
            ),

            CircularProgressIndicator()
          ],
        )
      )
    );
  }
}