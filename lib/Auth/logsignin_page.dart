import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'login.dart';
import 'register.dart';

//The main page of the sign it, this is where the user can either choose join or leave after
class LogsignIn extends StatelessWidget {
  //This id is the "HOMESCREEN" of the applications
  static const String id = "HOMESCREEN";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:Center( 
      //the widgets of the app, logo, text, and two buttons go in
        child:
        Stack(
          children: <Widget>[
            //For the image
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: new DecorationImage(
                  image: AssetImage("assets/images/huddleBackground.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      //Logo
                      Hero(
                        tag: 'logo',
                        child: Container(
                          width: 200.0,
                          child: Image.asset("assets/images/huddleLogo.png")
                        ),
                      ),
                      SizedBox(height: 40.0),           
                    ],
                  ),
                  //Seperates the space between the chat and the buttons
                  SizedBox(height: 25.0),
                  Text(
                    FlutterI18n.translate(context, 'app.connectwithothers'),
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 22.5, 
                      fontWeight: FontWeight.w900
                    ),
                  ),
                  SizedBox(height: 25.0),
                  //Navigates to the login page
                  LogSigninButtons(
                    text: FlutterI18n.translate(context, 'app.login'),
                    callback: (){
                      Navigator.of(context).pushNamed(Login.id);
                    },
                  ),

                  SizedBox(height: 15.0),
                  //Navigates to the register page
                  LogSigninButtons(
                    text: FlutterI18n.translate(context, 'app.register'),
                    callback: (){
                      Navigator.of(context).pushNamed(Register.id);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//Creating the button
class LogSigninButtons extends StatelessWidget {

  final VoidCallback callback;
  final String text;

  const LogSigninButtons({Key key, this.callback, this.text}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    //Using a container so you can use the padding
    return Container(
      padding: EdgeInsets.all(10),
      //Customizing the button for visual purposes 
      child: Opacity(
        opacity: 0.8,
        child: Material(
          elevation: 6.0,
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.white,
          child: MaterialButton(
            //The callback is the function where it navigates through each page
            onPressed: callback,
            minWidth: 200.0,
            height: 50.0,
            child: Text(
              text, 
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 22.5, 
                fontWeight: FontWeight.w500
              ),
            ),
          ),
        ),
      ),
    );
  }
}

