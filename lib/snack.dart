import 'package:flutter/material.dart';

//in its own file to call from multiple classes
void snack(BuildContext context, String message){
  Scaffold.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}