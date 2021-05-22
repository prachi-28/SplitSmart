import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:split_smart/models/user.dart';
import 'package:split_smart/services/auth.dart';

class CreateFriendService {

  CreateFriendService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //TODO: set DocID to current email ID
  String docID = "random@gmail.com";

  findUser(String searchValue) {
    //print(_docID.getEmail());
    _firestore
        .collection('users')
        .doc(searchValue)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document exists on the database');
        createFriendSubCollection(docID, documentSnapshot['email'], documentSnapshot['name']);
        //return true;
      }
      else {
        print("Document does not exist");
        //return false;
      }
    });
  }

  Future createFriendSubCollection(String docID, String fEmail, String fName) async {
    //adds friends sub collection to the new user
    int fOwes = 0, fOwed = 0;
    FirebaseFirestore
        .instance
        .collection('users')
        .doc(docID)
        .collection(
        "friends").doc(fEmail)
        .set({
      'femail': fEmail, 'fname': fName, 'fowes'
          : fOwes, 'fowed': fOwed
    });
    print("Sub Collection Created");
  }



}