

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:googleclone/screen/Homepage.dart';
import 'package:googleclone/screen/registerscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/authetication.dart';

class login extends StatefulWidget {
  const login({ Key? key }) : super(key: key);

  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  final Authservice _auth = Authservice();

  final _key = GlobalKey<FormState>();
   TextEditingController _emailContoller = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String error='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        // color: Colors.black,

        child: Center(
          child: Form(
            key:_key ,
            child: Column(
            children: [
               Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    children: [
                      SizedBox(height: 30),
                      TextFormField(
                        controller: _emailContoller,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Email cannot be empty';
                          } else
                            return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(color: Colors.white)),
                        style: TextStyle(color: Colors.white),
                      ),
                       SizedBox(height: 30),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password cannot be empty';
                          } else
                            return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(color: Colors.white)),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 5),
            ],
          ),
          
          
          ),
          ElevatedButton(onPressed: ()async{
               var firebaseuser= FirebaseAuth.instance.currentUser;
            if (_key.currentState!.validate()) {
              // print(_emailContoller.text);
              // print(_passwordController.text);
              print('onpress');
             
              
              Authservice().loginInWithEmailAndPassword(email: _emailContoller.text, password: _passwordController.text).then((value){ 

                if (value==null) {
                  // Get.off(Home());
                  setState(() {
                error="Email and passoword incrorrct";
              });
                   print(value);

                  
                }else{
                  // print(value);
                  Get.off(Home());
                }             
              });
              // if(result == ''){          
              //   print(result.runtimeType);
 

              // setState(() {
              //   error="Could not sign";
              // });
              // print('erriier');
            }
            // else{
            //   _emailContoller.clear();

            //   // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(),));
            // }
            
            // dynamic result =await _auth.signInWithEmailAndPassword( email: _emailContoller.text,password: _passwordController.text);
            // if(result == null){


            //   setState(() {
            //     error="Could not sign";
            //   });
            //   print('erriier');
            // }else{
            //   _emailContoller.clear();

            //   // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(),));
            // }
            // Authservice().signInWithEmailAndPassword(email: _emailContoller.text, password: _passwordController.text).then((value){
            //   if(value==null){
            //      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(),));


            //   }else{
            //     print("eree");
            //   }


            // });


           


          }, child:Text("Login") ),

          TextButton(onPressed: (){
             Navigator.of(context).push(MaterialPageRoute(builder: (context) => registerscreen(),));




          }, child:Text("Not registered ? sign in ",style: TextStyle(color: Colors.white),)),

          Text(error,style: TextStyle(color: Colors.red),)

            ]
        ),
      ),
        )
      )
      
    );
  }
}