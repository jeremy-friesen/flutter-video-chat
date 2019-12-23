import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class GroupModel {
  final databaseReference = Firestore.instance; 
  
  Future<int> insertGroup(Group group) async {
    await databaseReference.collection("Groups")
      .document(group.groupId).setData(group.toMap());
  }

  Future<int> updateGroupName(Group group) async {
    await databaseReference.collection('Groups').document(group.groupId).updateData({
      "Name":group.groupName,
    });
    return 1;
  }

  Future<int> deleteTodo(String sid) async {
    try{
      databaseReference.collection('Groups')
      .document(sid).delete();
    }catch(e){
      print(e);
    }
    return 0; 
  }

  void getAllGroups() {
    databaseReference.collection('Groups')
    .getDocuments().then((QuerySnapshot snapshot){
      snapshot.documents.forEach((f)=> print('{f.data}')); 
    });
  }
}

class Group{
  String groupId;
  //final String groupIconPath;
  String groupName;
  //var lastMessageTime;
  List<int> memberIDs;

  DocumentReference documentReference; 

  Group({this.groupId, this.groupName, this.memberIDs});

  Group.fromMap(Map<String,dynamic> map,{this.documentReference}) {
    this.groupId = map['id'];
    this.groupName = map['name'];
    this.memberIDs = map['member_ids'];
  }

  Map<String,dynamic> toMap() {
    return {
      'id': this.groupId,
      'name': this.groupName,
      'member_ids': this.memberIDs,
    };
  }
}