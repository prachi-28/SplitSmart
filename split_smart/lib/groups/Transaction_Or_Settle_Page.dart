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
import 'package:split_smart/groups/addGroupTransaction.dart';
import 'package:split_smart/groups/GroupData.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
User user = FirebaseAuth.instance.currentUser;
GroupData _groupData = new GroupData();

class GroupMiddlePage extends StatefulWidget {
  @override
  _GroupMiddlePageState createState() => _GroupMiddlePageState();
}

class _GroupMiddlePageState extends State<GroupMiddlePage> {

  String docID = user.email; //currentUser's document ID
  String gName = _groupData.returnGroupName();
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  void initState() {
    setState(() {
      _groupData.memberEmails(gName);
      print("BACK!");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      //CALL SET MEMBER EMAILS
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 300.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                child: Center(
                  child: Text("Group : ${gName}",
                    style: TextStyle(
                      //color: Colors.black,
                      fontSize: 22.0,
                    ),
                  ),
                ),
              ),
              Container(
                child: ElevatedButton(
                    child: Text(
                      'Add Transaction',
                    ),
                    onPressed: () {
                      setState(() {
                        //print(gName);
                        //_groupData.memberEmails(gName);
                        //print(_groupData.returnEmail());
                        //_groupData.memberEmails(gName);
                      });
                      print(_groupData.returnEmail());
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddGroupTransactionClass()
                        ),
                      );
                    }
                ),
              ),
              Container(
                child: ElevatedButton(
                    child: Text(
                      'Settle Up',
                    ),
                    onPressed: () {
                      /*Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddGroupTransactionClass()
                        ),
                      );*/
                    }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
