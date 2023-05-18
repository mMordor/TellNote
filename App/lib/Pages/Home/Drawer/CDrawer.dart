import 'package:flutter/material.dart';
import 'package:flutter_app/Functions/Functions.dart';
import 'package:flutter_app/Pages/Profile/CEditUserProfile.dart';

class NavDrawer extends StatelessWidget {
  NavDrawer({super.key});

  final user = Functions.user;

  @override
  Widget build(BuildContext context) => Drawer(
    child: ListView(
      children:[
        DrawerHeader(          
          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage('asset/images/TellNote-MenuHeader.jpg'),fit: BoxFit.cover)
          ),
          child:  Text(
            user.userName!
            ,
            style: const TextStyle(
              color: Colors.white
              ,
              fontSize: 27
              ,
              fontWeight: FontWeight.bold
            )
          ),
        ),
          ListTile(
            leading:const Icon(Icons.person),
            title:const Text('Profile'),
            onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => UserProfile(user: user)));},
          ),ListTile(
            leading: Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            onTap: () {
              Functions.UID=-1;
              Functions.loginPageTransfer(context: context);
            },
          )
      ]
    ),
  );
}