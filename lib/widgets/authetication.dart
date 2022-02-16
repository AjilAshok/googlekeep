import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class Authservice {
  final FirebaseAuth _auth = FirebaseAuth.instance;
// get user =>_auth.currentUser;

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      print(user);



      return user;
      
    } catch (e) {
      print(e.toString());
      print('dataanpte');
    }
  }

  Future loginInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      var user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return user;
    } catch (e) {
      print(e.toString());
    }
  }

  signout()async{
   await _auth.signOut();
  }
}
