//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Functions/Functions.dart';
import 'package:flutter_app/Pages/AddContact/AddContact.dart';
import 'package:flutter_app/Pages/Home/Drawer/CDrawer.dart';
import 'package:flutter_app/Pages/Home/Tabs/all.dart';
import 'package:flutter_app/Pages/Home/Tabs/history.dart';
import 'package:flutter_app/Models/CContactsModel.dart';


class Homeview extends StatefulWidget {
  const Homeview({Key? key,required this.contacts}) : super(key: key);

  final List<Contacts> contacts;

  @override
  State<Homeview> createState() => _HomeviewState(contacts: contacts);
}


class _HomeviewState extends State<Homeview> with SingleTickerProviderStateMixin{
 
 _HomeviewState({required this.contacts});

 List<Contacts> contacts;
 late TabController _tabbarcontroller ;


 @override
  void initState() {
    _tabbarcontroller=TabController(length: 2,vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabbarcontroller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    TextStyle header = const TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight:FontWeight.w500
    );
    MediaQueryData query = MediaQuery.of(context);
    double widthsize = query.size.width;
    print(contacts);
    
    return SafeArea(
      child: Scaffold(        
        appBar: AppBar(          
          backgroundColor:const Color.fromARGB(255, 223, 179, 50),
          title: Center(
            child:SizedBox(                     
              child: Text("TellNote",style: header),
            ),
          ),
          
          actions: [
            IconButton(
            onPressed: (){},
            icon: Icon(Icons.search,color: Colors.red[50]),
            tooltip: "Search Contact")
          ],
          
        ),
        drawer: NavDrawer(),

        body:  Padding(
          padding: const EdgeInsets.only(top: 8,left: 4,right: 4),
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              
              // Most calls Row Box

              Padding(
                padding: const EdgeInsets.symmetric(vertical:  2.0),
                child: Container(  

                  // container decoration
                  width: query.size.width -20,
                  decoration: const BoxDecoration(
                    color:  Color.fromARGB(240, 223, 218, 218),
                    borderRadius:  BorderRadius.all( Radius.circular(10))
                  ),

                  //container body
                    
                  child: Column(
                    children:[

                    const SizedBox(
                      height: 8,
                    ),

                    Row(             
                      children:[

                        Container(                         
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          width: query.size.width -20,
                          height: 150,                                    
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,                  
                            itemCount: contacts.length,

                            itemBuilder: ((context, index) {

                              return SizedBox(
                                  width: 120,
                                  height: 120,
                                  child: Column(
                                    children: [

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [

                                          Container(
                                            
                                            margin: const EdgeInsets.all(8),
                                            width: 90,
                                            height: 90, 
                                            child: Container(
                                              width: 50,
                                              height: 80,
                                              decoration: BoxDecoration(
                                                color: Color.fromARGB(255, 196, 178, 124),
                                                image: const DecorationImage(image: AssetImage('asset/images/nopic2.png' ),fit: BoxFit.cover),
                                                borderRadius: BorderRadius.circular(15),
                                                border: Border.all(),
                                                boxShadow: const [BoxShadow(
                                                  offset: Offset(2, 2),
                                                  blurStyle: BlurStyle.normal,
                                                  blurRadius: 3
                                                )]
                                              ),
                                            ),
                                          ),
                                        ],                              
                                      ),

                                      Text(contacts[index].name.toString()),
                                      
                                      Text(contacts[index].lastName.toString())
                                    ],
                                  ),
                                );
                            })
                          ),
                        )
                      ]
                    ),

                    const SizedBox(
                      height: 8,
                    ),

                  ]
                  
                  ),
                ),
              ),

    
              //RecentCalls & AllContacts Box

              Container(
                margin: const EdgeInsets.fromLTRB(6, 3, 6, 2),
                decoration: const BoxDecoration(
                  color:   Color.fromARGB(255, 223, 179, 50),
                  borderRadius:  BorderRadius.all( Radius.circular(10))
                ),
                width: widthsize-4,                  
                child:TabBar(
                  labelColor: const Color.fromARGB(255, 54, 0, 63),
                  unselectedLabelColor: Colors.white,
                  indicatorPadding: const EdgeInsets.symmetric(horizontal: 40),
                  indicatorColor: const Color.fromARGB(255, 54, 0, 63),
                  controller: _tabbarcontroller,
                  tabs: const [
                    Tab(icon: Icon(Icons.list_rounded)),
                    Tab(icon: Icon(Icons.history)),                    
                ]),
              ),
              Expanded(
                child: Container(
                  margin:const EdgeInsets.only(bottom: 5),
                  width: widthsize-4,
                  child: TabBarView(
                    controller: _tabbarcontroller,
                    children: [                     
                     AllContacts(contacts: contacts),
                     const ActionsHistory()
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        
        floatingActionButton: IconButton(icon: Icon(Icons.add_box_rounded,color:  Color.fromARGB(252, 95, 18, 18)),onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => addContact()));},iconSize: 60),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      )
    );
  }
}