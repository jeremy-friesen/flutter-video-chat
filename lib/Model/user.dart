import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class User{
  String email;
  final String uid;
  String userName;
  String picture;

  //This is to check if the user has its unique user name from firebase
  User({this.uid, this.email, this.userName, this.picture});
}

String formatTimeOfDay(TimeOfDay tod) {
  final now = new DateTime.now();
  final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
  final format = DateFormat.jm();  //"6:00 AM"
  return format.format(dt);
}

class UserModel {
  final int id; 
  final String iconPath;
  final String userName; 

  UserModel({this.id, this.iconPath, this.userName});
}