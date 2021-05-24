import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:split_smart/models/user.dart';
import 'package:split_smart/services/auth.dart';
//import 'package:split_smart/services/auth.dart;
import 'package:split_smart/groups/make_group.dart';

class ReadGroupsClass {
  ReadGroupsClass();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String docID = "random@gmail.com";
  //TODO: set to current email ID

  final Stream<QuerySnapshot> _usersStream =
  FirebaseFirestore.instance.collection('users').snapshots();

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  StreamBuilder readGroups() {
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
          height: 200,
          width: 500,
          child: ListView(
            children: snapshot.data.docs.map((DocumentSnapshot document) {
              return new ListTile(
                title: new Text(document.data()['groupName']),
                subtitle: new Text('Owed: ${document.data()['totalOwed']}   |   You Owe: ${document.data()['totalOwes']}'),
              );
            }).toList(),
          ),
        );
      },
    );
  }



}
