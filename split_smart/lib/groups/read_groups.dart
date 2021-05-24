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

class ReadGroupsClass {

  GroupDivBarValuesClass _valuesClass = new GroupDivBarValuesClass();
  ReadGroupsClass();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final FirebaseAuth auth = FirebaseAuth.instance;
  User user = FirebaseAuth.instance.currentUser;

  final Stream<QuerySnapshot> _usersStream =
  FirebaseFirestore.instance.collection('users').snapshots();

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  StreamBuilder readGroups() {
    String docID = user.email;
    Stream<QuerySnapshot> _friendsStream = FirebaseFirestore.instance
        .collection('users')
        .doc(docID)
        .collection('groups')
        .snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: _friendsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        if (snapshot.data.docs.length == 0) {
          return Text("No Groups");
        }
        return Container(
          height: 400,
          width: 500,
          child: ListView(
            children: snapshot.data.docs.map((DocumentSnapshot document) {
              return new ListTile(
                onTap: () {
                  /*Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => addTransactionFriend(email: document.data()['groupName'])
                    ),
                  );*/
                  int owes = (document.data()['totalOwes'] as num);
                  int owed = (document.data()['totalOwed'] as num);
                  calcOwe();
                },
                title: new Text(document.data()['groupName']),
                subtitle: new Text('Owed: ${document.data()['totalOwed']}   |   You Owe: ${document.data()['totalOwes']}'),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  void calcOwe() {

    String docID = user.email;

    double owes = 0, owed = 0;
    int temp;
    users
        .doc(docID)
        .collection('groups')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print(doc['groupName']);
        temp = doc['totalOwes'] as num;
        owes = temp.toDouble() + owes;
        temp = doc['totalOwed'] as num;
        owed = temp.toDouble() + owed;
      });
    });
    _valuesClass.setOwes(owes);
    _valuesClass.setOwed(owed);
  }
}
