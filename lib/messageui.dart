import 'package:flutter/material.dart';

class MessageUI extends StatelessWidget {
  final String user;
  final String text;
  final String picture;
  final String date;
  
  // isMe is used to determine which type of messageUI to use,
  // since there are differences to how messages look when you're the sender
  bool isMe;

  MessageUI({this.user, this.text, this.picture, this.date, this.isMe});

  @override
  Widget build(BuildContext context) {
    
    final Container msg = Container(
      margin: isMe
      ? EdgeInsets.only(
        top: 8.0,
        bottom: 8.0,
        left: 80.0,
      )
      : EdgeInsets.only(
        top: 8.0,
        bottom: 8.0,
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      width: MediaQuery.of(context).size.width * 0.60,
      decoration: BoxDecoration(
        color: isMe ? Color(0xFFC9F9AF) : Color(0xFFFFEFEE),
        borderRadius: isMe
        ? BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
          bottomLeft: Radius.circular(15.0),
        )
        : BorderRadius.only(
          topRight: Radius.circular(15.0),
          topLeft: Radius.circular(15.0),
          bottomRight: Radius.circular(15.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            user,
            style: TextStyle(
              color: Colors.black.withOpacity(0.5),
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
              
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            text,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
    if (isMe) { // to print user's messages on right side
      return Padding(
        padding: const EdgeInsets.all(3.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,

          children: <Widget>[
            Container(
              padding: EdgeInsets.all(2.0),
              child: Row(
                children: <Widget>[
                  msg,
                ]
              )
            ),
            Container(
              padding: EdgeInsets.all(2.0),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.green[200],
                    backgroundImage: picture != null && NetworkImage(picture) != null? 
                                    NetworkImage(picture) : null,
                  )
                ]
              )
            ),
          ],
        ),
      );
    }
    return Padding( // to print other member's messages on right side
      padding: const EdgeInsets.all(3.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,

        children: <Widget>[
          Container(
            padding: EdgeInsets.all(2.0),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  backgroundImage: picture != null ? NetworkImage(picture) : null,
                )
              ]
            )
          ),
          Container(
            padding: EdgeInsets.all(2.0),
            child: Row(
              children: <Widget>[
                msg,
              ]
            )
          ),
        ],

      ),
    );
  }
}