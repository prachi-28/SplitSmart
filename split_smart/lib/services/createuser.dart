import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:split_smart/models/user.dart';
import 'package:split_smart/services/auth.dart';

class CreateUserService {
  //called on registration to set up new document under user collection
  //document ID of new document is the email ID entered on Registration -- guaranteed unique value
  CreateUserService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future addUser(String email, String name, double owed, double owes) async {
    // creates new user with document ID = email ID
    await _firestore
        .collection('users')
        .doc(email)
        .set({
      'email': email,
      'name': name, // John Doe
      'owed': owed, // initially 0
      'owes': owes, // initially 0
    })
        .then((value) {
          print("Added User");
          //TODO: find more efficient way to send email ID
        })
        .catchError((error) => print("Failed to add user: $error"));
  }
}
