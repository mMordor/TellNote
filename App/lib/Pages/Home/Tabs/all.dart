//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Functions/Functions.dart';
import 'package:flutter_app/Models/CContactsModel.dart';
import 'package:flutter_app/Pages/EditContact/CEditContact.dart';

class AllContacts extends StatefulWidget {
  const AllContacts({Key? key,required this.contacts}) : super(key: key);
  final List<Contacts> contacts ;
  @override
  State<AllContacts> createState() => _AllContactsState(contacts: contacts);
}

class _AllContactsState extends State<AllContacts>{

  _AllContactsState({required this.contacts});

  List<Contacts> contacts ;

  @override
  Widget build(BuildContext context) {    

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [        
            Container(
              margin:const EdgeInsets.symmetric(horizontal: 10),
              
                height: 465,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(240, 223, 218, 218),
                  borderRadius: BorderRadius.all(Radius.circular(5)),               
                ),
              child: ListView.builder(

                itemCount: contacts.length,

                itemBuilder: ((context, index) {

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.5,horizontal: 8),
                    child: Container(
                      decoration: BoxDecoration(
                        color:const Color.fromARGB(255, 54, 0, 63),
                        borderRadius: BorderRadius.circular(10),  
                        boxShadow: const [BoxShadow(offset: Offset(2, 2),blurRadius: 4)]
                      ),
                      child: ListTile(
                        leading: Container(
                          width: 50,
                          height: 80,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 232, 224, 243),
                            image: const DecorationImage(image: AssetImage('asset/images/nopic2.png'),fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all()                                 
                          ),
                        ),
                        title: Text('${contacts[index].name.toString()} ${contacts[index].lastName.toString()}' , style: const TextStyle(color: Color.fromARGB(255, 232, 224, 243))),
                        subtitle: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient:Functions.setBack(status: contacts[index].relation.toString())
                              ),
                                                  
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                                child: Text(contacts[index].relation.toString() , style: const TextStyle(color: Colors.white70,fontSize: 10),),
                              )
                            ),
                          ]),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [                            
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                child: const Icon(Icons.delete,color: Colors.white),
                                onTap: () {
                                  showDialog(context: context, builder: ((context) => Center(
                                    child: Container(
                                      width: 300,
                                      height: 100,
                                      decoration: BoxDecoration(color: Colors.white60,borderRadius: BorderRadius.circular(5)),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Text("Are you sure for Deleting the Contact?")
                                          ,
                                          Padding(
                                            padding: const EdgeInsets.all(8)
                                            ,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                ElevatedButton(onPressed: () {
                                                  Functions.deleteContact(cID: contacts[index].contactID!, context: context);
                                                  Navigator.of(context).pop();
                                                  }
                                                  , 
                                                  child: const Text("yes"))
                                                ,
                                                ElevatedButton(onPressed:() =>Navigator.of(context).pop() , child: const Text("No"))
                                              ],
                                            ),
                                          )
                                        ],
                                      ),                                    
                                    ),
                                  )));
                                },
                              ),
                            )
                            ,
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                child: const Icon(Icons.edit,color: Colors.white),
                                onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => EditContact(contact: contacts[index],)));},
                              ),
                            )
                          ],
                        )
                      ),
                    ),
                  );
                })
              ),
            ),
          ]
        ),
      )
    );
  }
}