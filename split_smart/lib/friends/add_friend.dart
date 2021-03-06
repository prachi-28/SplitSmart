import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:split_smart/services/createfriend.dart';
import 'package:split_smart/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddFriends extends StatefulWidget {
  @override
  _AddFriendsState createState() => _AddFriendsState();
}

class _AddFriendsState extends State<AddFriends> {

  String findEmail;
  final CreateFriendService _createFriendService = CreateFriendService();

  final resetText = TextEditingController();
  void clearText() {
    resetText.clear();
  }

  // to find the current user's email
  final FirebaseAuth auth = FirebaseAuth.instance;
  User user = FirebaseAuth.instance.currentUser;
  String currUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Add Friend'),
      ),
      body: Container(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 16, left: 16, right: 16),
          child: TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Email',
              //hintText: 'Enter a valid email id',
            ),
            validator: (val) => val.isEmpty ? 'Enter an email' : null,
            onChanged: (val) {
              setState(() {
                findEmail = val;
              });
            },
            controller: resetText,
          ),
        ),
        SizedBox(height: 20,),
        SizedBox(
          width: 300,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              //primary: Colors.pink,
            ),
            //color: Colors.blueGrey,
            child: Text(
              'Search',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: () {
                _createFriendService.findUser(findEmail);
                _createFriendService.twoWayAdd(findEmail);
                clearText();
                Fluttertoast.showToast(
                    msg: "Friend Added",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.black12,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
              }
          ),
        ),
      ]),
    ),
    );
  }
}
