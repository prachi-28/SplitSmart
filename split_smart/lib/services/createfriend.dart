import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:split_smart/models/user.dart';
import 'package:split_smart/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';


class CreateFriendService {

  CreateFriendService();



  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final FirebaseAuth auth = FirebaseAuth.instance;
  User user = FirebaseAuth.instance.currentUser;


  twoWayAdd(String findEmail)
  {
    String docID = findEmail;
    _firestore
        .collection('users')
        .doc(user.email)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document exists on the database');
        createFriendSubCollectionTwoWay(docID, documentSnapshot['email'], documentSnapshot['name']);
        //return true;
      }
      else {
        print("Document does not exist");
        //return false;
      }
    });
  }
  // this function is for two way add
  Future createFriendSubCollectionTwoWay(String docID, String fEmail, String fName) async {
    //adds friends sub collection to the new user
    //String docID = user.email;
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


  findUser(String searchValue) {
    //print(_docID.getEmail());
    String docID = user.email;
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
    String docID = user.email;
    int fOwes = 0, fOwed = 0;
    FirebaseFirestore
        .instance
        .collection('users')
        .doc(docID)
        .set({
      'femail': fEmail, 'fname': fName, 'fowes'
          : fOwes, 'fowed': fOwed
    });
    print("Sub Collection Created");
  }
}