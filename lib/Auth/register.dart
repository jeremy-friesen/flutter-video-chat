import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:video_chat/page_navigator.dart';

import 'package:flutter/material.dart';
import 'package:video_chat/Auth/auth.dart';
import 'package:flushbar/flushbar.dart';

// The Sign in and Register Widgets

//REGISTER
class Register extends StatefulWidget {
  static const String id = 'REGISTER';
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //Getting the class AuthService from Services/auth.dart
  final AuthService _auth = AuthService();
  //Creating a form key used in validation
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Creating an AppBar so the user can go back to the main page
      backgroundColor: Colors.green[400],
      //Where all the widgets of the page is in
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 15.0,  left: 10.0),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                IconButton(
                icon: Icon(Icons.arrow_back),
                color: Colors.white,
                iconSize: 30,
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
              Container(
                width: 300,
                padding: EdgeInsets.only(top: 5.5, left: 70.0),
                child: Text(
                  FlutterI18n.translate(context, 'app.joinus'),
                  style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Montserrat',
                  fontSize: 25.0, 
                  ),
                ),
              ),
            ], 
          ),
        ),
        SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(75.0)),
            ),
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
          //Creating a form where you can use validations (validations tell the user what is wrong with the information they are putting in)
          child: Form(
            key: _formKey,
            child: (Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 10.0,),
                //The LOGO
                Hero(
                  tag: 'logo',
                  child: Container(
                    width: 150.0,
                    child: Image.asset("assets/images/huddleLogo.png")
                  ),
                ),
                //USERNAME section
                SizedBox(height: 20.0,),
                Text(
                  FlutterI18n.translate(context, 'app.email'),
                    style: TextStyle(
                    color: Color(0xff0E6D6A),
                    fontFamily: 'IndieFlower',
                    fontSize: 25.0, 
                  ),
                ),
                TextFormField(
                  //If the user does not put an email, the validation will tell them to enter an email
                  validator: (val) => val.isEmpty ? FlutterI18n.translate(context, 'app.enteranemail'): null,
                  onChanged: (val){
                    setState(() => email = val);
                  },
                ),
                //PASSWORD section
                SizedBox(height: 30.0,),
                Text(
                  FlutterI18n.translate(context, 'app.password'),
                    style: TextStyle(
                    color: Color(0xff0E6D6A),
                    fontFamily: 'IndieFlower',
                    fontSize: 25.0, 
                  ),
                ),
                TextFormField(
                  //If the user does not put a character with 8 or more characters it
                  validator: (val) => val.length <= 3 ? FlutterI18n.translate(context, 'app.enterapassword'): null,
                  obscureText: true,
                  onChanged: (val){
                    setState(() => password = val);
                  },
                ),
                //REGISTERING IN
                SizedBox(height: 50.0,),
                RaisedButton(
                  color: Colors.green[700],
                  child: Text(
                    FlutterI18n.translate(context, 'app.register'),
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'IndieFlower',
                      fontSize: 20.0, 
                      ),
                  ),
                  onPressed: () async{
                    //Sending it to firebase so you can check with the system if the email and password is valid
                    if (_formKey.currentState.validate()){
                      //getting the results from firebase auth
                      dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                      if(result == null){
                        //If the email is not valid
                        setState(() => error = FlutterI18n.translate(context, 'app.pleaseenteravalidemail'));
                      }
                      //Sending them to the main menu of the chat
                      else{
                        Navigator.pop(context);
                        showSimpleFlushBar(context, FlutterI18n.translate(context, 'app.succesfullyregisteredanaccount'));
                        // experimental:
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PageNavigator(),
                          ),
                        );
                      }
                    }
                  },
                ),
                //Returning the error from firebase in text form
                SizedBox(height: 12.0,),
                Text(
                  error, 
                  style: TextStyle(color: Colors.red, fontFamily: 'IndieFlower'),
                )
              ],
            )),
          ),
        ),
      ),
      ],
      ),
    );
  }
  //Simple flushbar
  void showSimpleFlushBar(BuildContext context, String message){
    Flushbar(
      message: message,
      duration: Duration(seconds: 3),
      backgroundColor: Colors.green,
    )..show(context);
  }
  
}