import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:split_smart/services/createfriend.dart';
import 'package:split_smart/home/home.dart';

class AddFriends extends StatefulWidget {
  @override
  _AddFriendsState createState() => _AddFriendsState();
}

class _AddFriendsState extends State<AddFriends> {

  String findEmail;
  final CreateFriendService _createFriendService = CreateFriendService();

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
              }
          ),
        ),
      ]),
    ),
    );
  }
}
