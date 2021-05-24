import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:split_smart/models/user.dart';
import 'package:split_smart/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'addTransaction.dart';

class ReadUsersClass {

  ReadUsersClass();
  //final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //TODO: set to current email ID
  final FirebaseAuth auth = FirebaseAuth.instance;
  User user = FirebaseAuth.instance.currentUser;
  //String docID = "random@gmail.com";



  final Stream<QuerySnapshot> _usersStream =
  FirebaseFirestore.instance.collection('users').snapshots();

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  StreamBuilder readUser() {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
        return Container(
          height: 200,
          width: 300,
          child: ListView(
            children: snapshot.data.docs.map((DocumentSnapshot document) {
              return new ListTile(
                title: new Text(document.data()['name']),
                subtitle: new Text(document.data()['email']),
              );
            }).toList(),
          ),
        );
      },
    );
  }
  StreamBuilder readFriends() {
    String docID = user.email;

    Stream<QuerySnapshot> _friendsStream =
    FirebaseFirestore.instance.collection('users').doc(docID).collection('friends').snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: _friendsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
        return Container(
          height: 200,
          width: 500,
          child: ListView(
            children: snapshot.data.docs.map((DocumentSnapshot document) {
              return new ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => addTransactionFriend(email: document.data()['femail'])
                    ),
                  );
                },
                title: new Text(document.data()['fname']),
                subtitle: new Text(document.data()['femail']),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
