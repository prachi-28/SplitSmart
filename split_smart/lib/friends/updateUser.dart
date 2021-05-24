import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:split_smart/models/user.dart';
import 'package:split_smart/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'settleUpPage.dart';

class updateUserAmount{

  updateUserAmount();

  //paidByEmail -> email of the person who paid the bill
  //oweEmail -> email of the person who owes money to the person who paid the bill
  updateAmount(String paidByEmail, String oweEmail, double amount)
  {

    String docID = paidByEmail;
    int fOwed = (amount/2).toInt();
    FirebaseFirestore
        .instance
        .collection('users')
        .doc(docID)
        .update({"owed":fOwed}
        );
    print("Update successful");

    docID = oweEmail;
    int fOwes = (amount/2).toInt();
    FirebaseFirestore
        .instance
        .collection('users')
        .doc(docID)
        .update({"owes":fOwes}
    );
    print("Update successful");


  }

}