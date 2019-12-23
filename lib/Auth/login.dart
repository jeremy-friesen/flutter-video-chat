import 'package:flutter_i18n/flutter_i18n.dart';

import 'package:flutter/material.dart';
import 'package:video_chat/Auth/auth.dart';

//LOGIN
class Login extends StatefulWidget {
  static const String id = "LOGIN";
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //Getting the class from Services/auth.dart
  final AuthService _auth = AuthService();
  //Getting a formkey for the validation section
  final _formKey = GlobalKey<FormState>();

  //Text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.green[400],
      body: ListView(
        children:<Widget>[
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
                  padding: EdgeInsets.only(top: 5.5, left: 35.0),
                  child: Text(
                    FlutterI18n.translate(context, 'app.welcomeback'),
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
            child:Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(75.0)),
              ),
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
              //Using the Form widget to create a validation for when the user inputs data
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    //Size box to make a space between
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
                      //The validation error where if the user types an empty string
                      validator: (val) => val.isEmpty ? FlutterI18n.translate(context, 'app.enteranemail'): null,
                      textAlign: TextAlign.center,
                      onChanged: (val){
                        //Making the email variable be the value entered
                        setState(() => email = val);
                      },
                    ),
                    //PASSWORD section
                    SizedBox(height: 30.0),
                    Text(
                      FlutterI18n.translate(context, 'app.password'),
                        style: TextStyle(
                        color: Color(0xff0E6D6A),
                        fontFamily: 'IndieFlower',
                        fontSize: 25.0, 
                      ),
                    ),
                    TextFormField(
                      //The validation error if the user types in a password with less than 8 characters
                      validator: (val) => val.length < 3 ? FlutterI18n.translate(context, 'app.enterapassword'): null,
                      textAlign: TextAlign.center,
                      obscureText: true,
                      onChanged: (val){
                        //making the password variable be the value entered
                        setState(() => password = val);
                      },
                    ),
                    //SIGNING IN
                    SizedBox(height: 50.0,),
                    RaisedButton(
                      color: Colors.green[700],
                      child: Text(
                        FlutterI18n.translate(context, 'app.login'),
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'IndieFlower',
                          fontSize: 20.0, 
                        ),
                      ),
                      //When the presses the button and sends the email information to the firebase auth
                      onPressed: () async{
                        //This will check if the user has sent a valid email and password
                        if (_formKey.currentState.validate()){
                          //Sending the information and checking if the information given is correct
                          dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                          //If the infomration is wrong
                          if(result == null){
                            setState(() => error = FlutterI18n.translate(context, 'app.emailpasswordincorrect'));
                          }
                          //Sending them to the main menu 
                          else{
                            Navigator.pop(context);
                            //snack(context, FlutterI18n.translate(context, 'app.loginsuccessful'));
                          }
                        }
                      },
                    ),
                    //Making the space between the text and textfield
                    SizedBox(height: 12.0,),
                    //Giving the error from firebase to the bottom of the screen
                    Text(
                      error, 
                      style: TextStyle(color: Colors.red, fontFamily: 'IndieFlower'),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
