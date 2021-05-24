import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:split_smart/models/user.dart';
import 'package:split_smart/services/auth.dart';
//import 'package:split_smart/services/auth.dart;
import 'package:split_smart/groups/make_group.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/groupDivBarValues.dart';
import 'package:split_smart/groups/GroupData.dart';
import 'package:fluttertoast/fluttertoast.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
User user = FirebaseAuth.instance.currentUser;
GroupData _groupData = new GroupData();

class UpdateGroupClass {

  String docID = user.email; //currentUser's document ID
  String gName = _groupData.returnGroupName();

  List<double> _paidAmts = new List<double>();
  double _userAmt;
  List<double> _memberOwes = new List<double>();

  double Sum(double a, double b) {
    return a + b;
  }

  Future<void> initState() async {
    //set values in _paidAmts as total (current owe + new owe)
    print(_groupData.returnEmail().length);
    for (int memberID = 0; memberID < _groupData.returnEmail().length; memberID++) {
      _paidAmts.add(0.0);
      _memberOwes.add(0.0);
      if (docID == _groupData.returnEmail()[memberID]) {
        //for current user: _paidAmt now becomes total owed value
        await FirebaseFirestore.instance
            .collection('users')
            .doc(docID)
            .collection('groups')
            .doc(gName)
            .collection('members')
            .doc(_groupData.returnEmail()[memberID])
            .get()
            .then((DocumentSnapshot documentSnapshot) {
          if (documentSnapshot.exists) {
            //print("PREV OWED: ");
            //print(documentSnapshot.data()['mowed']);
            _userAmt = (documentSnapshot.data()['mowed']).toDouble();
          }
        });
        print("user owed: ");
        print(_userAmt);
      }
      else {
        //for other users, _paidAmt now becomes total owes value
        await FirebaseFirestore.instance
            .collection('users')
            .doc(docID)
            .collection('groups')
            .doc(gName)
            .collection('members')
            .doc(_groupData.returnEmail()[memberID])
            .get()
            .then((DocumentSnapshot documentSnapshot) {
          if (documentSnapshot.exists) {
            //print("mowes:");
            //print(documentSnapshot.data()['mowes']);
            _paidAmts[memberID] = documentSnapshot.data()['mowes'].toDouble();
            print("_paintAmts member:");
            print(_paidAmts[memberID]);
          }
        });

        await FirebaseFirestore.instance
            .collection('users')
            .doc(_groupData.returnEmail()[memberID])
            .collection('groups')
            .doc(gName)
            .collection('members')
            .doc(_groupData.returnEmail()[memberID])
            .get()
            .then((DocumentSnapshot documentSnapshot) {
          if (documentSnapshot.exists) {
            //print("mowes:");
            //print(documentSnapshot.data()['mowes']);
            _memberOwes[memberID] = documentSnapshot.data()['mowes'].toDouble();
            print("_memberOwes member:");
            print(_memberOwes[memberID]);
          }
        });
      }
    }
  }

  void updateAllGroups(List<double> _paidPerson, double _paidAmount) {

    initState();

    _userAmt = _userAmt.toDouble() + _paidAmount;

    for (int memberID = 0; memberID < _groupData.returnEmail().length; memberID++) {
      if (docID == _groupData.returnEmail()[memberID]){
        _userAmt = _userAmt - _paidPerson[memberID];
      }
       else {
        _paidAmts[memberID] = _paidAmts[memberID] + _paidPerson[memberID];
        _memberOwes[memberID] = _memberOwes[memberID] + _paidPerson[memberID];
      }
    }
      //update _paidAmts for each user other than current user
    for (int memberID = 0; memberID < _groupData.returnEmail().length; memberID++) {
      //in docID update all group member info
      if (docID == _groupData.returnEmail()[memberID]) {
        print('user owed 2:');
        print(_userAmt);
        FirebaseFirestore.instance
            .collection('users')
            .doc(docID)
            .collection('groups')
            .doc(gName)
            .collection('members')
            .doc(_groupData.returnEmail()[memberID])
            .update({'mowed': _userAmt});

        FirebaseFirestore.instance
            .collection('users')
            .doc(docID)
            .collection('groups')
            .doc(gName)
            .update({'totalOwed': _userAmt});

      }
      else {
        FirebaseFirestore.instance
            .collection('users')
            .doc(docID)
            .collection('groups')
            .doc(gName)
            .collection('members')
            .doc(_groupData.returnEmail()[memberID])
            .update({'mowes': _paidAmts[memberID]});

        FirebaseFirestore.instance
            .collection('users')
            .doc(_groupData.returnEmail()[memberID])
            .collection('groups')
            .doc(gName)
            .collection('members')
            .doc(docID)
            .update({'mowed': _paidAmts[memberID]});


        FirebaseFirestore.instance
            .collection('users')
            .doc(_groupData.returnEmail()[memberID])
            .collection('groups')
            .doc(gName)
            .collection('members')
            .doc(_groupData.returnEmail()[memberID])
            .update({'mowes': _memberOwes[memberID]});

        FirebaseFirestore.instance
            .collection('users')
            .doc(_groupData.returnEmail()[memberID])
            .collection('groups')
            .doc(gName)
            .update({'totalOwes': _memberOwes[memberID]});

      }

    }
  }
}
