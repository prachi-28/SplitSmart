import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:split_smart/friends/read_users.dart';
import 'package:split_smart/friends/friendDivisionBar.dart';
import 'package:hexcolor/hexcolor.dart';

class Friends extends StatefulWidget {
  @override
  _FriendsState createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {

  ReadUsersClass _read = ReadUsersClass();


  @override
  Widget build(BuildContext context) {
    return Center(
      //color: Colors.red
      //child: Expanded(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                child: Text(
                  'Welcome to ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, left: 16, right: 16),
                child: Text(
                  'SplitSmart',
                  style: TextStyle(
                    color: HexColor("#e16428"),
                    fontSize: 35,
                  ),
                ),
              )
              ,
              /*Padding(
                padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                child: Opacity(
                  opacity: 0.5,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search...",
                      hintStyle: TextStyle(color: Colors.grey.shade600),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey.shade600,
                        size: 20,
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      contentPadding: EdgeInsets.all(8),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.grey.shade100)),
                    ),
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Container(
                    height: 75,
                    child: FDivisionBarClass(),
                  )
              ),*/
              Padding(
                padding: EdgeInsets.all(20.0),
                child: _read.readFriends(),
                ),
            ]),
      //),
    );
  }
}
