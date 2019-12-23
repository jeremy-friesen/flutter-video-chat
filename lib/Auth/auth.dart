import 'package:firebase_auth/firebase_auth.dart';
import 'package:video_chat/Model/user.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  //creating a user object based on the firebase user class
  User userFromFirebaseUser(FirebaseUser user){
    return user != null ? User(uid: user.uid, email: user.email) : null;
  }

  //Allowing us to see if the user is signed in or not
  Stream<User> get user{
    return _auth.onAuthStateChanged.map(userFromFirebaseUser);
  }
  
  //Sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async{
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }
  //Register with email & password
  Future registerWithEmailAndPassword(String email, String password) async{
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}


