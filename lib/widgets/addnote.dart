import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:googleclone/screen/Homepage.dart';

class addnote extends StatefulWidget {
  const addnote({Key? key}) : super(key: key);

  @override
  _addnoteState createState() => _addnoteState();
}

class _addnoteState extends State<addnote> {
  // final referencesdata = FirebaseDatabase.instance;
  final titlecontroler = TextEditingController();
  final notecontroler = TextEditingController();
  final title = "title";
  final note = "note";
  Home obj=Home();
  @override
  Widget build(BuildContext context) {
    // final ref = referencesdata.ref();
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: const [
          Icon(Icons.attach_file),
          SizedBox(
            width: 10,
          ),
          Icon(Icons.add_alert_outlined),
          SizedBox(
            width: 10,
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Icon(Icons.sim_card_download_outlined),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titlecontroler,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  // label:Text("Tittle",style: TextStyle(color: Color.fromARGB(255, 130, 115, 115)),)

                  hintText: "Tittle",
                  hintStyle:
                      TextStyle(color: Color.fromARGB(255, 130, 115, 115))),
            ),
            TextField(
              controller: notecontroler,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide.none),

                  // label:Text("Note",style: TextStyle(color: Color.fromARGB(255, 130, 115, 115)))
                  hintText: "Note",
                  hintStyle:
                      TextStyle(color: Color.fromARGB(255, 130, 115, 115))),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      // print('hsjfgs');
                         var firebaseuser= FirebaseAuth.instance.currentUser;    
                      FirebaseFirestore.instance
                .collection(firebaseuser!.uid.toString())
                .add({"title":titlecontroler.text,"note":notecontroler.text});
          
                titlecontroler.clear();
                notecontroler.clear();
                Navigator.pop(context);
                
                      
                    },
                    child: Text("Save")),
                ElevatedButton(onPressed: () {
                  Get.back();
                }, child: Text("Cancel"))
              ],
            )
          ],
        ),
      ),
    ));
  }
}
