import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:split_smart/models/user.dart';
import 'package:split_smart/services/auth.dart';

class CreateGroupService {

  CreateGroupService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //TODO: set DocID to current email ID
  String docID = "random@gmail.com";
  String docName = "HELLO";

  Future createGroupCollection(String groupName, String userID) async {
    FirebaseFirestore
        .instance
        .collection('users')
        .doc(userID)
        .collection('groups')
        .doc(groupName)
        .set({
      'groupName': groupName,
      'totalOwed': 0,
      'totalOwes': 0,
    });
  }

  void allMemberInfo(String groupName, List<String> emails) {

    emails.add(docID);
    print(emails);

    int len = emails.length;

    for (int i=0 ; i<len ; i++ ) {
      print(emails[i]);
      createGroupCollection(groupName, emails[i]); //create group for each membber

      for (int j=0 ; j<len ; j++) {
        findMemberInfo(groupName, emails[i], emails[j]);
      }
    }
  }

  void findMemberInfo(String groupName, String uEmail, String fEmail) {

    _firestore
        .collection('users')
        .doc(fEmail)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
        addGroupMembers(uEmail, groupName, fEmail, documentSnapshot['name']);
        //addGroupMembers(femail, groupName, femail, documentSnapshot['fname']);
        print("Member Added");
    });
  }

  Future addGroupMembers(String userID, String groupName, String memail, String mname) async {

    FirebaseFirestore
        .instance
        .collection('users')
        .doc(userID)
        .collection('groups')
        .doc(groupName)
        .collection('members')
        .doc(memail)
        .set({
      'memail': memail, 'mname': mname, 'mowed': 0, 'mowes': 0,
    });
    print("Sub Collection Created");
  }
}