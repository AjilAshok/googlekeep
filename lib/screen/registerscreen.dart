

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:googleclone/widgets/authetication.dart';

class registerscreen extends StatefulWidget {
  const registerscreen({ Key? key }) : super(key: key);

  @override
  _registerscreenState createState() => _registerscreenState();
}

class _registerscreenState extends State<registerscreen> {
  String error='';
  final Authservice _auth = Authservice();


   final _key = GlobalKey<FormState>();
    TextEditingController _emailContoller = TextEditingController();
  TextEditingController _passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor:Colors.black,
        body: Container(
          // color: Colors.black,
          child: Center(
            child: Form(child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Form(
                    key: _key,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextFormField(
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
                    ),
                  ),
                      SizedBox(height: 30),
                       Padding(
                         padding: const EdgeInsets.all(15.0),
                         child: TextFormField(
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
                       ),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(onPressed: ()async {
                           
                            if (_key.currentState!.validate()) {
                              dynamic result= await _auth.registerWithEmailAndPassword(_emailContoller.text, _passwordController.text);
                              if(result==null){
                                print('error');

                              }else{
                                _emailContoller.clear();
                                _passwordController.clear();
                              }
                              
                            } 
                          
                            
                           
                          }, child:Text("Sign in")),
                    
                       ElevatedButton(onPressed: (){
                         Navigator.pop(context);
                       }, child:Text("Cancle"))
                           ],
                      ),
                      Text(error,style: TextStyle(color: Colors.red),)
              ],
            ) 
            ),
          ),
        ),
        
      ),
    );
  }
  
}