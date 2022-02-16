import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:googleclone/controller/conrtrol.dart';
import 'package:googleclone/screen/loginscren.dart';
import 'package:googleclone/widgets/addnote.dart';
import 'package:googleclone/widgets/authetication.dart';

import '../widgets/header.dart';
import 'package:antdesign_icons/antdesign_icons.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<ScaffoldState> drawerkey = GlobalKey();
  final google controler = Get.put(google());

  final firestoreInstance = FirebaseFirestore.instance;
  Authservice _auth = Authservice();
  var firebaseuser = FirebaseAuth.instance.currentUser;

  // var datadeatals=Map();
  List items = [];
  // List  userdatas=[];
  // final alldata;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      getuserdeatails();
    });

    // fechdata();
  }

  // fechdata() async {
  //   dynamic result = await getuserdeatails();

  //   if (result == null) {
  //     print('datanull');
  //   } else {
  //     setState(() {
  //       userdatas = result;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        key: drawerkey,
        drawer: Drawer(
          backgroundColor: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: () async {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => new AlertDialog(
                              title: const Text('Are you sure'),
                              actions: [
                                TextButton(
                                    onPressed: () async {
                                      await _auth.signout();
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => login(),
                                          ));
                                    },
                                    child: Text('Yes')),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('No'))
                              ],
                            ));
                  },
                  icon: Icon(
                    Icons.logout,
                    color: Colors.white,
                  ))
            ],
          ),
        ),
        backgroundColor: Colors.black,
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection(firebaseuser!.uid.toString())
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshotshot) {
              if (!snapshotshot.hasData) {
                return Center(
                  child: Text('No Text'),
                );
              }
              return ListView(
                children: [
                  Column(
                    // padding: EdgeInsets.all(20),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          width: size.width,
                          height: 45,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(136, 92, 85, 85),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 3),
                              ],
                              borderRadius: BorderRadius.circular(20)),
                          child: header(drawerkey: drawerkey),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          // return  StreamBuilder(
                          //   stream: FirebaseFirestore.instance.collection('data').snapshots(),
                          //   builder: (context, snapshot) {

                          return Container(
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.transparent,
                                border: Border.all(color: Colors.white)),
                            child: ListView(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: snapshotshot.data!.docs
                                  .map((DocumentSnapshot document) {
                            
                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        document['title'].toString(),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    Divider(
                                      thickness: 1,
                                      color: Colors.white,
                                    ),

                                    // Padding(

                                    //   padding:EdgeInsets.all(8.0),
                                    //   child: Text(
                                    //       document['note'],
                                    //         style: TextStyle(color: Colors.white),
                                    //       ),
                                    //   )
                                  ],
                                );
                              }).toList(),
                              // Padding(
                              //   padding: const EdgeInsets.all(10.0),
                              //   child: Column(
                              //     children: snapshotshot.data!.docs
                              //         .map((DocumentSnapshot document) {
                              //       return Text(
                              //         document['title'].toString(),
                              //         style: TextStyle(color: Colors.white),
                              //       );
                              //     }).toList(),
                              //   ),
                              // ),
                              // Divider(
                              //   thickness: 1,
                              //   color: Colors.white,
                              // ),
                              // Padding(
                              //   padding: const EdgeInsets.all(8.0),
                              //   child: Column(
                              //     children: snapshotshot.data!.docs
                              //         .map((DocumentSnapshot document) {
                              //       return Text(
                              //       document['note'],
                              //         style: TextStyle(color: Colors.white),
                              //       );
                              //     }).toList(),

                              //     // ],
                              //   ),
                              // ),
                              // ],
                            ),
                            // color: Colors.red,
                            // );
                            // }
                          );
                        },
                        itemCount: snapshotshot.data!.docs.length,
                      )
                    ],
                  ),
                ],
              );
            }),
        // ),

        //   }
        // ),
        // getbody(
        //   context,
        // ),
        bottomNavigationBar: BottomAppBar(
          color: Color.fromARGB(255, 46, 41, 41),
          shape: const AutomaticNotchedShape(
            RoundedRectangleBorder(),
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
          ),
          child: Row(
            children: [
              Container(
                color: Color.fromARGB(255, 46, 41, 41),
                // width: size.width * 0.7,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => print(items),
                      icon: Icon(
                        AntIcons.checkSquareOutlined,
                        size: 20,
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                    IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.brush,
                        size: 18,
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                    IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.mic_rounded,
                        size: 22,
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                    IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.photo,
                        size: 22,
                        color: Colors.white.withOpacity(0.5),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),

        floatingActionButtonLocation: FloatingActionButtonLocation
            .endDocked, // floatingActionButton: FloatingActionButton.extended(onPressed: (), label: label),
        floatingActionButton: FloatingActionButton(
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => addnote()));
          },
          backgroundColor: Color.fromARGB(255, 46, 41, 41),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Center(child: Image.asset("assets/add.png")),
          ),
        ),
      ),
    );
  }

  getuserdeatails() async {
    try {
      var firebaseuser = FirebaseAuth.instance.currentUser;

      var result = await FirebaseFirestore.instance
          .collection(firebaseuser!.uid.toString())
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          setState(() {
            items.add(element.data());
            print(element.data());
          });
        });
      });
      return;
    } catch (e) {
      print(e.toString());
    }
  }
}
