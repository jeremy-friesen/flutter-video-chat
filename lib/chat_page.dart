import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:provider/provider.dart';
import 'package:video_chat/Auth/auth.dart';
import 'messageui.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Model/user.dart';
import 'package:flushbar/flushbar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'page_navigator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:date_format/date_format.dart';

class ChatPage extends StatefulWidget {
  String groupId;
  final User user;
  PageNavigatorState pageNavigatorState;
  String groupName;

  ChatPage({this.groupId, this.user, this.pageNavigatorState, this.groupName});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with AutomaticKeepAliveClientMixin<ChatPage>{
  //Going to be used for firebase
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();

  //Google services
  final Firestore _firestore = Firestore.instance;
  final AuthService _auth = AuthService();
  @override
  bool get wantKeepAlive => true;
  //Init statment to setup the notifiactions
   void initState(){
    super.initState();
    registerNotification();
    configLocalNotification();
  }
  
  /*Notificiations ---------------------------------------------------- */

  void registerNotification() {
    firebaseMessaging.requestNotificationPermissions();
    firebaseMessaging.configure(onMessage: (Map<String, dynamic> message) {
      print('onMessage: $message');
      showNotification(message['notification']);
      return;
    }, onResume: (Map<String, dynamic> message) {
      print('onResume: $message');
      return;
    }, onLaunch: (Map<String, dynamic> message) {
      print('onLaunch: $message');
      return;
    });
    

    firebaseMessaging.getToken().then((token){
      print('token: $token');
      Firestore.instance.collection('Users').document(widget.user.uid).updateData({'pushToken': token});
    }).catchError((err) {
      Fluttertoast.showToast(msg: err.message.toString());
    });
  }

  //For Local Notifications
  void configLocalNotification() {
    var initializationSettingsAndroid = new AndroidInitializationSettings('mipmap/ic_launcher');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(initializationSettingsAndroid, initializationSettingsIOS);
    _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  //Displaying the notification
  void showNotification(message) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      'com.example.video_chat',
      'Flutter chat demo',
      'your channel description',
      playSound: true,
      enableVibration: true,
      importance: Importance.Max,
      priority: Priority.High,
    );
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics =
        new NotificationDetails(androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await _flutterLocalNotificationsPlugin.show(
        0, message['title'].toString(), message['body'].toString(), platformChannelSpecifics,
        payload: json.encode(message));
  }

  /*Notificiations End---------------------------------------------------- */

  @override
  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();

  Future<void> callback() async {
    String text = messageController.text;
    if (text.length > 0) {
      await _firestore.collection('Groups').document(widget.groupId).collection("messages").add({
        'text': text,
        'email': widget.user.email,
        'date': DateTime.now().toIso8601String().toString(),
        'from': widget.user.email, 
        'uid': widget.user.uid,
        'username': widget.user.userName,
        'picture': widget.user.picture,
      });
      messageController.clear();
      scrollController.animateTo(
        scrollController.position.minScrollExtent,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 300),
      );
    }
    _updateGroupPageText(widget.groupId, widget.user.userName, text, formatDate(DateTime.now(),[yy,'-',M,'-',d,'-',hh,":",nn,am]).toString());
  }

  _updateGroupPageText(String groupid, String lastUser, String lastMessage, String time){
    if(lastMessage.length > 20){
      lastMessage = lastMessage.substring(0, 20)+ "...";
    }
    Firestore.instance.collection('Groups').document(groupid).updateData({
      'lastUser': lastUser, 
      'time':time, 
      'lastMessage':lastMessage});
  }

  DocumentReference getGroup(){
    return _firestore.collection('Groups').document(widget.groupId);
  }

  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
      
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        title: Text(
          widget.groupName != null ? widget.groupName : "Chat",
          style: TextStyle(color: Colors.white,)
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.video_call, color: Colors.white,),
            onPressed: (){
              widget.pageNavigatorState.setPage(2);
            },
            iconSize: 35.0,
          ),
        ],
      ),
      body: Container(
        child: (){
          if(widget.groupId == null){
            return Center(child: Text(FlutterI18n.translate(context, 'app.selectgroup'),textAlign: TextAlign.center,),);
          }else {
            return Column(
              children: <Widget>[
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: _firestore.collection('Groups').document(widget.groupId).collection("messages").orderBy('date').snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData){
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      List<DocumentSnapshot> docs = snapshot.data.documents;

                      List<Widget> messages = docs.map(
                        (doc) { 
                          print(doc.data['uid']);
                          if(doc.data['uid'] == null){
                            return MessageUI(
                              user: doc.data['from'],
                              text: doc.data['text'],
                              picture: null,
                              date: doc.data['date'],
                              isMe: user.email == doc.data['email'],
                            );
                          }
                          return MessageUI(
                            text: doc.data['text'],
                            user: doc.data['username'] != null ? doc.data['username'] : "noUsername",
                            picture: doc.data['picture'],
                            date: doc.data['date'],
                            isMe: user.email == doc.data['email'],
                          );
                        }).toList();
                      
                      return ListView(
                        controller: scrollController,
                        children: messages.reversed.toList(),
                        reverse: true,
                      );
                    }
                  )
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10.0,0.0,10.0,10.0), 
                  child:Container(
                    padding: EdgeInsets.fromLTRB(10.0,0.0,0.0,0.0), 
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(),
                      boxShadow: [BoxShadow(blurRadius: 1.0)]
                    ),
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: TextField(
                            controller: messageController,
                            onSubmitted: (value) => callback(),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: FlutterI18n.translate(context, 'app.writeamessage')
                            ),
                          ),
                        ),
                        FlatButton(
                          padding: EdgeInsets.all(0),
                          onPressed: callback,
                          child: Icon(Icons.send, color: Colors.blue,),
                          clipBehavior: Clip.none,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
        }(),
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

  void refresh(){
    sleep(const Duration(seconds: 1));
    setState(() {});
  }

  /*Future<String> getName(String email) async {
    //if(_firestore.collection('Users').)
    //print('email ' + doc.data['email'] + 'is not in the database');
    //return 'email = ' + doc.data['email'];
    var userQuery = _firestore.collection('Users').where('email', isEqualTo: email).limit(1);
    return userQuery.getDocuments().then((data){ 
      if (data.documents.length > 0 && data.documents[0].data['username'] != null){
        return data.documents[0].data['username'];
      } else{
        return 'username == null';
      }
    });
    //return doc.data['from'];
  }*/
}