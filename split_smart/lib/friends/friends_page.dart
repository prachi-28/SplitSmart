import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:split_smart/friends/read_users.dart';

class Friends extends StatefulWidget {
  @override
  _FriendsState createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {
  //TODO: set owe and owed to values of current user
  int _owe = 0;
  int _owed = 0;
  double _percent = 0.8;

  ReadUsersClass _read = ReadUsersClass();

  @override
  Widget build(BuildContext context) {
    return Center(
      //color: Colors.red,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            Padding(
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      height: 75,
                      width:
                          (MediaQuery.of(context).size.width - 60) * _percent,
                      decoration: BoxDecoration(
                        color: HexColor("#56B43C"), //green
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: Text(_owed.toString()),
                      )),
                  Container(
                    height: 75,
                    width: 10,
                  ),
                  Container(
                    height: 75,
                    width: (MediaQuery.of(context).size.width - 60) *
                        (1 - _percent),
                    decoration: BoxDecoration(
                      color: HexColor("#B52B45"), //red
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Center(
                      child: Text(_owe.toString()),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              //TODO: add readFriends() here
              child: _read.readFriends(),
              ),
          ]),
    );
  }

  void onTransactionUpdate(int owe, int owed) {
    setState(() {
      _owe = owe;
      _owed = owed;
      _percent = owe / (owe + owed);
    });
  }
}
